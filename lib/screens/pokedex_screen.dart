import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:test_iquii/models/ability.dart';
import 'package:test_iquii/models/pokemon.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'package:test_iquii/providers/favorites_provider.dart';
import 'package:test_iquii/widgets/pokemon_overview_list.dart';

import '../models/pokemon_stats.dart';
import '../widgets/pokemon_overview_grid.dart';
//numero pokemon da caricare
const int pokemonNumberToLoad = 350;
//link dell'api
const String apiUrl = 'https://pokeapi.co/api/v2/pokemon/';
// link per l'immagine
const String urlImage =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/';
//screen principale
class PokedexScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends ConsumerState<PokedexScreen> {
  String? errorMessage;
  bool favoritesOnly = false;
  bool gridMode = false;
  bool loaded = false;
  List<int> pageRange = [
    1,
    51 > pokemonNumberToLoad ? pokemonNumberToLoad : 51
  ];
  bool search = false;
  //numero che incrementa per ogni pokemon caricato
  int loadingProgress = 0;
  //pokemon caricati
  List<Pokemon> loadedPokemon = [];
  //pokemon da visualizzare
  List<Pokemon> get pokemonDisplayed {
    return search
        ? loadedPokemon
            .where((element) =>
                element.name.contains(searchText) ||
                element.pokedexNumber.toString().contains(searchText) ||
                element.type.getLabel().contains(searchText))
            .toList()
        : favoritesOnly
            ? loadedPokemon
                .where((element) =>
                    ref.watch(favoritesData)[element.pokedexNumber - 1])
                .toList()
            : loadedPokemon.sublist(pageRange[0] - 1, pageRange[1] - 1);
  }

  String searchText = '';

  @override
  void initState() {
    caricaPokemon();
    super.initState();
  }
  //logica per il caricamento dei pokemon
  caricaPokemon() async {
    await ref.read(favoritesData.notifier).caricaLista();
    bool connesso = false;
    //verifico se il telefono è connesso a internet attraverso un tentativo di connessione
    try {
      bool errore = false;
      final result = await InternetAddress.lookup('google.com')
          .onError((error, stackTrace) {
        errore = true;
        throw error!;
      });
      print(result);
      if (!errore) {
        connesso = true;
      }
    } on SocketException catch (_) {
      print('not connected');
    }

    //carica lo storage solo se connesso
    final Reference? storageInstance =
        connesso ? FirebaseStorage.instance.ref('pokemon') : null;

    //il database funziona anche offline
    final databaseData = await FirebaseFirestore.instance
        .collection('pokemon')
        .doc('listaPokemon')
        .get();

    Directory appDirectory = await getApplicationDocumentsDirectory();

    for (int i = 1; i <= databaseData.data()!.length; i++) {

      //prima verifico l'esistenza del file dell'immagine sulla memoria e in caso negativo la carico da cloud_storage
      File file = File('${appDirectory.path}/.$i.png');
      if (connesso && !(await file.exists())) {
        var firebaseImage = storageInstance!.child('$i.png');
        await firebaseImage.writeToFile(file);
      }
      loadedPokemon.add(Pokemon.fromFirebase(
          //aggiungo manualmente il parametro "pokedexNumber"
          {...databaseData.data()![i.toString()], 'pokedexNumber': i}, file));
      setState(() {
        loadingProgress = i;
      });
    }
    int databaseMissingData = pokemonNumberToLoad - databaseData.data()!.length;

    // verifico se la lunghezza dei dati sui pokemon nel database è minore della lunghezza dei pokemon da caricare
    if (databaseMissingData != 0) {
      //verifico prima se c'è la connessione
      if (connesso) {
        for (int i = pokemonNumberToLoad - databaseMissingData + 1;
            i <= pokemonNumberToLoad;
            i++) {
          Map<dynamic, dynamic> pokemon =
              jsonDecode(await http.read(Uri.parse(apiUrl + i.toString())));
          //print(pokemon["abilities"]);
          List<Ability> abilitiesLoaded = [];
          for (dynamic ability in pokemon['abilities']) {
            Map<String, dynamic> abilityData = jsonDecode(
                await http.read(Uri.parse(ability['ability']['url'])));
            //print(abilityData['name']);
            //print(abilityData['effect_entries'][pokemon['abilities'].indexOf(ability)]);
            String nomeAbilita = abilityData['name'];
            List<dynamic> abilityDescriptionsRaw =
                abilityData['effect_entries'];
            var descrizioneAbilita = 'ERRORE';
            try {
              descrizioneAbilita = abilityDescriptionsRaw.firstWhere(
                  (element) => element['language']['name'] == 'en')['effect'];
            } catch (e) {}
            abilitiesLoaded.add(Ability(nomeAbilita, descrizioneAbilita));
            //print(abilityData.keys);
          }
          PokemonStats pokemonStats = PokemonStats();
          for (Map<String, dynamic> parameter in pokemon['stats']) {
            switch (parameter['stat']['name']) {
              case 'attack':
                pokemonStats.attack = parameter['base_stat'];
                break;
              case 'defense':
                pokemonStats.defense = parameter['base_stat'];
                break;
              case 'special-attack':
                pokemonStats.specialAttack = parameter['base_stat'];
                break;
              case 'special-defense':
                pokemonStats.specialDefense = parameter['base_stat'];
                break;
              case 'hp':
                pokemonStats.hp = parameter['base_stat'];
                break;
              case 'speed':
                pokemonStats.speed = parameter['base_stat'];
                break;
              default:
                break;
            }
          }
          var imageRequest = await http.readBytes(Uri.parse('$urlImage$i.png'));
          Directory appDirectory = await getApplicationDocumentsDirectory();
          print(appDirectory.path);
          File file = File(appDirectory.path + '/$i.png');
          file.writeAsBytes(imageRequest);
          await file.create();
          await storageInstance!.child('$i.png').putFile(file);
          await file.delete();
          Pokemon createdPokemon = Pokemon(
              name: pokemon['name'],
              type: getTypeEnum(pokemon['types'][0]['type']['name']),
              image: Image.network(
                '$urlImage$i.png',
                fit: BoxFit.cover,
              ),
              pokedexNumber: i,
              stats: pokemonStats,
              abilities: abilitiesLoaded);
          FirebaseFirestore.instance
              .collection('pokemon')
              .doc('listaPokemon')
              .update(createdPokemon.fireBaseFormat());
          loadedPokemon.add(createdPokemon);

          setState(() {
            loadingProgress = i;
          });
        }//se ci sono dati mancanti nel database e non c'è nessuna connessione faccio visualizzare un messaggio di errore
      } else
        setState(() {
          errorMessage = 'Check your connection for first run';
        });
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: search
            ? null
            : BottomNavigationBar(
                selectedItemColor: Colors.yellow,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.white,
                currentIndex: ((pageRange[0] - 1) / 50).round(),
                onTap: (index) {
                  setState(() {
                    pageRange = [index * 50 + 1, index * 50 + 51];
                  });
                },

                items: List.generate(
                    (pokemonNumberToLoad / 50).round(),
                    (index) => BottomNavigationBarItem(
                          backgroundColor: Colors.red,
                          icon: Icon(
                            Icons.pageview_rounded,
                          ),
                          label:
                              '${index * 50 + 1}-${index * 50 + 50 > pokemonNumberToLoad ? pokemonNumberToLoad : index * 50 + 50}',
                        )),
              ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Pokedex',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    gridMode = !gridMode;
                  });
                },
                icon: Icon(
                  gridMode ? Icons.grid_view : Icons.list,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    favoritesOnly = !favoritesOnly;
                  });
                },
                icon: Icon(
                  favoritesOnly ? Icons.star : Icons.star_border,
                  color: favoritesOnly ? Colors.yellow : Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    search = !search;
                  });
                },
                icon: Icon(
                  search ? Icons.search_off : Icons.search,
                  color: search ? Colors.yellow : Colors.white,
                ))
          ],
        ),
        body: loaded
            ? Column(
                children: [
                  if (search)
                    TextField(
                      onChanged: (val) => setState(() {
                        searchText = val!;
                      }),
                      decoration: InputDecoration(
                        labelText: 'Search a pokemon',
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  Expanded(
                    child: errorMessage != null
                        ? Center(
                            child: Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.red),
                          ))
                        : gridMode
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                padding: EdgeInsets.all(10),
                                itemCount: pokemonDisplayed.length,
                                itemBuilder: (ctx, indice) {
                                  return GridPokemonOverview(
                                      pokemonDisplayed[indice]);
                                })
                            : ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemCount: pokemonDisplayed.length,
                                itemBuilder: (ctx, indice) {
                                  return PokemonOverview(
                                      pokemonDisplayed[indice]);
                                }),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: loadingProgress / pokemonNumberToLoad,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'on first load it takes about 1-2 minutes...',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ));
  }
}

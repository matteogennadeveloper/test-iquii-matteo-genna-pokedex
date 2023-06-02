import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_iquii/models/pokemon.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'package:test_iquii/screens/pokedex_screen.dart';
import 'package:test_iquii/widgets/detail_button.dart';
import 'package:test_iquii/widgets/ability_list.dart';
import 'package:test_iquii/widgets/stats_widget.dart';
import 'package:test_iquii/widgets/stats_chart.dart';

import '../providers/favorites_provider.dart';
//per la scelta dei dettagli da visualizzare
enum SelectedDetails {
  stats,
  abilities,
}

extension DettagliSelezionatiExtension on SelectedDetails {
  bool vediSelezione(SelectedDetails dettaglioDaConfrontare) {
    return this == dettaglioDaConfrontare;
  }
  //per ricavarne l'intestazione
  String getLabel() {
    switch (this) {
      case SelectedDetails.stats:
        return 'Stats';
      case SelectedDetails.abilities:
        return 'Abilities';
    }
  }
  //per ricavarne l'interfaccia
  Widget interfacciaDettagli(pokemon) {
    switch (this) {
      case SelectedDetails.stats:
        return StatsChart(pokemon);
      case SelectedDetails.abilities:
        return AbilityList(pokemon);
    }
  }
}

class PokemonDetailsScreen extends ConsumerStatefulWidget {
  final Pokemon pokemon;

  PokemonDetailsScreen(this.pokemon, {super.key});

  @override
  ConsumerState<PokemonDetailsScreen> createState() => PokemonDetailsScreenState();
}

class PokemonDetailsScreenState extends ConsumerState<PokemonDetailsScreen> {
  SelectedDetails dettagliSelezionati = SelectedDetails.stats;
  late var colorePrimario = widget.pokemon.type.getColors()[1];

  @override
  Widget build(BuildContext context) {
    bool favorite = ref.watch(favoritesData)[widget.pokemon.pokedexNumber - 1];
    return Scaffold(
      appBar: AppBar(actions: [IconButton(
        icon: Icon(
          favorite
              ? Icons.star
              : Icons.star_border, color: Colors.white,),
        onPressed: () {
          ref
              .read(favoritesData.notifier).updateFavorites(
              !ref.watch(favoritesData)[widget.pokemon.pokedexNumber - 1],
              widget.pokemon.pokedexNumber - 1);
          updateFavorite(!favorite, widget.pokemon.pokedexNumber);
        },)],
        elevation: 10,
        centerTitle: true,
        title: Hero(
          tag: widget.pokemon.pokedexNumber,
          child: Text(
            widget.pokemon.name.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        backgroundColor: colorePrimario,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: widget.pokemon.type.getColors())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: widget.pokemon.pokedexNumber +
                          (pokemonNumberToLoad + 1),
                      child: Image.asset(
                        'assets/images/pokeball_icon.png',
                        scale: 5,
                        opacity: const AlwaysStoppedAnimation(.5),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Hero(
                                tag: widget.pokemon.pokedexNumber +
                                    (pokemonNumberToLoad + 1) * 2,
                                child: widget.pokemon.image))),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white54),
                  child: Hero(
                    tag: widget.pokemon.pokedexNumber +
                        (pokemonNumberToLoad + 1) * 3,
                    child: Text(
                      widget.pokemon.type.getLabel(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: colorePrimario),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              DetailButton(
                  selected: dettagliSelezionati
                      .vediSelezione(SelectedDetails.stats),
                  primaryColor: colorePrimario,
                  detail: SelectedDetails.stats,
                  action: () => azioneDettagli(SelectedDetails.stats)),
              DetailButton(
                  selected: dettagliSelezionati
                      .vediSelezione(SelectedDetails.abilities),
                  primaryColor: colorePrimario,
                  detail: SelectedDetails.abilities,
                  action: () {
                    azioneDettagli(SelectedDetails.abilities);
                  }),
            ],
          ),
          Expanded(
              child: dettagliSelezionati.interfacciaDettagli(widget.pokemon))
        ],
      ),
    );
  }

  azioneDettagli(SelectedDetails dettaglio) {
    if (dettagliSelezionati != dettaglio)
      setState(() {
        dettagliSelezionati = dettaglio;
      });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'package:test_iquii/providers/favorites_provider.dart';
import 'package:test_iquii/screens/pokemon_details_screen.dart';
import 'package:test_iquii/screens/pokedex_screen.dart';
import '../models/pokemon.dart';

class PokemonOverview extends ConsumerWidget {
  final Pokemon pokemon;

  const PokemonOverview(this.pokemon);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool favorite = ref.watch(favoritesData)[pokemon.pokedexNumber - 1];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PokemonDetailsScreen(pokemon)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient:
                    LinearGradient(colors: pokemon.type.getColors())),
            child: Center(
              child: ListTile(
                trailing: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      '#${pokemon.pokedexNumber}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      icon: Icon(
                        favorite ? Icons.star : Icons.star_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        ref.read(favoritesData.notifier).updateFavorites(
                            !ref.watch(
                                favoritesData)[pokemon.pokedexNumber - 1],
                            pokemon.pokedexNumber - 1);
                        updateFavorite(!favorite, pokemon.pokedexNumber);
                      },
                    ),
                  ],
                ),
                title: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                          tag:
                              pokemon.pokedexNumber + (pokemonNumberToLoad + 1),
                          child: Image.asset(
                            'assets/images/pokeball_icon.png',
                            scale: 10,
                            opacity: const AlwaysStoppedAnimation(.5),
                          ),
                        ),
                        Hero(
                            tag: pokemon.pokedexNumber +
                                (pokemonNumberToLoad + 1) * 2,
                            child: pokemon.image),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: pokemon.pokedexNumber,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              pokemon.name.substring(0, 1).toUpperCase() +
                                  pokemon.name
                                      .substring(1, pokemon.name.length),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        Hero(
                          tag: pokemon.pokedexNumber +
                              (pokemonNumberToLoad + 1) * 3,
                          child: Text(
                            pokemon.type.getLabel(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//

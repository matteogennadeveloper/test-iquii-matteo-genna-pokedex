import 'package:flutter/material.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'package:test_iquii/widgets/ability_widget.dart';
import '../models/pokemon.dart';

class AbilityList extends StatelessWidget {
  final Pokemon pokemon;

  const AbilityList(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Abilities',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: pokemon.type.getColors()[1]),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, index) =>
              AbilityWidget(pokemon: pokemon, index: index),
          itemCount: pokemon.abilities.length,
        )),
      ],
    );
  }
}

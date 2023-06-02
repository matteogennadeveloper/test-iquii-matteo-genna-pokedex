import 'package:flutter/material.dart';
import 'package:test_iquii/models/pokemon.dart';
import 'package:test_iquii/models/pokemon_type.dart';

class AbilityWidget extends StatelessWidget {
  final Pokemon pokemon;
  final int index;

  const AbilityWidget({super.key, required this.pokemon, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: pokemon.type.getColors())),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(pokemon.abilities[index].name,
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 10,
            ),
            Text(pokemon.abilities[index].descrizione,
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}

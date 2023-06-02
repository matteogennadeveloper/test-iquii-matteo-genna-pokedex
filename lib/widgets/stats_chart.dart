import 'package:flutter/material.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'package:test_iquii/widgets/stats_widget.dart';

import '../models/pokemon.dart';

class StatsChart extends StatelessWidget {
  final Pokemon pokemon;

  const StatsChart(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Center(
          child: Text(
            'Stats',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: pokemon.type.getColors()[1]),
          ),
        )),
        StatsWidget(SelectedStat.hp, pokemon),
        StatsWidget(SelectedStat.attack, pokemon),
        StatsWidget(SelectedStat.defense, pokemon),
        StatsWidget(SelectedStat.specialAttack, pokemon),
        StatsWidget(SelectedStat.specialDefense, pokemon),
        StatsWidget(SelectedStat.speed, pokemon),
        const Spacer(),
      ],
    );
  }
}

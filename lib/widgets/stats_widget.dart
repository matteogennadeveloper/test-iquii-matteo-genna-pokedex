import 'package:flutter/material.dart';
import 'package:test_iquii/models/pokemon.dart';
import 'package:test_iquii/models/pokemon_type.dart';

enum SelectedStat {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
}
extension StatisticaSelezionataExtension on SelectedStat {
  String getLabel () {
    switch (this) {
      case SelectedStat.hp: return 'hp';
      case SelectedStat.attack: return 'attack';
      case SelectedStat.defense: return 'defense';
      case SelectedStat.specialAttack: return 'special attack';
      case SelectedStat.specialDefense: return 'special defense';
      case SelectedStat.speed: return 'speed';
    }
  }
  int getValue (Pokemon pokemon) {
    switch(this) {
      case SelectedStat.hp: return pokemon.stats.hp;
      case SelectedStat.attack: return pokemon.stats.attack;
      case SelectedStat.defense: return pokemon.stats.defense;
      case SelectedStat.specialAttack: return pokemon.stats.specialAttack;
      case SelectedStat.specialDefense: return pokemon.stats.specialDefense;
      case SelectedStat.speed: return pokemon.stats.speed;
    }
  }
}
class StatsWidget extends StatelessWidget {
  final SelectedStat statistica;
  final Pokemon pokemon;
  late String etichetta = statistica.getLabel();
  late int valore = statistica.getValue(pokemon);
  late Color colorePrimario = pokemon.type.getColors()[1];
  StatsWidget(this.statistica, this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(child: Text(etichetta,textAlign: TextAlign.right, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: colorePrimario),)),
        SizedBox(width: 10,),
        Expanded(flex:2,child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(gradient: LinearGradient(colors: pokemon.type.getColors()),borderRadius: BorderRadius.circular(20),),child: Text(valore.toString(),textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall,)))
      ],),
    );
  }

}
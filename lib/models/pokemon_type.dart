import 'package:flutter/material.dart';

enum PokemonType {
  grass,
  water,
  fire,
  poison,
  bug,
  normal,
  electric,
  fighting,
  psychic,
  ghost,
  ice,
  ground,
  flying,
  rock,
  dragon,
}

extension PokemonTypeExtension on PokemonType {
  List<Color> getColors() {
    switch (this) {
      case PokemonType.grass:
        return [Colors.green.shade400, Colors.green.shade700];
      case PokemonType.water:
        return [Colors.blue.shade400, Colors.blue.shade700];
      case PokemonType.fire:
        return [Colors.deepOrange.shade400, Colors.deepOrange.shade900];
      case PokemonType.bug:
        return [Colors.lime.shade300, Colors.lime.shade700];
      case PokemonType.poison:
        return [Colors.purple.shade400, Colors.purple.shade800];
      case PokemonType.normal:
        return [Colors.brown.shade300, Colors.brown.shade500];
      case PokemonType.electric:
        return [Colors.amber.shade400, Colors.amber.shade700];
      case PokemonType.fighting:
        return [Colors.red.shade700, Colors.red.shade900];
      case PokemonType.psychic:
        return [Colors.pink.shade400, Colors.pink.shade700];
      case PokemonType.ghost:
        return [Colors.deepPurple.shade600, Colors.deepPurple.shade800];
      case PokemonType.ice:
        return [Colors.teal.shade200, Colors.teal.shade500];
      case PokemonType.ground:
        return [Colors.brown.shade600, Colors.brown.shade900];
      case PokemonType.flying:
        return [Colors.deepPurple.shade300, Colors.deepPurple.shade500];
      case PokemonType.rock:
        return [
          Colors.lime.shade800,
          Colors.lime.shade900,
        ];
      case PokemonType.dragon:
        return [Colors.purple.shade600, Colors.purple.shade900];
    }
  }

  String getLabel() {
    switch (this) {
      case PokemonType.grass:
        return 'grass';
      case PokemonType.water:
        return 'water';
      case PokemonType.fire:
        return 'fire';
      case PokemonType.bug:
        return 'bug';
      case PokemonType.poison:
        return 'poison';
      case PokemonType.normal:
        return 'normal';
      case PokemonType.electric:
        return 'electric';
      case PokemonType.fighting:
        return 'fighting';
      case PokemonType.psychic:
        return 'psychic';
      case PokemonType.ghost:
        return 'ghost';
      case PokemonType.ice:
        return 'ice';
      case PokemonType.ground:
        return 'ground';
      case PokemonType.flying:
        return 'flying';
      case PokemonType.rock:
        return 'rock';
      case PokemonType.dragon:
        return 'dragon';
    }
  }
}

PokemonType getTypeEnum(String type) {
  switch (type) {
    case 'grass':
      return PokemonType.grass;
    case 'water':
      return PokemonType.water;
    case 'fire':
      return PokemonType.fire;
    case 'bug':
      return PokemonType.bug;
    case 'poison':
      return PokemonType.poison;
    case 'electric':
      return PokemonType.electric;
    case 'fighting':
      return PokemonType.fighting;
    case 'psychic':
      return PokemonType.psychic;
    case 'ghost':
      return PokemonType.ghost;
    case 'ice':
      return PokemonType.ice;
    case 'ground':
      return PokemonType.ground;
    case 'flying':
      return PokemonType.flying;
    case 'rock':
      return PokemonType.rock;
    case 'dragon':
      return PokemonType.dragon;
    default:
      return PokemonType.normal;
  }
}

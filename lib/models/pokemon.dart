import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_iquii/models/pokemon_type.dart';
import 'ability.dart';
import 'pokemon_stats.dart';


class Pokemon {
  String name;
  Image image;
  int pokedexNumber;
  PokemonType type;
  PokemonStats stats;
  List<Ability> abilities;

  Pokemon(
      {required this.name,
      required this.type,
      required this.image,
      required this.pokedexNumber,
      required this.stats,
      required this.abilities});

  Pokemon.fromFirebase(Map<String, dynamic> mapPokemon, File imageFile)
      : name = mapPokemon['name'],
        type = getTypeEnum(mapPokemon['type']),
        image = Image.file(imageFile),
        pokedexNumber = mapPokemon['pokedexNumber'],
        stats = PokemonStats(
            hp: mapPokemon['stats']['hp'],
            attack: mapPokemon['stats']['attack'],
            defense: mapPokemon['stats']['defense'],
            specialAttack: mapPokemon['stats']['specialAttack'],
            specialDefense: mapPokemon['stats']['specialDefense'],
            speed: mapPokemon['stats']['speed']),
        abilities = List.generate(
            mapPokemon['abilities'].length,
            (index) => Ability(mapPokemon['abilities'][index]['name'],
                mapPokemon['abilities'][index]['effect']));

  Map<String, dynamic> fireBaseFormat() {
    return {
      pokedexNumber.toString(): {
        'name': name,
        'type': type.getLabel(),
        'stats': {
          'hp': stats.hp,
          'attack': stats.attack,
          'defense': stats.defense,
          'specialAttack': stats.specialAttack,
          'specialDefense': stats.specialDefense,
          'speed': stats.speed
        },
        'abilities': List.generate(
            abilities.length,
            (index) => {
                  'name': abilities[index].name,
                  'effect': abilities[index].descrizione
                })
      },
    };
  }
//final List<String> abilità;
}

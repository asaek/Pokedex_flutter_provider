import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/model/pokemon.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';

class HomeProvider extends ChangeNotifier {
  final PokemonApi pokemonApi;

  HomeProvider({
    required this.pokemonApi,
  });

  List<Pokemon>? pokemonList;

  Future<void> loadPokemons() async {
    pokemonList = await pokemonApi.getPokemons();
    notifyListeners();
  }
}

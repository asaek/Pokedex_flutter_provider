import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/model/pokemon.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';

class HomeProvider extends ChangeNotifier {
  final PokemonApi pokemonApi;

  HomeProvider({
    required this.pokemonApi,
  });

  List<Pokemon>? pokemonList;
  List<Pokemon>? searchList;

  Future<void> loadPokemons() async {
    pokemonList = await pokemonApi.getPokemons();
    _setInitialList();
    notifyListeners();
  }

  void _setInitialList() {
    searchList = List<Pokemon>.from(pokemonList ?? []);
  }

  void searchPokemon(String filter) {
    final filteLowerCase = filter.toLowerCase();
    if (filter == '') {
      _setInitialList();
    } else {
      searchList = List<Pokemon>.from(
        pokemonList!.where(
          (element) =>
              element.name.toLowerCase().contains(filteLowerCase) ||
              element.id.toLowerCase().contains(filteLowerCase),
        ),
      );
    }
    notifyListeners();
  }
}

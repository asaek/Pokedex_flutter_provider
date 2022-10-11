import 'package:pokedex_flutter/domain/model/pokemon.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';
import 'package:http/http.dart' as http;

const pokemonAPI =
    'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json';

//
class PokemonRestService implements PokemonApi {
  @override
  Future<List<Pokemon>> getPokemons() async {
    var url = Uri.parse(pokemonAPI);
    var response = await http.get(url);

    print('Respoonse status: ${response.statusCode}');
    print('Respoonse body: ${response.body}');
    return pokemonFromJson(response.body);
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';
import 'package:pokedex_flutter/main.dart';
import 'package:pokedex_flutter/ui/home/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._({super.key});

  static Widget creando({Key? key}) => ChangeNotifierProvider(
        lazy: false,
        create: (BuildContext context) => HomeProvider(
          // flutter Provider inyeccion de dependencias
          pokemonApi: context.read<PokemonApi>(),
        )..loadPokemons(),
        child: HomeScreen._(key: key),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final BuildContext context = context.rea

  @override
  Widget build(BuildContext context) {
    final result = context.watch<HomeProvider>().pokemonList;

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: result == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pokedex',
                          style: textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.lightbulb_outline),
                          onPressed: () {
                            context.read<ThemeProvider>().changeTheme();
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Busca tu Pokemon....'),
                    TextField(
                      onChanged: (val) {
                        context.read<HomeProvider>().searchPokemon(val);
                        //Provider.of<HomeProvider>(context, listen:false).searchPokemon(val);
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre o Id del Pokemon',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Expanded(child: GridPokemon())
                  ],
                ),
              ),
      ),
    );
  }
}

class GridPokemon extends StatelessWidget {
  const GridPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemons = context.watch<HomeProvider>().searchList;

    return GridView.builder(
      itemCount: pokemons?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.1 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final pokemon = pokemons![index];
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Image.network(
                pokemon.imageurl,
                height: 200,
              ),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                pokemon.id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

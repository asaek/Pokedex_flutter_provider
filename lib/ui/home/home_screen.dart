import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';
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
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.lightbulb_outline),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Busca tu Pokemon....'),
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
    return GridView.builder(
      itemCount: 20,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.1 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amberAccent),
          child: Column(
            children: [],
          ),
        );
      },
    );
  }
}

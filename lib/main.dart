import 'package:flutter/material.dart';
import 'package:pokedex_flutter/data/rest/pokemon_rest_service.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_api.dart';
import 'package:pokedex_flutter/ui/ui.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokemonApi>(
          create: (context) => PokemonRestService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, provider, _) {
          final isLight = provider.isLight;
          return MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            theme: isLight ? ThemeData.light() : ThemeData.dark(),
            home: const SplashScreen(),
          );
        },
        child: const MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isLight = true;
  void changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }
}

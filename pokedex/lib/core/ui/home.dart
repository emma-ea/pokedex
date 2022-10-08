import 'package:flutter/material.dart';

import './pokemons.dart';
import './fav_pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> screens = const [
    Pokemons(),
    FavPokemon()
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Pokedex running...")));
  }
}

import 'package:flutter/material.dart';

import './pokemons.dart';
import './fav_pokemon.dart';
import '../scoped_model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.model, super.key});

  final PokeDataModel model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> screens = const [Pokemons(), FavPokemon()];

  @override
  void initState() {
    super.initState();
    widget.model.fetchPokemons();
  }

  int _selectedIndex = 0;

  void _selectNavTab(int idx) => setState(() {
    _selectedIndex = idx;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigatorItems
            .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: Icon(item.activeIcon),
                label: item.label))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _selectNavTab,
      ),
    );
  }
}

const _bottomNavigatorItems = <_Item>[
  _Item('Pokemons', icon: Icons.toys_outlined, activeIcon: Icons.toys),
  _Item('Favourite', icon: Icons.toys_outlined, activeIcon: Icons.toys),
];

class _Item {
  final String label;
  final IconData icon, activeIcon;
  const _Item(this.label, {required this.icon, required this.activeIcon});
}

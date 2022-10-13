import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '/utils/extensions.dart';
import '/utils/constants.dart';
import '/utils/display_state.dart';
import '/core/data/local/local_store.dart';
import '/core/scoped_model/main.dart';
import '/core/widgets/custom_tab_bar.dart';
import '/core/widgets/app_divider.dart';
import './pokedex.dart';
import './fav_pokedex.dart';

import '/services/locator.dart' as inject;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Widget> screens = [const Pokemons(), FavPokemon()];

  DisplayState currentDisplayState = DisplayState.allPokemons;
  var model = inject.gi<MainScopeModel>();

  @override
  void initState() {
    super.initState();
    model.fetchPokemons(model.uri);
    // initialize hive box
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPrefs();
    });
  }

  initPrefs() async {
    var preferences = await Preferences.getInstance();
    model.setPreferences(preferences);
    model.getFavourites();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _selectNavTab(int idx) => setState(() {_selectedIndex = idx;});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(125),
          child: _buildAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/pokedex_logo.svg',
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                AppInfo.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).space(top: 10, bottom: 5),
          const AppDivider(
            thickness: 3,
          ),
          ScopedModelDescendant<MainScopeModel>(
            builder: (context, _, model) => CustomTabBar(
              favoritePokemonsCount: model.favouriteCount,
              width: MediaQuery.of(context).size.width,
              onTapped: (DisplayState displayState) {
                if (displayState == DisplayState.favoritePokemons) {
                  _selectNavTab(1);
                } else {
                  _selectNavTab(0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

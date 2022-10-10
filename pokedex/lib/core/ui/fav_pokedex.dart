import 'package:flutter/material.dart';
import 'package:pokedex/core/scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/constants.dart';
import '../widgets/pokedex_card.dart';
import 'pokedex_detail.dart';

class FavPokemon extends StatelessWidget {
  FavPokemon({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool deviceDisplay = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: ScopedModelDescendant<MainScopeModel>(
        builder: (context, child, model) {
          if (model.favourites.isEmpty) {
            return const Center(
              child: Text(AppInfo.noFavourites),
            );
          } else {
            return GridView.builder(
              key: const PageStorageKey(0),
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: model.favouriteCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: deviceDisplay ? 6 : 3,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 220),
              itemBuilder: (context, index) {
                // return PokedexCard(pokedex: model.favourites[index]);
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PokeDetailScreen(model,
                              pokedex: model.favourites.elementAt(index)))),
                  child: PokedexCard(
                    pokedex: model.favourites.elementAt(index),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

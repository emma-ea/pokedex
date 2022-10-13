import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '/core/scoped_model/main.dart';
import '/utils/route_arguments.dart';
import '/utils/constants.dart';
import '../widgets/pokedex_card.dart';

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
            return Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                key: const PageStorageKey(0),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: model.favouriteCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: deviceDisplay ? 6 : 3,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 220),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.detail,
                        arguments: RouteArgs(model.favourites.elementAt(index))
                                ),
                    child: PokedexCard(
                      pokedex: model.favourites.elementAt(index),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '/utils/constants.dart';
import '/utils/route_arguments.dart';
import '/utils/api_response.dart';
import '../widgets/pokedex_card.dart';
import '../scoped_model/main.dart';

class Pokemons extends StatefulWidget {
  const Pokemons({super.key});

  @override
  State<Pokemons> createState() => _PokemonsState();
}

class _PokemonsState extends State<Pokemons> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        requestNextBatch();
      }
    });
    super.initState();
  }

  void requestNextBatch() {
    ScopedModel.of<MainScopeModel>(context).loadNextBatch();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _deviceDisplay => MediaQuery.of(context).size.width > 600;

  Widget _buildListView(data, model) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        key: const PageStorageKey(0),
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _deviceDisplay ? 6 : 3,
            crossAxisSpacing: 10,
            mainAxisExtent: 220),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detail,
              arguments: RouteArgs(data.elementAt(index)),
            ),
            child: PokedexCard(
              pokedex: data.elementAt(index),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
        builder: ((context, child, model) {
      var dexResponse = model.pokedexResponse;
      if (dexResponse.status == Status.error) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dexResponse.msg),
              ElevatedButton(
                  onPressed: () {
                    model.fetchPokemons(model.uri);
                  },
                  child: const Text("Retry"),
              ),
            ],
          ),
        );
      }
      if (dexResponse.status == Status.loading) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildListView(
                model.allPokedex.isEmpty ? {} : model.allPokedex, model),
            model.allPokedex.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(model.pokedexResponse.msg),
                      ],
                    ),
                  )
                : const Positioned(
                    bottom: 1.0,
                    child: CircularProgressIndicator(),
                  ),
          ],
        );
      }
      if (dexResponse.status == Status.nextLoading) {
        var data = model.allPokedex;
        return Stack(
          children: [
            _buildListView(data, model),
            const Positioned(
              bottom: 1.0,
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }
      if (dexResponse.status == Status.completed &&
          dexResponse.data.isNotEmpty) {
        return _buildListView(dexResponse.data, model);
      }
      return Container(
        color: Colors.red[200],
      );
    }));
  }
}

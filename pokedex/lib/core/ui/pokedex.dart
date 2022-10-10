import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pokedex/core/scoped_model/model.dart';
import 'package:pokedex/utils/format_pokedex_opts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/api_response.dart';
import '../model/pokedex_detail.dart';
import '../widgets/pokedex_card.dart';
import '../scoped_model/main.dart';
import 'pokedex_detail.dart';

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
        print("end");
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
    return GridView.builder(
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
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PokeDetailScreen(model, pokedex: data.elementAt(index)))),
          child: PokedexCard(
            pokedex: data.elementAt(index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
        builder: ((context, child, model) {
      var dexResponse = model.pokedexResponse;
      if (dexResponse.status == Status.error) {
        print("----error----");
        return Center(
          child: Text(dexResponse.msg),
        );
      }
      if (dexResponse.status == Status.loading) {
        print("----loading----");
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
        print("----next loading----");
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
        print("----completed----");
        // data = SplayTreeSet.from(
        //    data, (PokedexDetail a, PokedexDetail b) => a.id.compareTo(b.id));
        // data.sort((a, b) => a.id.compareTo(b.id));
        return _buildListView(dexResponse.data, model);
      }
      return Container(
        color: Colors.red[200],
      );
    }));
  }
}

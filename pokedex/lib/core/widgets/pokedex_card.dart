import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/widgets/pokedex_image.dart';
import 'package:pokedex/utils/colors.dart';
import 'package:pokedex/utils/extensions.dart';

import '../../utils/format_pokedex_opts.dart';
import '../model/pokedex_detail.dart';

class PokedexCard extends StatelessWidget {
  const PokedexCard({required this.pokedex, super.key});

  final PokedexDetail pokedex;

  @override
  Widget build(BuildContext context) {
    String url = pokedex.sprites.other.officialArtwork.frontDefault;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              height: 130,
              color: PokedexFormat.getColor(pokedex.id),
              child: ClipRRect(
                  child: PokedexImageWidget(id: pokedex.id, url: url))),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPokeId(pokedex.id),
                _buildPokeName(pokedex.name),
                const SizedBox(
                  height: 10,
                ),
                _buildPokedexTypes(),
                // const SizedBox(
                //   height: 5,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPokeName(String name) {
    return Text(
      name.toUpperCase(),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  _buildPokeId(int id) {
    return Text(
      PokedexFormat.formatIndex(id),
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.dimGray,
      ),
    ).space(bottom: 2);
  }

  _buildPokedexTypes() {
    return Text(
      PokedexFormat.formatTypes(pokedex.types),
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.dimGray,
      ),
    ).space(bottom: 4);
  }

}

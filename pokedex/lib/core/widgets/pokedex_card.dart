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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              height: 130,
              color: PokedexFormat.getColor(pokedex.id),
              child: ClipRRect(
                  child: PokedexImageWidget(id: pokedex.id, url: url))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPokeId(pokedex.id),
              const SizedBox(
                height: 2,
              ),
              _buildPokeName(pokedex.name),
              const SizedBox(
                height: 10,
              ),
              _buildPokedexTypes(),
              const SizedBox(
                height: 5,
              ),
            ],
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
    );
  }

  // _buildPokeImage(url) {
  //   return Image.network(
  //     url,
  //     fit: BoxFit.fill,
  //     loadingBuilder: (BuildContext context, Widget child,
  //         ImageChunkEvent? loadingProgress) {
  //       if (loadingProgress == null) return child;
  //       return Center(
  //         child: CircularProgressIndicator(
  //           value: loadingProgress.expectedTotalBytes != null
  //               ? loadingProgress.cumulativeBytesLoaded /
  //                   loadingProgress.expectedTotalBytes!
  //               : null,
  //         ),
  //       );
  //     },
  //   );
  // }

}

import 'package:flutter/material.dart';
import 'package:pokedex/core/model/pokedex_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokedexImageWidget extends StatelessWidget {
  const PokedexImageWidget({
    Key? key,
    required this.id,
    required this.url,
  }) : super(key: key);
  final String url;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: UniqueKey(),
      child: _buildPokeCachedImage(url),
    );
  }

  _buildPokeCachedImage(url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, info,
          loadingProgress) {
        // if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.totalSize != null
                ? loadingProgress.downloaded /
                    loadingProgress.totalSize!
                : null,
          ),
        );
      },
      errorWidget: (context, error, stackTrace) {
        return const Center(
          child: Text("Failed to retrieve\nimage"),
        );
      },
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
  //     errorBuilder: (context, error, stackTrace) {
  //       return const Center(
  //         child: Text("Failed to retrieve\nimage"),
  //       );
  //     },
  //   );
  // }
}

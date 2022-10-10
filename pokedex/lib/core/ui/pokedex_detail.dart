import 'package:flutter/material.dart';
import 'package:pokedex/core/scoped_model/main.dart';
import 'package:pokedex/core/scoped_model/model.dart';
import 'package:pokedex/core/widgets/pokedex_image.dart';
import 'package:pokedex/utils/colors.dart';
import 'package:pokedex/utils/extensions.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/format_pokedex_opts.dart';
import '../model/pokedex_detail.dart';
import '../widgets/app_divider.dart';

class PokeDetailScreen extends StatefulWidget {
  const PokeDetailScreen(this.mod, {required this.pokedex, super.key});

  final PokedexDetail pokedex;
  final MainScopeModel mod;

  @override
  State<StatefulWidget> createState() {
    return _PokeDetailScreenState();
  }
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String url = widget.pokedex.sprites.other.officialArtwork.frontDefault;
    widget.mod.isFavouritePokedex(widget.pokedex.id);
    return ScopedModel<MainScopeModel>(
      model: widget.mod,
      child: Scaffold(
        body: _buildFavouritesBody(context, url),
        floatingActionButton: _buildCusFab(),
      ),
    );
  }

  _handleOnTap(mod) {
    if (mod.isFav) {
      mod.removeFavourite(widget.pokedex);
    } else {
      mod.addFavourite(widget.pokedex);
    }
    setState(() {});
  }

  _buildCusFab() {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (ctx, child, mod) => GestureDetector(
        onTap: () => _handleOnTap(mod),
        child: Container(
          //duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: mod.isFav ? AppColors.paleLavendar : AppColors.ceruleanBlue,
          ),
          child: Text(
            mod.isFav ? 'Remove from favourites' : 'Mark as favourite',
            style: TextStyle(
              color: mod.isFav ? AppColors.ceruleanBlue : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _buildSliverChildren(pokedex, url) {
    return <Widget>[
      const AppDivider(
        height: 2,
        thickness: 4,
        color: Colors.red,
      ),
      _buildDetailImage(),
      Text("Pokemon index: ${PokedexFormat.formatIndex(pokedex.id)}"),
      Text("Pokemon name: ${pokedex.name}"),
      Text("Pokemon type: ${PokedexFormat.formatTypes(pokedex.types)}"),
    ];
  }

  _buildDetailImage() {
    String url = widget.pokedex.sprites.other.officialArtwork.frontDefault;
    return Container(
      height: 200,
      color: AppColors.honeyDew,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: -32,
            bottom: -22,
            child: Container(
              color: AppColors.greenBlue,
            ),
          ),
          Positioned(
            right: -15,
            bottom: -2,
            child: SizedBox(
              width: 200,
              height: 200,
              child: PokedexImageWidget(
                id: widget.pokedex.id,
                url: url,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildFavouritesBody(context, url) {
    return CustomScrollView(
      key: const PageStorageKey(1),
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.honeyDew,
          expandedHeight: 50.0,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () => Navigator.pop(context),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.chevron_left,
              ),
            ).space(left: 15, bottom: 15),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            ((context, index) {
              return _buildSliverChildren(widget.pokedex, url)[index];
            }),
            childCount: _buildSliverChildren(widget.pokedex, url).length,
          ),
        ),
      ],
    );
  }
}

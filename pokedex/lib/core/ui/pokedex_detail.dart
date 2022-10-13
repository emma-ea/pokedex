import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/pokedex_detail.dart';
import '/core/scoped_model/main.dart';
import '/core/widgets/pokedex_image.dart';
import '/utils/colors.dart';
import '/utils/extensions.dart';
import '/utils/route_arguments.dart';
import '/utils/format_pokedex_opts.dart';
import '../widgets/app_divider.dart';

import '/services/locator.dart' as inject;

class PokeDetailScreen extends StatefulWidget {
  const PokeDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokeDetailScreenState();
  }
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  var model = inject.gi<MainScopeModel>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RouteArgs;
    String url = args.pokedex.sprites.other.officialArtwork.frontDefault;

    // initialize fav button state
    model.isFavouritePokedex(args.pokedex.id);
    return Scaffold(
      body: _buildFavouritesBody(context, url, args),
      floatingActionButton: _buildCusFab(args),
    );
  }

  _handleOnTap(mod, pokedex) {
    if (mod.isFav) {
      mod.removeFavourite(pokedex);
    } else {
      mod.addFavourite(pokedex);
    }
    setState(() {});
  }

  _buildCusFab(args) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (ctx, child, mod) => GestureDetector(
        onTap: () => _handleOnTap(mod, args.pokedex),
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
        height: 3,
      ),
      _buildDetailImage(pokedex),
      _buildHeightWeightBMI(pokedex),
      const AppDivider(
        thickness: 10,
      ),
      const Text(
        "Base Stats",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ).space(
        left: 15,
        top: 10,
        bottom: 10,
      ),
      const AppDivider(
        thickness: 2,
      ),
      _buildBaseStats(pokedex),
    ];
  }

  _buildDetailImage(pokedex) {
    String url = pokedex.sprites.other.officialArtwork.frontDefault;
    return Container(
      height: 200,
      color: PokedexFormat.getColor(pokedex.id),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 2,
            child: Container(
              color: PokedexFormat.getColor(pokedex.id),
              child: SvgPicture.asset(
                'assets/images/pokedex_detail_bg.svg',
                color: PokedexFormat.getColor(pokedex.id).darken(),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: -8,
            child: SizedBox(
              width: 180,
              height: 180,
              child: PokedexImageWidget(
                id: pokedex.id,
                url: url,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokedex.name.toString().inCaps,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  PokedexFormat.formatTypes(pokedex.types),
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              PokedexFormat.formatIndex(pokedex.id),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeightWeightBMI(pokedex) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Height",
                style: TextStyle(
                  color: AppColors.dimGray,
                ),
              ),
              Text(
                "${pokedex.height}",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Weight",
                style: TextStyle(
                  color: AppColors.dimGray,
                ),
              ),
              Text(
                "${pokedex.weight}",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "BMI",
                style: TextStyle(
                  color: AppColors.dimGray,
                ),
              ),
              Text(
                "${PokedexFormat.calcBMI(pokedex.weight, pokedex.height)}",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildBaseStats(PokedexDetail pokedex) {
    Set<PokeStats> pokedexStats = {};
    int avgPower = 0;

    pokedex.stats.forEach((e) {
      pokedexStats.add(PokeStats(e.stat.name, e.baseStat));
      avgPower += e.baseStat;
    });

    avgPower = avgPower ~/ pokedex.stats.length;

    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var s in pokedexStats)
            _buildStatsLevel(s.name.capitalizeFirstofEach, s.baseStats),
          _buildStatsLevel("Average Power", avgPower),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _buildStatsLevel(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.dimGray,
                ),
              ).space(right: 14.0),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          _buildStatsMeter(value),
        ],
      ),
    );
  }

  _buildStatsMeter(value) {
    Color color = AppColors.magentaDye;
    if (value > 45) color = AppColors.deepLemon;
    if (value > 80) color = AppColors.maximumGreen;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 4,
          width: width,
          color: Colors.grey.shade200,
        ),
        Container(
          width: PokedexFormat.calcStatLevel(value, width).toDouble(),
          height: 4,
          color: color,
        ),
      ],
    );
  }

  _buildFavouritesBody(context, url, args) {
    return CustomScrollView(
      key: const PageStorageKey(1),
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: PokedexFormat.getColor(args.pokedex.id),
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
              return _buildSliverChildren(args.pokedex, url)[index];
            }),
            childCount: _buildSliverChildren(args.pokedex, url).length,
          ),
        ),
      ],
    );
  }
}

class PokeStats {
  final String name;
  final int baseStats;

  PokeStats(this.name, this.baseStats);
}

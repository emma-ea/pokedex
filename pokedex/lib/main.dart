import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'core/ui/home.dart';
import 'core/scoped_model/main.dart';
import 'core/ui/pokedex_detail.dart';
import 'core/ui/splash_screen.dart';
import 'utils/constants.dart';

import 'services/locator.dart' as inject;

void main() async {
  await inject.setup();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainScopeModel>(
      model: inject.gi<MainScopeModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppInfo.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'NotoSans'
        ),
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash:(context) => const SplashScreen(),
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.detail: (context) => const PokeDetailScreen(),
        },
      ),
    );
  }
}

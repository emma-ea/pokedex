import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'core/ui/home.dart';
import 'core/scoped_model/main.dart';

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});

  final MainScopeModel _model = MainScopeModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel<MainScopeModel>(
        model: _model,
        child: HomePage(model:_model),
      ),
    );
  }
}

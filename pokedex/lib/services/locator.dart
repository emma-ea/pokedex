import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/scoped_model/main.dart';

final gi = GetIt.instance;

setup() async {
  gi.registerLazySingleton(() => MainScopeModel());
  await Hive.initFlutter();
}

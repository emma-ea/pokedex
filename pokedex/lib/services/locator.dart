import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/scoped_model/main.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/services/firebase_analytics.dart';

final gi = GetIt.instance;

setup() async {
  await initializeServices();
  gi.registerLazySingleton(() => MainScopeModel());
  gi.registerLazySingleton(() => FirebaseAnalyticsService());
}

initializeServices() async {
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

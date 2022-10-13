import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/model/pokedex_list.dart';

import '../../test_fixtures/test_fixtures.dart';

void main() {
  late Map<String, dynamic> data;
  const String filename = "pokedex_list.json";

  setUp(() {
    data = json.decode(TestFixtures.read(filename));
  });

  group("data fromJson", () {
    test("return PokedexList object when json is parsed", () async {
      final object = PokedexList.fromMap(data);
      expect(object, isA<PokedexList>());
    });

    test("return Result object when json is parsed", () {
      final object = PokedexList.fromMap(data).results;
      expect(object, isA<Result>());
    });
  });
}

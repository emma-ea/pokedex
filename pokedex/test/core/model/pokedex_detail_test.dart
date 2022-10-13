import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/model/pokedex_detail.dart';

import '../../test_fixtures/test_fixtures.dart';

import 'dart:convert';

void main() {
  const String filename = "pokedex_detail.json";
  late Map<String, dynamic> data;

  setUp(() {
    data = json.decode(TestFixtures.read(filename));
  });

  group("data fromJson", () {
    test("returns valid PokedexDetail object for first pokemon", () {
      final object = PokedexDetail.fromJson(data);
      expect(object, isA<PokedexDetail>());
    });

    test("pokemon with index 1 has name equal to bulbasaur", () {
      final object = PokedexDetail.fromJson(data);
      expect(object.name, "bulbasaur");
    });
  });
}

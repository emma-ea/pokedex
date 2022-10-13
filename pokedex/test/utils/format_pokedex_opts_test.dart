import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/utils/format_pokedex_opts.dart';

void main() {
  group('formatIndex with different inputs', () {
    test('returns 2 zero padding indexes with 1 digit', () {
      String res = PokedexFormat.formatIndex(1);
      expect(res, "#001");
    });

    test('returns 1 zero padding indexes with 2 digits', () {
      String res = PokedexFormat.formatIndex(12);
      expect(res, "#012");
    });

    test('returns no zero padding indexes with > 3 digits', () {
      String res = PokedexFormat.formatIndex(1234);
      expect(res, "#1234");
    });

    test('returns an empty string is index is less than zero', () {
      String res = PokedexFormat.formatIndex(0);
      expect(res, "");
    });
  });

  group("calculating BMI", () {
    test(
        'given weight is 3 and height is 4, return round up from 0.187 to 0.19',
        () {
      double res = PokedexFormat.calcBMI(3, 4);
      expect(res, 0.19);
    });

    test('given weight or height is less than zero, return 0.0', () {
      double res = PokedexFormat.calcBMI(-3, -5);
      expect(res, 0);
      res = PokedexFormat.calcBMI(-3, 5);
      expect(res, 0);
      res = PokedexFormat.calcBMI(3, -5);
      expect(res, 0);
    });
  });

  group("calculate stats level", () {
    test("given stat or total is less than zero return 0", () {
      double res = PokedexFormat.calcStatLevel(-5, 100.0);
      expect(res, 0);
    });

    test("given stat is 45 or total is 235 return 105.75", () {
      double res = PokedexFormat.calcStatLevel(45, 235.0);
      expect(res, 105.75);
    });

  });
}

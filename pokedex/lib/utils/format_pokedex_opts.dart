import 'package:flutter/material.dart';

import '../core/model/pokedex_detail.dart';
import 'colors.dart';

class PokedexFormat {
  static String formatIndex(int index) {
    switch (index.toString().length) {
      case 1:
        return "#00$index";
      case 2:
        return "#0$index";
      default:
        return "#$index";
    }
  }

  static String formatTypes(List<Types> types) {
    return types.join(", ").toString();
  }

  static Color getColor(id) {
    final rem = (id + 1) % 9;

    if (rem == 0 || rem == 8 || rem == 7) {
      return AppColors.aliceBlue;
    } else if (rem == 4 || rem == 5 || rem == 6) {
      return AppColors.lavendarBlush;
    } else {
      return AppColors.honeyDew;
    }
  }
}

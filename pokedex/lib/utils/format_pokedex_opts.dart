import 'package:flutter/material.dart';

import '/utils/extensions.dart';
import '/core/model/pokedex_detail.dart';
import 'colors.dart';

import 'dart:math' as math;

class PokedexFormat {
  PokedexFormat._();

  static String formatIndex(int index) {
    if (index <= 0) return "";
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
    return types.join(" ").toString().capitalizeFirstofEach;
  }

  static Color getColor(int id) {
    final rem = id % 9;

    if (rem == 0 || rem == 8 || rem == 7) {
      return AppColors.aliceBlue;
    } else if (rem == 4 || rem == 5 || rem == 6) {
      return AppColors.lavendarBlush;
    } else {
      return AppColors.honeyDew;
    }
  }

  static double calcBMI(int w, int h) {
    if (w > 1 && h > 1) {
      return double.parse((w / (math.pow(h, 2))).toStringAsFixed(2));
    }
    return 0;
  }

  static double calcStatLevel(int stat, double total) {
    if (stat > 1 && total > 1) {
      return double.parse(((stat / 100) * total).toStringAsFixed(2));
    }
    return 0;
  }
  
}

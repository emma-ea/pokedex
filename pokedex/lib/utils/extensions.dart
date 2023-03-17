import 'package:flutter/material.dart';

extension CapExtension on String {
  String get inCaps => "${this[0].toUpperCase()}${substring(1)}";
  String get capitalizeFirstofEach =>
      split(RegExp("[ -,]")).map((str) => str.inCaps).join(", ");
  String get capitalizeStats => split("-").map((str) => str.inCaps).join(" ");
}

extension LayoutWidgets on Widget {
  space({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}

import 'package:flutter/material.dart';

class ResponsiveConfig {
  static late double width;
  static late double height;
  static late double shortestSide;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    shortestSide = size.shortestSide;
  }
}

extension Responsive on num {
  /// 📐 Width bazlı
  double get w => ResponsiveConfig.width * (this / 375);

  /// 📐 Height bazlı
  double get h => ResponsiveConfig.height * (this / 812);

  /// 🔤 Font / Icon
  double get sp => this * (ResponsiveConfig.shortestSide / 375);
}

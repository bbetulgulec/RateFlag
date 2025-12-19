import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/theme/app_color.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      surfaceContainerHighest: AppColors.container,
      error: AppColors.redFlag,
      onSurface: AppColors.textPrimary,
    ),

    scaffoldBackgroundColor: AppColors.surface,
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Colors.white,
      surfaceContainerHighest: const Color(0xFFF5F5F5),
      error: AppColors.redFlag,
      onSurface: Colors.black,
    ),

    scaffoldBackgroundColor: Colors.white,
  );
}

import 'package:flutter/material.dart';
import 'package:rate_flag/app/common/constants/app_color.dart';

class AppTextFieldTheme {
  static InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    labelStyle: const TextStyle(color: Colors.black),
    hintStyle: TextStyle(color: Colors.grey.shade600),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );

  static InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.container,

    labelStyle: const TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: AppColors.textHint),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: Colors.white, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: BorderSide(color: AppColors.redFlag),
    ),
  );
}

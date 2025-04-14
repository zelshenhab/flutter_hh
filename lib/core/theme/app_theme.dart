import 'package:flutter/material.dart';
import 'package:flutter_hh/core/constants/app_sizes.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
    ),
  );
}

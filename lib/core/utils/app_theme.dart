import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      titleTextStyle: TextStyle(color: AppColors.darkColor, fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      dayStyle: const TextStyle(color: AppColors.darkColor),
      yearStyle: const TextStyle(color: AppColors.darkColor),
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: AppColors.whiteColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      dialHandColor: AppColors.primaryColor,
      hourMinuteTextColor: AppColors.darkColor,
      dayPeriodTextColor: AppColors.darkColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkColor,
      titleTextStyle: TextStyle(fontSize: 20, color: AppColors.whiteColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.darkColor,
      dayStyle: const TextStyle(color: AppColors.whiteColor),
      yearStyle: const TextStyle(color: AppColors.whiteColor),
      todayBorder: BorderSide(color: AppColors.primaryColor),
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: AppColors.whiteColor,
    ),
    timePickerTheme: TimePickerThemeData(
      entryModeIconColor: AppColors.primaryColor,
      backgroundColor: AppColors.darkColor,
      hourMinuteTextColor: AppColors.whiteColor,
      dialHandColor: AppColors.primaryColor,
      dialBackgroundColor: Colors.grey[800],
      dayPeriodTextColor: AppColors.whiteColor,
      dayPeriodColor: AppColors.primaryColor,
      hourMinuteColor: AppColors.primaryColor,
      helpTextStyle: TextStyle(color: AppColors.primaryColor, fontSize: 18),
    ),
  );
}

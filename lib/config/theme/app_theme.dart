import 'package:flutter/material.dart';
import '../../core/utils/font_weight.dart';
import 'colors.dart';

abstract class AppTheme {
  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: AppFontWeight.medium,
          color: AppColors.black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          disabledBackgroundColor: AppColors.black[30],
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: AppFontWeight.medium,
            color: AppColors.white,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
          fontWeight: AppFontWeight.regular,
          fontSize: 12,
          color: AppColors.white[80],
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: AppFontWeight.regular,
          fontSize: 12,
          color: AppColors.pink,
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        shape: RoundedRectangleBorder(),
        fillColor: WidgetStatePropertyAll(Colors.transparent),
        checkColor: WidgetStatePropertyAll(AppColors.pink),
        side: BorderSide(color: Color(0xff49454F)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppColors.darkGrey.withValues(alpha: .5),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: AppFontWeight.regular,
          color: AppColors.red,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
          color: AppColors.white[70],
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.medium,
          color: AppColors.white[70],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.pink,
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 13,
          fontWeight: AppFontWeight.regular,
          color: AppColors.black,
        ),
        displayMedium: TextStyle(
          color: AppColors.darkGrey,
          fontSize: 16,
          fontWeight: AppFontWeight.medium,
        ),
        bodySmall: TextStyle(
          fontWeight: AppFontWeight.regular,
          fontSize: 12,
          color: AppColors.black,
        ),
        labelSmall: TextStyle(
          fontWeight: AppFontWeight.regular,
          fontSize: 14,
          color: AppColors.darkGrey,
        ),
        labelMedium: TextStyle(
          fontWeight: AppFontWeight.medium,
          fontSize: 18,
          color: AppColors.black,
        ),
        titleLarge: TextStyle(
          fontWeight: AppFontWeight.bold,
          fontSize: 24,
          color: AppColors.black,
        ),
        bodyLarge: TextStyle(
          fontWeight: AppFontWeight.medium,
          fontSize: 20,
          color: AppColors.black,
        ),
        bodyMedium: TextStyle(
          fontWeight: AppFontWeight.medium,
          fontSize: 14,
          color: AppColors.white,
        ),
        titleSmall: TextStyle(
          fontWeight: AppFontWeight.medium,
          fontSize: 14,
          color: AppColors.black,
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.white[70]),
    );
  }

  static ThemeData lightTheme = getTheme(
    ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.pink,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      shadow: AppColors.black,
      onSurface: AppColors.darkGrey,
      onPrimaryFixed: AppColors.white[80],
    ),
  );
}

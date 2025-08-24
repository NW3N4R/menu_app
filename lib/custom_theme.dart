import 'package:flutter/material.dart';

ThemeData getLighTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: LightColors.primary,
    secondaryHeaderColor: LightColors.secondary,
    colorScheme: ColorScheme.light(
      primary: LightColors.primary,
      secondary: LightColors.secondary,
      surface: LightColors.primaryBackground,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: LightColors.secondary),
      bodyMedium: TextStyle(color: LightColors.secondary),
      bodyLarge: TextStyle(color: LightColors.primary),
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: DarkColors.primary,
    secondaryHeaderColor: DarkColors.secondary,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primary,
      secondary: DarkColors.secondary,
      surface: DarkColors.primaryBackground,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: DarkColors.secondary),
      bodyMedium: TextStyle(color: DarkColors.secondary),
      bodyLarge: TextStyle(color: DarkColors.primary, fontFamily: 'Rigatoni'),
      titleLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'Rigatoni',
        fontSize: 40,
      ),
    ),
  );
}

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

Color getCurrentPrimaryBackground(BuildContext context) {
  return isDarkMode(context)
      ? DarkColors.primaryBackground
      : LightColors.primaryBackground;
}

Color getCurrentSecondaryBackground(BuildContext context) {
  return isDarkMode(context)
      ? DarkColors.secondaryBackGround
      : LightColors.secondaryBackGround;
}

Color getWOB(BuildContext context) {
  return isDarkMode(context) ? Colors.white : Colors.black;
}

class LightColors {
  static const primaryBackground = Colors.white;
  static const secondaryBackGround = Color.fromARGB(240, 245, 245, 245);
  static const primary = Colors.orange;
  static const secondary = Colors.amber;
  static const surface = Colors.white;
}

class DarkColors {
  static const primaryBackground = Color.fromARGB(255, 18, 19, 37);
  static const secondaryBackGround = Color.fromARGB(99, 38, 40, 75);
  static const primary = Colors.orange;
  static const secondary = Colors.amber;
  static const surface = Color.fromARGB(255, 18, 19, 37);
}

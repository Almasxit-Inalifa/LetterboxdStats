import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final baseTheme = ThemeData.light();

    const Color green = Color.fromRGBO(0, 224, 84, 30);
    const Color blue = Color.fromRGBO(64, 188, 244, 30);
    const Color orange = Color.fromRGBO(255, 128, 0, 30);
    const Color lightGrey = Color.fromARGB(206, 42, 47, 51);
    const Color darkGrey = Color.fromRGBO(20, 24, 28, 100);

    return ThemeData(
      primaryColor: blue,
      disabledColor: const Color.fromRGBO(171, 206, 215, 0.882),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: green,
        secondary: blue,
        tertiary: orange,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: lightGrey,
      appBarTheme: const AppBarTheme(
        color: darkGrey,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: green,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      // Add other theme properties here
    );
  }
}

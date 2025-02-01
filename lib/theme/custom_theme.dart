import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: HSLColor.fromAHSL(1.0, 210, 0.4, 0.98)
          .toColor(), // Adjusted saturation
      scaffoldBackgroundColor: HSLColor.fromAHSL(1.0, 222.2, 0.84, 0.049)
          .toColor(), // Adjusted saturation and lightness
      cardColor: HSLColor.fromAHSL(1.0, 222.2, 0.84, 0.049)
          .toColor(), // Adjusted saturation and lightness
      colorScheme: ColorScheme.dark(
        surface: HSLColor.fromAHSL(1.0, 222.2, 0.84, 0.049)
            .toColor(), // Adjusted saturation and lightness
        secondary: HSLColor.fromAHSL(1.0, 217.2, 0.326, 0.175)
            .toColor(), // Adjusted saturation and lightness
      ),
      dividerColor: HSLColor.fromAHSL(1.0, 217.2, 0.326, 0.175)
          .toColor(), // Adjusted saturation and lightness
      hintColor: HSLColor.fromAHSL(1.0, 215, 0.202, 0.651)
          .toColor(), // Adjusted saturation and lightness
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: HSLColor.fromAHSL(1.0, 210, 0.4, 0.98)
              .toColor(), // Adjusted saturation
        ),
        bodyMedium: TextStyle(
          color: HSLColor.fromAHSL(1.0, 210, 0.4, 0.98)
              .toColor(), // Adjusted saturation
        ),
        headlineLarge: TextStyle(
          color: HSLColor.fromAHSL(1.0, 222.2, 0.474, 0.112)
              .toColor(), // Adjusted saturation and lightness
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(
        color: HSLColor.fromAHSL(1.0, 210, 0.4, 0.98)
            .toColor(), // Adjusted saturation
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: HSLColor.fromAHSL(1.0, 222.2, 0.84, 0.049)
            .toColor(), // Adjusted saturation and lightness
        foregroundColor: HSLColor.fromAHSL(1.0, 210, 0.4, 0.98)
            .toColor(), // Adjusted saturation
      ),
    );
  }
}

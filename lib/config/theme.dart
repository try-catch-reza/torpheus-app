import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: ColorConstants.corFundo,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorConstants.chambray),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.chambray,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}

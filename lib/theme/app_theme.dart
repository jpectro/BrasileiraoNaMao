import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get escuro => ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.fundo,
        primaryColor: AppColors.primaria,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.card,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            color: AppColors.texto,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaria,
          surface: AppColors.card,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.texto),
          bodySmall: TextStyle(color: AppColors.textoSecundario),
        ),
      );
}

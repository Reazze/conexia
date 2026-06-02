  import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(
        useMaterial3: true,

        fontFamily: 'Poppins',

        scaffoldBackgroundColor:
            Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      );
}
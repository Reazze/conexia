import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {

  static const primaryGradient =
      LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,

        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      );

  static const holographicBackground =
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [
          Color(0xFFEDE8FF),
          Color(0xFFFFE8F8),
          Color(0xFFE8F2FF),
          Color(0xFFF0E8FF),
          Color(0xFFFFECF8),
        ],
      );

  static const welcomeGradient =
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [
          Color.fromARGB(255, 198, 185, 242),
          Color.fromARGB(255, 255, 255, 255),
          Color(0xFFE8EEFF),
          Color.fromARGB(255, 247, 247, 248),
        ],
      );
}
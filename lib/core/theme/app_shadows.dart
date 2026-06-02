import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {

  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: AppColors.primary
          .withValues(alpha: 0.8),

      blurRadius: 16,

      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.primary
          .withValues(alpha: 0.15),

      blurRadius: 10,

      offset: const Offset(0, 3),
    ),
  ];
}
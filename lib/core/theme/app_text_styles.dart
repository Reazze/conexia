import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {

  static const title =
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static const subtitle =
      TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  static const button =
      TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static const socialButton =
      TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  static const footer =
      TextStyle(
        fontSize: 14,
        color: AppColors.textMuted,
      );
}
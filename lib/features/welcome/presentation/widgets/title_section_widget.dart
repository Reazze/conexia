import 'package:conexia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            children: [
              TextSpan(text: '¡Bienvenido a '),
              TextSpan(
                text: 'CONEXIA',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
              TextSpan(text: '!'),
            ],
          ),
        ),
        const SizedBox(height:09),
        const Text(
          'Conéctate con personas increíbles,\ncomparte tus opiniones y \ngana recompensas reales.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
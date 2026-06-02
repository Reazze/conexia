import 'package:conexia/core/theme/app_colors.dart';
import 'package:conexia/core/theme/app_shadows.dart';
import 'package:conexia/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FeaturesCardWidget extends StatelessWidget {
  const FeaturesCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(22),
        boxShadow:AppShadows.primaryShadow,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _featureItem(
            icon: Icons.group,
            iconColor: AppColors.primary,
            bgColor: const Color(0xFFF3EEFF),
            title: 'Conecta',
            subtitle: 'con personas\ncomo tú',
          ),
          _divider(),
          _featureItem(
            icon: Icons.checklist_rtl,
            iconColor: const Color(0xFF3B82F6),
            bgColor: const Color(0xFFEEF4FF),
            title: 'Participa',
            subtitle: 'en encuestas\ny juegos',
          ),
          _divider(),
          _featureItem(
            icon: Icons.attach_money,
            iconColor: AppColors.secondary,
            bgColor: const Color(0xFFFFFBEB),
            title: 'Gana',
            subtitle: 'recompensas\nreales',
          ),
        ],
      ),
    );
  }

  Widget _featureItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: AppTextStyles.title,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 60,
      color: AppColors.googleBorder,
    );
  }
}
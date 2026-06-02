import 'package:conexia/core/theme/app_gradients.dart';
import 'package:conexia/core/theme/app_shadows.dart';
import 'package:conexia/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:conexia/screens/home_screen.dart';


class EmailButtonWidget extends StatelessWidget {
  const EmailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: AppShadows.primaryShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.mail_outline,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Continuar con correo electrónico',
              style: AppTextStyles.button,
            ),
            const SizedBox(width: 6),
            const Text(
              '✦',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

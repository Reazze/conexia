import 'package:flutter/material.dart';
import 'package:conexia/core/theme/app_colors.dart';

import 'package:conexia/screens/user_login_screen.dart';

// import '../pages/email_login_page.dart';

class SecondaryLoginButtonWidget extends StatelessWidget {
  const SecondaryLoginButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EmailLoginScreen()),
        );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF7C5CBF),
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

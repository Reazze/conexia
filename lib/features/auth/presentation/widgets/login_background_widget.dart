import 'package:flutter/material.dart';

class LoginBackgroundWidget extends StatelessWidget {
  const LoginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDE8FF),
            Color(0xFFFFE8F8),
            Color(0xFFE8F2FF),
            Color(0xFFF0E8FF),
            Color(0xFFFFECF8),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginSubtitleWidget extends StatelessWidget {
  const LoginSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Iniciar sesión con...',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4C1D95),
      ),
    );
  }
}
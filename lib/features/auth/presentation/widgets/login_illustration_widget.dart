import 'package:flutter/material.dart';

class LoginIllustrationWidget extends StatelessWidget {
  const LoginIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Image.asset(
        'assets/images/LogotipoSinfondo.png',
        height: 120,
        width: 300,
      ),
    );
  }
}
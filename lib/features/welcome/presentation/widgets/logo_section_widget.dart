import 'package:flutter/material.dart';

class LogoSectionWidget extends StatelessWidget {
  const LogoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Image.asset(
        'assets/images/img1.png',
        height: 250,
        width: 350,
        fit: BoxFit.contain,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class IllustrationWidget extends StatelessWidget {
  const IllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Image.asset(
        'assets/images/LogotipoSinfondo.png',
        height: 120,
        width: 250,
        fit: BoxFit.contain,
      ),
    );
  }
}
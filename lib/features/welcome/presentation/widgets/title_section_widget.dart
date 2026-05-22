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
              color: Color(0xFF1A1A2E),
            ),
            children: [
              TextSpan(text: '¡Bienvenido a '),
              TextSpan(
                text: 'CONEXIA',
                style: TextStyle(
                  color: Color(0xFF7C5CBF),
                ),
              ),
              TextSpan(text: '!'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Conéctate con personas increíbles,\ncomparte tus opiniones y \ngana recompensas reales.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
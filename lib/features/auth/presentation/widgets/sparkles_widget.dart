import 'package:flutter/material.dart';
import 'package:conexia/core/theme/app_colors.dart';

class SparklesWidget extends StatelessWidget {
  const SparklesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _sparkle(
          top: 80,
          left: 30,
          size: 16,
          color: const Color(0xFFFBBF24),
        ),

        _sparkle(
          top: 120,
          right: 40,
          size: 12,
          color: const Color(0xFFFBBF24),
        ),

        _sparkle(
          top: 300,
          right: 25,
          size: 10,
          color: const Color(0xFFFBBF24),
        ),

        _sparkle(
          top: 180,
          left: 20,
          size: 10,
          color:  AppColors.primary,
        ),

        _sparkle(
          top: 450,
          left: 35,
          size: 14,
          color:  AppColors.primary
              .withValues(alpha: 0.6),
        ),

        Positioned(
          bottom: 180,
          left: 28,
          child: Text(
            '💜',
            style: TextStyle(
              fontSize: 18,
              color: Colors.purple.withValues(alpha: 0.7),
            ),
          ),
        ),

        _sparkle(
          top: 560,
          right: 30,
          size: 12,
          color: const Color(0xFFFBBF24),
        ),

        _sparkle(
          bottom: 140,
          left: 50,
          size: 10,
          color: const Color(0xFF60D8FA),
        ),
      ],
    );
  }

  Widget _sparkle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Icon(
        Icons.auto_awesome,
        size: size,
        color: color,
      ),
    );
  }
}
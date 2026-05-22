import 'package:flutter/material.dart';

class FeaturesCardWidget extends StatelessWidget {
  const FeaturesCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.8),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
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
            iconColor: const Color(0xFF8B5CF6),
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
            iconColor: const Color(0xFFF59E0B),
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 60,
      color: const Color(0xFFE5E7EB),
    );
  }
}
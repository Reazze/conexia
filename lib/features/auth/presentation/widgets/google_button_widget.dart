import 'package:flutter/material.dart';

import 'social_button_widget.dart';
import 'google_logo_painter.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButtonWidget(
      onTap: () {
        // TODO:
        // Google Sign In
      },

      backgroundColor: Colors.white,

      borderColor: const Color(0xFFE5E7EB),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          SizedBox(
            width: 22,
            height: 14,

            child: CustomPaint(
              painter: GoogleLogoPainter(),
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            'Continuar con Google',

            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}
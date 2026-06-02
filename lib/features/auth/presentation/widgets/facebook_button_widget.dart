import 'package:conexia/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'social_button_widget.dart';

class FacebookButtonWidget extends StatelessWidget {
  const FacebookButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButtonWidget(
      onTap: () {
        // TODO:
        // Facebook Login
      },

      backgroundColor:
          const Color(0xFF1877F2),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Container(
            width: 24,
            height: 24,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),

            child: const Center(
              child: Text(
                'f',

                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1877F2),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            'Continuar con Facebook',

            style: AppTextStyles.button,
          ),
        ],
      ),
    );
  }
}
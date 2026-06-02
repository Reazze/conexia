import 'package:flutter/material.dart';

import 'social_button_widget.dart';

class AppleButtonWidget extends StatelessWidget {
  const AppleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButtonWidget(
      onTap: () {
        // TODO:
        // Apple Login
      },

      backgroundColor:
          const Color(0xFF1A1A1A),

      child: const Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            Icons.apple,
            color: Colors.white,
            size: 29,
          ),

          SizedBox(width: 12),

          Text(
            'Continuar con Apple',

            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
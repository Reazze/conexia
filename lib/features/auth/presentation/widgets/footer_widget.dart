import 'package:conexia/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:conexia/screens/register/register_step1_screen.dart';



class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            const Text(
              '💜',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(width: 8),

            RichText(
              text: TextSpan(
                style:AppTextStyles.footer,

                children: [
                  const TextSpan(
                    text:
                        '¿No tienes cuenta? ',
                  ),

                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const RegisterStep1Screen()));
                      },

                      child: const Text(
                        'Regístrate aquí',

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w600,

                          color:
                              Color(0xFF6D28D9),

                          decoration:
                              TextDecoration
                                  .underline,

                          decorationColor:
                              Color(0xFF6D28D9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
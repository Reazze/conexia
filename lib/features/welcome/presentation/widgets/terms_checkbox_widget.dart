import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/welcome_provider.dart';

class TermsCheckboxWidget extends ConsumerWidget {
  const TermsCheckboxWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final acceptTerms =
        ref.watch(acceptTermsProvider);

    return Row(
      children: [
        Checkbox(
          value: acceptTerms,

          activeColor: const Color(0xFF8B5CF6),

          onChanged: (value) {
            ref
                .read(acceptTermsProvider.notifier)
                .state = value!;
          },
        ),

        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 13,
              ),
              children: [
                TextSpan(text: 'Acepto los '),

                TextSpan(
                  text: 'términos y condiciones',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
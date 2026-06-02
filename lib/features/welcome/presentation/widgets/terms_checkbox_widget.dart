import 'package:conexia/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:conexia/core/theme/app_colors.dart';

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

          activeColor: AppColors.primary,

          onChanged: (value) {
            ref
                .read(acceptTermsProvider.notifier)
                .state = value!;
          },
        ),

        Expanded(
          child: RichText(
            text: const TextSpan(
              style: AppTextStyles.footer,
              children: [
                TextSpan(text: 'Acepto los '),

                TextSpan(
                  text: 'términos y condiciones',
                  style: TextStyle(
                    color: AppColors.primary,
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
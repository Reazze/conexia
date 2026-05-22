import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/welcome_provider.dart';

// import '../../../../auth/presentation/pages/login_page.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  const PrimaryButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final acceptTerms =
        ref.watch(acceptTermsProvider);

    return SizedBox(
      width: double.infinity,
      height: 56,

      child: ElevatedButton(
        onPressed: acceptTerms
            ? () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const LoginPage(),
                //   ),
                // );
              }
            : null,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),

        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF8B5CF6),
                Color(0xFF6D28D9),
              ],
            ),

            borderRadius:
                BorderRadius.circular(30),
          ),

          child: const Center(
            child: Text(
              'Comenzar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/illustration_widget.dart';
import '../widgets/title_section_widget.dart';
import '../widgets/logo_section_widget.dart';
import '../widgets/features_card_widget.dart';
import '../widgets/terms_checkbox_widget.dart';
import '../widgets/primary_button_widget.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 198, 185, 242),
              Color.fromARGB(255, 255, 255, 255),
              Color(0xFFE8EEFF),
              Color.fromARGB(255, 247, 247, 248),
            ],
          ),
        ),
        child:const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                 IllustrationWidget(),

                 TitleSectionWidget(),

                 LogoSectionWidget(),

                 FeaturesCardWidget(),

                 SizedBox(height: 20),

                 TermsCheckboxWidget(),

                 SizedBox(height: 10),

                 PrimaryButtonWidget(),

                 SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../widgets/login_background_widget.dart';
import '../widgets/sparkles_widget.dart';
import '../widgets/login_title_widget.dart';
import '../widgets/login_illustration_widget.dart';
import '../widgets/login_subtitle_widget.dart';

import '../widgets/google_button_widget.dart';
import '../widgets/facebook_button_widget.dart';
import '../widgets/apple_button_widget.dart';
import '../widgets/email_button_widget.dart';

import '../widgets/secondary_login_button_widget.dart';
import '../widgets/footer_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      body: Stack(
        children: [
          const LoginBackgroundWidget(),

          const SparklesWidget(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,

                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                       Spacer(flex: 2),

                       LoginTitleWidget(),

                       SizedBox(height: 18),

                       LoginIllustrationWidget(),

                       SizedBox(height: 16),

                       LoginSubtitleWidget(),

                       SizedBox(height: 28),

                       GoogleButtonWidget(),

                       SizedBox(height: 14),

                       AppleButtonWidget(),

                       SizedBox(height: 14),

                       FacebookButtonWidget(),

                       SizedBox(height: 14),

                       EmailButtonWidget(),

                       Spacer(flex: 1),

                       SecondaryLoginButtonWidget(),

                       SizedBox(height: 14),

                       FooterWidget(),

                       SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
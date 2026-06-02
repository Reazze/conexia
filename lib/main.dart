import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';


import 'features/welcome/presentation/pages/welcome_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ConexiaApp(),
    ),
  );
}

class ConexiaApp extends StatelessWidget {
  const ConexiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conexia',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: const WelcomePage(),
    );
  }
}
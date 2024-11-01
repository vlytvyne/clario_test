import 'package:clario_test/app_colors.dart';
import 'package:clario_test/sign_up_screen.dart';
import 'package:flutter/material.dart';

class ClarioApp extends StatelessWidget {
  const ClarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clario test assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
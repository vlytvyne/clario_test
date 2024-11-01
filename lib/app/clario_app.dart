import 'package:clario_test/ui/styles/app_colors.dart';
import 'package:clario_test/ui/screens/sign_up_screen.dart';
import 'package:clario_test/data/static/string_res.dart';
import 'package:flutter/material.dart';

class ClarioApp extends StatelessWidget {
  const ClarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringRes.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
import 'package:clario_test/app_colors.dart';
import 'package:clario_test/clario_text_input_field.dart';
import 'package:clario_test/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import 'gradient_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  ValidationState _emailValidationState = ValidationState.unknown;
  String? _emailErrorText;

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  ValidationState _passwordValidationState = ValidationState.unknown;

  @override
  void initState() {
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _emailValidationState = ValidationState.unknown;
          _emailErrorText = null;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF4F9FF),
              Color(0xFFE0EDFB),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                child: SvgPicture.asset('assets/images/stars_background.svg'),
                alignment: Alignment.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(120),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.text.title,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(40),
                    ClarioTextInputField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      validationState: _emailValidationState,
                      errorText: _emailErrorText,
                    ),
                    const Gap(20),
                    ClarioTextInputField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validationState: _passwordValidationState,
                    ),
                    const Gap(40),
                    GradientButton(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF70C3FF),
                          Color(0xFF4B65FF),
                        ],
                      ),
                      onClick: onSignUpClick,
                      label: 'Sign Up',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSignUpClick() {
    _emailFocusNode.unfocus();

    final isEmailValid = EmailValidator(errorText: '').isValid(_emailController.text);
    if (isEmailValid) {
      setState(() {
        _emailValidationState = ValidationState.valid;
      });
    } else {
      setState(() {
        _emailValidationState = ValidationState.notValid;
        _emailErrorText = 'Invalid email';
      });
    }
  }

}

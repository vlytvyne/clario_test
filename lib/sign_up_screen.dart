import 'package:clario_test/app_assets.dart';
import 'package:clario_test/app_colors.dart';
import 'package:clario_test/clario_text_input_field.dart';
import 'package:clario_test/enums.dart';
import 'package:clario_test/string_res.dart';
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
  String? _passwordErrorText;

  ValidationState _passwordEightOrMoreCharacters = ValidationState.unknown;
  ValidationState _passwordUppercaseAndLowercase = ValidationState.unknown;
  ValidationState _passwordAtLeastOneDigit = ValidationState.unknown;

  final _passwordEightOrMoreCharactersValidator = MinLengthValidator(
    8,
    errorText: StringRes.eightCharsOrMore,
  );

  final _passwordUppercaseAndLowercaseValidator = PatternValidator(
    r'(?=.*?[A-Z])(?=.*?[a-z])',
    errorText: StringRes.uppercaseAndLowercaseLetters,
  );

  final _passwordAtLeastOneDigitValidator = PatternValidator(
    r'(?=.*?[0-9])',
    errorText: StringRes.atLeastOneDigit,
  );

  @override
  void initState() {
    _listenFocusNodes();
    _listenControllers();
    super.initState();
  }

  void _listenFocusNodes() {
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _emailValidationState = ValidationState.unknown;
          _emailErrorText = null;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          _passwordValidationState = ValidationState.unknown;
          _passwordErrorText = null;
        });
      }
    });
  }

  void _listenControllers() {
    _passwordController.addListener(() {
      final input = _passwordController.text;

      setState(() {
        _passwordEightOrMoreCharacters = _passwordEightOrMoreCharactersValidator.isValid(input)
          ? ValidationState.valid
          : ValidationState.unknown;
        _passwordUppercaseAndLowercase = _passwordUppercaseAndLowercaseValidator.isValid(input)
          ? ValidationState.valid
          : ValidationState.unknown;
        _passwordAtLeastOneDigit = _passwordAtLeastOneDigitValidator.isValid(input)
          ? ValidationState.valid
          : ValidationState.unknown;
      });
    });
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
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ImageAssets.starsBackground,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Gap(120),
                    Text(
                      StringRes.signUp,
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
                      errorText: _passwordErrorText,
                      hideErrorText: true,
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringRes.eightCharsOrMore,
                              style: _composePasswordHintTextStyle(_passwordEightOrMoreCharacters),
                            ),
                            Text(
                              StringRes.uppercaseAndLowercaseLetters,
                              style: _composePasswordHintTextStyle(_passwordUppercaseAndLowercase),
                            ),
                            Text(
                              StringRes.atLeastOneDigit,
                              style: _composePasswordHintTextStyle(_passwordAtLeastOneDigit),
                            ),
                          ],
                        ),
                      ),
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
                      label: StringRes.signUp,
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

  TextStyle _composePasswordHintTextStyle(ValidationState validationState) {
    return TextStyle(
      fontSize: 13,
      color: switch (_passwordAtLeastOneDigit) {
        ValidationState.valid => AppColors.inputField.successText,
        ValidationState.notValid => AppColors.inputField.errorText,
        ValidationState.unknown => AppColors.inputField.enabledText,
      },
    );
  }

  void onSignUpClick() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    _validateEmail();
    _validatePassword();
  }

  void _validateEmail() {
    setState(() {
      final isEmailValid = EmailValidator(errorText: StringRes.invalidEmail)
        .isValid(_emailController.text);
      if (isEmailValid) {
        _emailValidationState = ValidationState.valid;
      } else {
        _emailValidationState = ValidationState.notValid;
        _emailErrorText = StringRes.invalidEmail;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      final password = _passwordController.text;

      _passwordEightOrMoreCharacters = _passwordEightOrMoreCharactersValidator.isValid(password)
        ? ValidationState.valid
        : ValidationState.notValid;
      _passwordUppercaseAndLowercase = _passwordUppercaseAndLowercaseValidator.isValid(password)
        ? ValidationState.valid
        : ValidationState.notValid;
      _passwordAtLeastOneDigit = _passwordAtLeastOneDigitValidator.isValid(password)
        ? ValidationState.valid
        : ValidationState.notValid;

      final isPasswordValid = [
        _passwordEightOrMoreCharacters,
        _passwordAtLeastOneDigit,
        _passwordUppercaseAndLowercase
      ].every((e) => e == ValidationState.valid);

      if (isPasswordValid) {
        _passwordValidationState = ValidationState.valid;
      } else {
        _passwordValidationState = ValidationState.notValid;
        _passwordErrorText = StringRes.invalidPassword;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

}

import 'package:clario_test/app/app_assets.dart';
import 'package:clario_test/ui/styles/app_colors.dart';
import 'package:clario_test/ui/widgets/input_fields/clario_text_input_field.dart';
import 'package:clario_test/data/static/enums.dart';
import 'package:clario_test/data/static/string_res.dart';
import 'package:clario_test/ui/widgets/input_fields/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import '../widgets/buttons/gradient_button.dart';

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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                        _buildTitle(),
                        const Gap(40),
                        _buildEmailInputField(),
                        const Gap(20),
                        buildPasswordInputField(),
                        const Gap(20),
                        _buildPasswordRealtimeHints(),
                        const Gap(40),
                        _buildSignUpButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      StringRes.signUp,
      style: TextStyle(
        color: AppColors.text.title,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailInputField() {
    return ClarioTextInputField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      validationState: _emailValidationState,
      errorText: _emailErrorText,
      hintText: StringRes.enterYourEmail,
      maxLength: 120,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
    );
  }

  Widget buildPasswordInputField() {
    return PasswordInputField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      validationState: _passwordValidationState,
      errorText: _passwordErrorText,
      hideErrorText: true,
      hintText: StringRes.createYourPassword,
      maxLength: 64,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
    );
  }

  Widget _buildPasswordRealtimeHints() {
    return Align(
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
    );
  }

  Widget _buildSignUpButton() {
    return GradientButton(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF70C3FF),
          Color(0xFF4B65FF),
        ],
      ),
      onClick: _onSignUpClick,
      label: StringRes.signUp,
    );
  }

  TextStyle _composePasswordHintTextStyle(ValidationState validationState) {
    return TextStyle(
      fontSize: 13,
      color: switch (validationState) {
        ValidationState.valid => AppColors.inputField.successText,
        ValidationState.notValid => AppColors.inputField.errorText,
        ValidationState.unknown => AppColors.inputField.enabledText,
      },
    );
  }

  void _onSignUpClick() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    _validateEmail();
    _validatePassword();
  }

  void _validateEmail() {
    setState(() {
      final email = _emailController.text;

      final isEmailValid = EmailValidator(errorText: StringRes.invalidEmail)
        .isValid(email);
      if (isEmailValid) {
        _emailValidationState = ValidationState.valid;
      } else {
        _emailValidationState = ValidationState.notValid;
        if (email.isEmpty) {
          _emailErrorText = StringRes.cantBeEmpty;
        } else {
          _emailErrorText = StringRes.invalidEmail;
        }
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
        _passwordUppercaseAndLowercase,
        _passwordAtLeastOneDigit,
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

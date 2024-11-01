import 'package:clario_test/data/static/enums.dart';
import 'package:clario_test/ui/styles/app_colors.dart';
import 'package:clario_test/ui/widgets/input_fields/clario_text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordInputField extends StatefulWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValidationState validationState;
  final String? errorText;
  final bool hideErrorText;
  final Widget? suffixIcon;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;


  const PasswordInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validationState = ValidationState.unknown,
    this.errorText,
    this.hideErrorText = false,
    this.suffixIcon,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLength,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ClarioTextInputField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      validationState: widget.validationState,
      errorText: widget.errorText,
      hideErrorText: widget.hideErrorText,
      obscureText: !_passwordVisible,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      hintText: widget.hintText,
      suffixIcon: IconButton(
        icon: Icon(
          _passwordVisible
            ? Icons.visibility
            : Icons.visibility_off,
          color: switch (widget.validationState) {
            ValidationState.unknown => AppColors.inputField.enabledIcon,
            ValidationState.valid => AppColors.inputField.successIcon,
            ValidationState.notValid => AppColors.inputField.errorIcon,
          }
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    );
  }
}

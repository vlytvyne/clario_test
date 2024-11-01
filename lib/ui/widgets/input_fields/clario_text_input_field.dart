import 'package:clario_test/ui/styles/app_colors.dart';
import 'package:clario_test/data/static/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClarioTextInputField extends StatefulWidget {

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
  

  const ClarioTextInputField({
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
  State<ClarioTextInputField> createState() => _ClarioTextInputFieldState();
}

class _ClarioTextInputFieldState extends State<ClarioTextInputField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: AppColors.inputField.cursor,
      obscureText: widget.obscureText,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: switch (widget.validationState) {
        ValidationState.unknown => TextStyle(color: AppColors.inputField.enabledText,),
        ValidationState.valid => TextStyle(color: AppColors.inputField.successText,),
        ValidationState.notValid => TextStyle(color: AppColors.inputField.errorText,),
      },
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.validationState == ValidationState.notValid
            ? AppColors.inputField.errorText
            : AppColors.inputField.enabledText,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        suffixIcon: widget.suffixIcon,
        errorText: widget.errorText,
        errorStyle: TextStyle(
          color: AppColors.inputField.errorText,
          fontSize: widget.hideErrorText ? 0 : 12,
        ),
        fillColor: switch (widget.validationState) {
          ValidationState.unknown => AppColors.inputField.enabledBackground,
          ValidationState.valid => AppColors.inputField.successBackground,
          ValidationState.notValid => AppColors.inputField.errorBackground,
        },
        filled: true,
        border: _composeBorder(AppColors.inputField.enabledBorder),
        enabledBorder: _composeBorder(widget.validationState == ValidationState.valid
          ? AppColors.inputField.successBorder
          : AppColors.inputField.enabledBorder),
        disabledBorder: _composeBorder(AppColors.inputField.enabledBorder),
        focusedBorder: _composeBorder(AppColors.inputField.focusedBorder),
        errorBorder: _composeBorder(AppColors.inputField.errorBorder),
        focusedErrorBorder: _composeBorder(AppColors.inputField.focusedBorder),
      ),
    );
  }

  OutlineInputBorder _composeBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }

}

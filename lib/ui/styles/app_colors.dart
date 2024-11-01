import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  static const seed = Color(0xFF70C3FF);

  static const text = TextColors._();
  static const inputField = InputFieldColors._();

}

class TextColors {

  const TextColors._();

  final title = const Color(0xFF4A4E71);
  final onButton = Colors.white;

}

class InputFieldColors {

  const InputFieldColors._();

  final cursor = const Color(0xFF4A4E71);

  final enabledBackground = Colors.white;
  final successBackground = Colors.white;
  final errorBackground = const Color(0xFFFDEFEE);

  final enabledBorder = Colors.white;
  final successBorder = const Color(0xFF27B274);
  final errorBorder = const Color(0xFFFF8080);
  final focusedBorder = const Color(0xFF4A4E71);

  final enabledText = const Color(0xFF4A4E71);
  final successText = const Color(0xFF27B274);
  final errorText = const Color(0xFFFF8080);

  final icon = const Color(0xFF7C8696);

}
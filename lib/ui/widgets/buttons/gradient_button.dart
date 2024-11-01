import 'package:clario_test/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {

  final Gradient gradient;
  final VoidCallback? onClick;
  final String label;

  final double height;
  final double width;

  const GradientButton({
    super.key,
    required this.gradient,
    required this.onClick,
    required this.label,
    this.height = 48,
    this.width = 240,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white.withOpacity(0.5),
            onTap: onClick,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.text.onButton,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

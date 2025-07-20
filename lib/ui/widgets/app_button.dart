import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? titleColor;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.bgColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor ?? Colors.black),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h))
      ),
      child: Text(title, style: TextStyle(color: titleColor ?? Colors.white)),
    );
  }
}

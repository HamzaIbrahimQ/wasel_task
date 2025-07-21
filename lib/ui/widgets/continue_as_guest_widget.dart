import 'package:flutter/material.dart';

class ContinueAsGuest extends StatelessWidget {
  final VoidCallback onTap;

  const ContinueAsGuest({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          'Continue as a guest',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

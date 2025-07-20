import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/cubits/signup/signup_cubit.dart';
import 'package:wasel_task/ui/signup/signup_screen.dart';

class SignupPromptWidget extends StatelessWidget {
  const SignupPromptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Signup Now',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SignupCubit(),
                        child: const SignupScreen(),
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

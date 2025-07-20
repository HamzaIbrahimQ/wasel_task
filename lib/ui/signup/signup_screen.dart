import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/signup/signup_cubit.dart';
import 'package:wasel_task/cubits/signup/signup_state.dart';
import 'package:wasel_task/utils/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          /// Signup success
          if (state is SignupSuccess) {
            //
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your account has been created successfully!')),
            );
          }

          /// Signup occurred
          if (state is SignupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Please check your internet connection and try again')),
            );
          }

          /// No internet
          if (state is SignupFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please check your internet connection and try again')),
            );
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding:  EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                /// Email
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.validateEmail,
                ),

                  8.verticalSpace,

                /// Password
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      obscureText: !_showPassword,
                      validator: Validators.validatePassword,
                    );
                  },
                ),


                20.verticalSpace,

                /// signup button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignupCubit>().signup(_emailController.text, _passwordController.text);
                    }
                  },
                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black)),
                  child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                ),
              ],),
            ),
          );
        },
      ),
    );
  }
}

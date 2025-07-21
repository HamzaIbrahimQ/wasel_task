import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/cubits/login/login_cubit.dart';
import 'package:wasel_task/cubits/login/login_state.dart';
import 'package:wasel_task/cubits/products/products_cubit.dart';
import 'package:wasel_task/ui/products/ui/products_screen.dart';
import 'package:wasel_task/ui/widgets/app_button.dart';
import 'package:wasel_task/ui/widgets/app_version_widget.dart';
import 'package:wasel_task/ui/widgets/continue_as_guest_widget.dart';
import 'package:wasel_task/ui/widgets/signup_prompt_widget.dart';
import 'package:wasel_task/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      appBar: AppBar(title: const Text('Login'), centerTitle: true, automaticallyImplyLeading: false),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          /// Login success
          if (state is LoginSuccess) {
            _navigateToProductsScreenWithReplacement();
          }

          /// Error occurred
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Please check your internet connection and try again')),
            );
          }

          /// No internet
          if (state is LoginFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please check your internet connection and try again')),
            );
          }
        },
        buildWhen: (prev, cur) => cur is! LoginSuccess,
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: EdgeInsets.all(16.w),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Email
                    TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
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
                          onFieldSubmitted: (val) => _doLogin(),
                          validator: Validators.validatePassword,
                        );
                      },
                    ),

                    16.verticalSpace,

                    const SignupPromptWidget(),

                    20.verticalSpace,

                    /// Login button
                    AppButton(
                      onPressed: () => _doLogin(),
                      title: 'Login',
                    ),

                    20.verticalSpace,

                    /// Guest option
                    ContinueAsGuest(onTap: () => _navigateToProductsScreen()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AppVersionWidget(),
    );
  }

  void _doLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(_emailController.text.trim(), _passwordController.text.trim());
    }
  }

  void _navigateToProductsScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ProductsCubit()..getProducts(),
          child: const ProductsScreen(),
        ),
      ),
    );
  }

  /// Go to products screen and remove all other screens from the stack
  void _navigateToProductsScreenWithReplacement() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ProductsCubit()..getProducts(),
          child: const ProductsScreen(),
        ),
      ),
      (route) => false,
    );
  }
}

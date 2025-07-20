import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/cubits/login/login_cubit.dart';
import 'package:wasel_task/cubits/products/products_cubit.dart';
import 'package:wasel_task/cubits/splash/splash_cubit.dart';
import 'package:wasel_task/cubits/splash/splash_state.dart';
import 'package:wasel_task/ui/login/login_screen.dart';
import 'package:wasel_task/ui/products/ui/products_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          _navigateToProducts(context);
        }

        if (state is SplashNavigateToLogin) {
          _navigateToLogin(context);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  /// Go to products
  void _navigateToProducts(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => ProductsCubit()..getProducts(),
          child: const ProductsScreen(),
        ),
      ),
    );
  }

  /// Go to login
  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}

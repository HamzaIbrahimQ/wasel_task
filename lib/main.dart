import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/cubits/splash/splash_cubit.dart';
import 'package:wasel_task/firebase_options.dart';
import 'package:wasel_task/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Portrait up only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Init firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(create: (_) => CartCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wasel Task',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocProvider(
            create: (context) => SplashCubit()..checkAuthStatus(),
            child: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}

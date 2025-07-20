import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> with Utility {
  SplashCubit() : super(SplashInitial());

  /// Check if user is already logged in
  Future<void> checkAuthStatus() async {
    final _isConnected = await checkInternetConnection();
    if (_isConnected) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        /// Logged in
        emit(SplashNavigateToHome());
      } else {
        /// Not logged in
        emit(SplashNavigateToLogin());
      }
    } else {
      /// No internet
      emit(SplashNavigateToLogin());
    }
  }
}

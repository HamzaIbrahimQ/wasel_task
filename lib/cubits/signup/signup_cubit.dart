import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/cubits/signup/signup_state.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

import 'signup_repo.dart';

class SignupCubit extends Cubit<SignupState> with Utility {
  final SignupRepo _repo = SignupRepo();

  SignupCubit() : super(SignupInitial());

  Future<void> signup(String email, String password) async {
    final _isConnected = await checkInternetConnection();
    if (_isConnected) {
      emit(SignupLoading());

      try {
        await _repo.signup(email: email, password: password);
        emit(SignupSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignupError(error: e.message ?? 'Signup error'));
      } catch (e) {
        emit(SignupError(error: e.toString()));
      }
    } else {
      /// No internet
      emit(SignupFailed());
    }
  }
}

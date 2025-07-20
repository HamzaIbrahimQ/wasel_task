import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wasel_task/constatnts/shared_preference_keys.dart';
import 'package:wasel_task/cubits/login/login_repo.dart';
import 'package:wasel_task/cubits/login/login_state.dart';
import 'package:wasel_task/helpers/shared_preference_helper.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

class LoginCubit extends Cubit<LoginState> with Utility {
  final LoginRepo _repo = LoginRepo();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    final _isConnected = await checkInternetConnection();
    if (_isConnected) {
      emit(LoginLoading());

      try {
        await _repo.login(email: email, password: password);
        await SharedPreferenceHelper.saveBooleanValue(key: SharedPreferenceKeys.isLoggedIn, value: true);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(LoginError(error: e.message ?? 'Login error'));
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    } else {
      /// No internet
      emit(LoginFailed());
    }
  }


  /// Get current app version
  Future<String> getBuildVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }
}

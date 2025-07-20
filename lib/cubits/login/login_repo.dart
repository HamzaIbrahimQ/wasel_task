import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}

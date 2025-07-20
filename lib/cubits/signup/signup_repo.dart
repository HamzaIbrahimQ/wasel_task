import 'package:firebase_auth/firebase_auth.dart';

class SignupRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signup({required String email, required String password}) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}

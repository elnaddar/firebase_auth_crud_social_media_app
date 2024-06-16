import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}

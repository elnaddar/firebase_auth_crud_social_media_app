import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _instance = FirebaseAuth.instance;
  Future<UserCredential> createUserWithEmailAndPassword(
          {required String email, required String password}) =>
      _instance.createUserWithEmailAndPassword(
          email: email, password: password);

  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      _instance.signInWithEmailAndPassword(email: email, password: password);
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _instance = FirebaseAuth.instance;
  Future<UserCredential> createUserWithEmailAndPassword({
    String? username,
    required String email,
    required String password,
  }) {
    return _instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      _instance.signInWithEmailAndPassword(email: email, password: password);

  Stream<User?> stateChanges() => _instance.authStateChanges();
  Future<void> signOut() => _instance.signOut();
  User? get currentUser => _instance.currentUser;
  bool get isVerified {
    if (currentUser != null) {
      return currentUser!.emailVerified;
    } else {
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/services/auth_service.dart';
import 'package:firebase_auth_crud_social_media_app/services/store_service.dart';

class UsersRepository {
  final storeService = FireStoreService();
  final authService = AuthService();

  Future<UserCredential> createUserWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  }) {
    return authService
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((cred) async {
      await cred.user!.updateDisplayName(name);
      return cred;
    }).then((cred) async {
      await storeService
          .createDocument(collectionPath: "Users", path: cred.user!.uid, data: {
        'name': name,
        'email': email,
        'role': 'user',
      });
      return cred;
    });
  }

  getCurrentUserData() {
    return {
      'uid': currentUser?.uid,
      'name': currentUser?.displayName,
      'email': currentUser?.email,
      'photoURL': currentUser?.photoURL,
      'phoneNumber': currentUser?.phoneNumber
    };
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersSnapshots() {
    return storeService.getCollection("Users").snapshots();
  }

  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      authService.signInWithEmailAndPassword(email: email, password: password);

  Stream<User?> stateChanges() => authService.stateChanges();

  Future<void> signOut() => authService.signOut();

  User? get currentUser => authService.currentUser;
  bool get isVerified => currentUser?.emailVerified ?? false;
  bool get canUseTheApp => currentUser != null && isVerified;
}

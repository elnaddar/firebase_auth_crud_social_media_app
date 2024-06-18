import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isVerified;
  AuthState(this.isAuthenticated, this.isVerified);
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _firebaseAuth;

  AuthCubit(this._firebaseAuth)
      : super(AuthState(
            _firebaseAuth.currentUser != null, _firebaseAuth.isVerified)) {
    _firebaseAuth.stateChanges().listen((user) {
      emit(AuthState(user != null, user?.emailVerified ?? false));
    });
  }

  changeVerified(bool isVerified) {
    emit(AuthState(state.isAuthenticated, isVerified));
  }
}

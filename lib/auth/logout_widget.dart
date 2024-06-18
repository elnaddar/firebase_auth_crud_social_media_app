import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RepositoryProvider.of<FirebaseAuthService>(context)
        .signOut()
        .onError((FirebaseAuthException error, stackTrace) {
      if (context.mounted) {
        context.pop();
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("Error"),
            content: Text(error.code),
          ),
        );
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

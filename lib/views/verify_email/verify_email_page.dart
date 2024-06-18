import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startEmailVerificationCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final authCubit = context.read<AuthCubit>();
      final usersRepo = context.read<UsersRepository>();
      User? user = usersRepo.currentUser;
      await user?.reload();
      if (user?.emailVerified ?? false) {
        timer.cancel();
        authCubit.changeVerified(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "You can't access the app till you verify your email.",
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  if (kIsWeb || !Platform.isWindows)
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<UsersRepository>()
                            .currentUser!
                            .sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Sent verification email"),
                          ),
                        );
                      },
                      child: const Text("Send Verification Mail."),
                    )
                  else
                    const Text(
                      "Try to open the app from a mobile or web browser to send the verification email.",
                    ),
                  const SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go("/logout");
                    },
                    child: const Text("Signout"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

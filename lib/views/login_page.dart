import 'package:firebase_auth_crud_social_media_app/views/login_form/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: theme.colorScheme.inversePrimary,
                ),
                const Text(
                  "SOCIAL",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 32),
                const LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

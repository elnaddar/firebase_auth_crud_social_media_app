import 'package:firebase_auth_crud_social_media_app/views/register/register_form/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(25),
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: theme.colorScheme.inversePrimary,
                ),
                const Text.rich(
                  TextSpan(text: "SOCIAL"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 32),
                const RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

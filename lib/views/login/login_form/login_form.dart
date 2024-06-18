import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/components/form_button.dart';
import 'package:firebase_auth_crud_social_media_app/components/input_form_field.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/form_validators.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/show_loading_indicator.dart';
import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_map/form_map.dart';
import 'package:go_router/go_router.dart';

enum LoginFormEnum { email, password }

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formMap = FormMap<LoginFormEnum>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formMap.key,
        child: Column(
          children: [
            InputFormField(
              inputName: LoginFormEnum.email,
              formMap: formMap,
              hintText: "Email",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: LoginFormEnum.password,
              formMap: formMap,
              hintText: "Password",
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              validator: passwordValidator,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ),
            const SizedBox(height: 32),
            FormButton(
              text: "Login",
              onTap: _submitLogin,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "Don't have an account?"),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => context.go("/register"),
                      child: const Text("Register Here"),
                    ),
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            )
          ],
        ));
  }

  void _submitLogin() {
    formMap.submit((data) {
      showLoadingIndicator(context);
      final auth = context.read<FirebaseAuthService>();
      auth
          .signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      )
          .then((value) {
        if (mounted) {
          Navigator.pop(context);
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (mounted) {
          Navigator.pop(context);
          showAdaptiveDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              title: const Text("Error"),
              content: Text(error.code),
            ),
          );
        }
      });
    });
  }
}

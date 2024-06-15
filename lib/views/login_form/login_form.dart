import 'package:firebase_auth_crud_social_media_app/components/form_button.dart';
import 'package:firebase_auth_crud_social_media_app/components/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_map/form_map.dart';

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
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: LoginFormEnum.password,
              formMap: formMap,
              hintText: "Password",
              obscureText: true,
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
              onTap: () {},
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
                      onPressed: () {},
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
}

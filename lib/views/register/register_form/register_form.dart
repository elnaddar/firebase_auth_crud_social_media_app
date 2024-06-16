import 'package:firebase_auth_crud_social_media_app/components/form_button.dart';
import 'package:firebase_auth_crud_social_media_app/components/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:form_map/form_map.dart';

enum RegisterFormEnum { username, email, password, confirmPassword }

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formMap = FormMap<RegisterFormEnum>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formMap.key,
        child: Column(
          children: [
            InputFormField(
              inputName: RegisterFormEnum.username,
              formMap: formMap,
              hintText: "Username",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.email,
              formMap: formMap,
              hintText: "Email",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.password,
              formMap: formMap,
              hintText: "Password",
              obscureText: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.confirmPassword,
              formMap: formMap,
              hintText: "Confirm Password",
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
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
              text: "Register",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "Already have an account?"),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed("/login"),
                      child: const Text("Login Here"),
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

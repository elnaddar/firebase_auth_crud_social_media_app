import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/components/form_button.dart';
import 'package:firebase_auth_crud_social_media_app/components/input_form_field.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/form_validators.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/show_loading_indicator.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_map/form_map.dart';
import 'package:go_router/go_router.dart';

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
              hintText: "Full Name",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().length < 4) {
                  return "Name field is required and cannot be less than 4 characters.";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.email,
              formMap: formMap,
              hintText: "Email",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.password,
              formMap: formMap,
              hintText: "Password",
              obscureText: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              validator: passwordValidator,
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.confirmPassword,
              formMap: formMap,
              hintText: "Confirm Password",
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (formMap[RegisterFormEnum.confirmPassword] !=
                    formMap[RegisterFormEnum.password]) {
                  return "Passwords must match";
                }
                return null;
              },
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
              onTap: _submitRegister,
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
                      onPressed: () => context.go("/login"),
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

  void _submitRegister() {
    formMap.submit((data) {
      showLoadingIndicator(context);
      final auth = context.read<UsersRepository>();
      auth
          .createUserWithNameEmailPassword(
        name: data['username'],
        email: data['email'],
        password: data['password'],
      )
          .then((value) {
        if (mounted) {
          context.pop();
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (mounted) {
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
    }, saveBeforeValidate: true);
  }
}

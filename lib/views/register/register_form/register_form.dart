import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_crud_social_media_app/components/form_button.dart';
import 'package:firebase_auth_crud_social_media_app/components/input_form_field.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/show_loading_indicator.dart';
import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email address';
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null; // Return null if the input is valid
              },
            ),
            const SizedBox(height: 10),
            InputFormField(
              inputName: RegisterFormEnum.password,
              formMap: formMap,
              hintText: "Password",
              obscureText: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) {
                if (password == null || password.trim().isEmpty) {
                  return "Password field is required.";
                }
                String errorMessage = '';
                // Password length greater than 6
                if (password.length < 6) {
                  errorMessage +=
                      '• Password must be longer than 6 characters.\n';
                }
                // Contains at least one uppercase letter
                if (!password.contains(RegExp(r'[A-Z]'))) {
                  errorMessage += '• Uppercase letter is missing.\n';
                }
                // Contains at least one lowercase letter
                if (!password.contains(RegExp(r'[a-z]'))) {
                  errorMessage += '• Lowercase letter is missing.\n';
                }
                // Contains at least one digit
                if (!password.contains(RegExp(r'[0-9]'))) {
                  errorMessage += '• Digit is missing.\n';
                }
                // Contains at least one special character
                if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                  errorMessage += '• Special character is missing.\n';
                }
                // If there are no error messages, the password is valid
                if (errorMessage.isEmpty) return null;
                return errorMessage;
              },
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

  void _submitRegister() {
    formMap.submit((data) {
      showLoadingIndicator(context);
      final auth = context.read<FirebaseAuthService>();
      auth
          .createUserWithEmailAndPassword(
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
    }, saveBeforeValidate: true);
  }
}

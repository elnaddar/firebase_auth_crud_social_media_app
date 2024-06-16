import 'package:firebase_auth_crud_social_media_app/views/login/login_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/register/register_page.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  final String initialRoute = "/login";
  final Map<String, Widget Function(BuildContext)> routes = {
    '/login': (BuildContext context) => const LoginPage(),
    '/register': (p0) => const RegisterPage(),
  };
}

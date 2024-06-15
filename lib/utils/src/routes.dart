import 'package:firebase_auth_crud_social_media_app/views/login_page.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  final String initialRoute = "/login";
  final Map<String, LoginPage Function(BuildContext)> routes = {
    '/login': (BuildContext context) => const LoginPage(),
  };
}

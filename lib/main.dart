import 'package:firebase_auth_crud_social_media_app/utils/utils_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final UtilsManager utils = UtilsManager();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: utils.routesManager.initialRoute,
      routes: utils.routesManager.routes,
      theme: utils.themeManager.lightMode,
      darkTheme: utils.themeManager.darkMode,
      themeMode: ThemeMode.system,
    );
  }
}

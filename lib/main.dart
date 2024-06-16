import 'package:firebase_auth_crud_social_media_app/firebase_options.dart';
import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:firebase_auth_crud_social_media_app/utils/utils_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(RepositoryProvider(
    create: (context) => FirebaseAuthService(),
    child: MainApp(),
  ));
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

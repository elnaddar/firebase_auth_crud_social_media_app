import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/firebase_options.dart';
import 'package:firebase_auth_crud_social_media_app/services/auth_service.dart';
import 'package:firebase_auth_crud_social_media_app/utils/utils_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(RepositoryProvider(
    create: (context) => AuthService(),
    child: BlocProvider(
      create: (context) => AuthCubit(context.read<AuthService>()),
      child: const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context, listen: true);
    final UtilsManager utils = UtilsManager(authCubit: authCubit);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: utils.themeManager.lightMode,
      darkTheme: utils.themeManager.darkMode,
      themeMode: ThemeMode.system,
      routerConfig: utils.routesManager.router, // Use GoRouter instance here
    );
  }
}

import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/firebase_options.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/utils/utils_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationCacheDirectory(),
  );

  runApp(RepositoryProvider(
    create: (context) => UsersRepository(),
    child: BlocProvider(
      create: (context) => AuthCubit(context.read<UsersRepository>()),
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

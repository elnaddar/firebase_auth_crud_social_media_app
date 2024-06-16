import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/utils/src/routes.dart';
import 'package:firebase_auth_crud_social_media_app/utils/src/theme.dart';

class UtilsManager {
  UtilsManager({required this.authCubit})
      : routesManager = RoutesManager(authCubit: authCubit);
  final AuthCubit authCubit;
  final RoutesManager routesManager;
  final themeManager = ThemeManager();
}

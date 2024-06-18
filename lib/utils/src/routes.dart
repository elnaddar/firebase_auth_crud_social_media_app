import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/auth/logout_widget.dart';
import 'package:firebase_auth_crud_social_media_app/views/errors/page_4xx.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/home_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/login/login_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/profile/profile_pages.dart';
import 'package:firebase_auth_crud_social_media_app/views/register/register_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/users/users_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/verify_email/verify_email_page.dart';
import 'package:go_router/go_router.dart';

class RoutesManager {
  final AuthCubit authCubit;

  RoutesManager({required this.authCubit});

  GoRouter get router => GoRouter(
        initialLocation: authCubit.state.isAuthenticated ? '/' : '/login',
        redirect: (context, state) {
          final isAuthenticated = authCubit.state.isAuthenticated;
          final isVerified = authCubit.state.isVerified;
          final isLoginOrRegister =
              state.uri.path == '/login' || state.uri.path == '/register';

          if (!isAuthenticated && !isLoginOrRegister) return '/401';
          if (isAuthenticated && isLoginOrRegister) return '/403';
          if (isAuthenticated && !isVerified) return '/verify';
          return null;
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/verify',
            builder: (context, state) => const VerifyEmailPage(),
          ),
          GoRoute(
            path: '/logout',
            builder: (context, state) => const LogoutWidget(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/users',
            builder: (context, state) => const UsersPage(),
          ),
          GoRoute(
            path: '/401',
            builder: (context, state) =>
                const Page4xx(title: "401: Unauthorized"),
          ),
          GoRoute(
            path: '/403',
            builder: (context, state) => const Page4xx(title: "403: Forbidden"),
          ),
        ],
        errorBuilder: (context, state) =>
            const Page4xx(title: "404: Page Not Found"),
      );
}

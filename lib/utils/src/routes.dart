import 'package:firebase_auth_crud_social_media_app/auth/auth_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/views/errors/page_4xx.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/home_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/login/login_page.dart';
import 'package:firebase_auth_crud_social_media_app/views/register/register_page.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  final AuthCubit authCubit;

  RoutesManager({required this.authCubit});

  // Define your routes
  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/401': (context) => const Page4xx(title: "401: Unauthorized"),
    '/403': (context) => const Page4xx(title: "403: Forbidden")
  };

  RouteInformationParser<Object> get routeInformationParser {
    return RouteInformationParserImpl();
  }

  RouterDelegate<Object> get routerDelegate {
    return RouterDelegateImpl(authCubit: authCubit, routes: routes);
  }
}

class RouteInformationParserImpl extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    return uri.path;
  }

  @override
  RouteInformation restoreRouteInformation(Object configuration) {
    return RouteInformation(uri: Uri.parse(configuration as String));
  }
}

class RouterDelegateImpl extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  final AuthCubit authCubit;
  final Map<String, WidgetBuilder> routes;
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouterDelegateImpl({required this.authCubit, required this.routes});

  @override
  Widget build(BuildContext context) {
    final String initialRoute =
        authCubit.state.isAuthenticated ? "/" : "/login";
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      pages: routes.keys
          .map((key) => MaterialPage(child: routes[key]!(context)))
          .toList(),
      onGenerateRoute: (settings) {
        final routeName = settings.name;

        if (!routes.containsKey(routeName)) {
          return null;
        }

        final isAuthenticated = authCubit.state.isAuthenticated;
        final isAuthRoute = routeName == "/login" || routeName == "/register";
        final isNotAuthRoute = !isAuthRoute;

        if (isAuthenticated && isAuthRoute) {
          return MaterialPageRoute(builder: routes["/403"]!);
        }

        if (!isAuthenticated && isNotAuthRoute) {
          return MaterialPageRoute(builder: routes["/401"]!);
        }

        return MaterialPageRoute(builder: routes[routeName]!);
      },
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {
    // Here, we can handle deep linking and navigation state restoration
  }
}

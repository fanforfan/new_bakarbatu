import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/authentication/presentation/pages/login_page.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/contribution_page.dart';
import 'package:new_bakarbatu/features/home/presentation/pages/home_page.dart';

class Routes {
  static const String initialPage = '/';
  static const String homeRoute = '/homePage';
  static const String loginRoute = '/loginPage';
  static const String registerRoute = '/registerPage';
  static const String contributionRoute = '/contributionPage';
}

Map<String, WidgetBuilder> get CustomRoutes {
  return <String, WidgetBuilder>{
    Routes.homeRoute: (context) => const HomePage(),
    Routes.loginRoute: (context) => const LoginPage(),
    Routes.contributionRoute: (context) => const ContributionPage()
  };
}
import 'package:cityinpocket/View/Auth/login_page.dart';
import 'package:cityinpocket/View/Auth/signup_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Widget/nav_bar.dart';

class Routes {
  static String login = '/login';
  static String signup = '/signup';
  static String navbar = '/navbar';
}
final getPages = [
  GetPage(
    name: Routes.login,
    page: () =>  LoginPage(),
  ),
  GetPage(
    name: Routes.signup,
    page: () => SignUpPage(),
  ),
  GetPage(
    name: Routes.navbar,
    page: () => const SnakeNavigationBarExampleScreen(),
  ),
];
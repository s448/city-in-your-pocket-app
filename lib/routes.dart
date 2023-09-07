import 'package:cityinpocket/View/Auth/login_page.dart';
import 'package:cityinpocket/View/Auth/signup_page.dart';
import 'package:cityinpocket/View/BuySell/add_item_page.dart';
import 'package:cityinpocket/View/BuySell/buy_sell_view_page.dart';
import 'package:cityinpocket/View/BuySell/item_details.dart';
import 'package:cityinpocket/View/favorites_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Widget/nav_bar.dart';

class Routes {
  static String login = '/login';
  static String signup = '/signup';
  static String navbar = '/navbar';
  static String buySell = '/buy_sell';
  static String addItem = '/add_item';
  static String productDetails = '/product_details';
  static String favorites = '/favorites';
}

final getPages = [
  GetPage(
    name: Routes.login,
    page: () => LoginPage(),
  ),
  GetPage(
    name: Routes.signup,
    page: () => SignUpPage(),
  ),
  GetPage(
    name: Routes.navbar,
    page: () => const SnakeNavigationBarExampleScreen(),
  ),
  GetPage(
    name: Routes.buySell,
    page: () => const BuySellPage(),
  ),
  GetPage(
    name: Routes.addItem,
    page: () => AddItem(),
  ),
  GetPage(
    name: Routes.productDetails,
    page: () => ProductDetails(),
  ),
  GetPage(
    name: Routes.favorites,
    page: () => FavoritesPage(),
  ),
];

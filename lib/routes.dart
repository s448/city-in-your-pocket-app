import 'package:cityinpocket/View/Auth/login_page.dart';
import 'package:cityinpocket/View/Auth/signup_page.dart';
import 'package:cityinpocket/View/BuySell/add_item_page.dart';
import 'package:cityinpocket/View/BuySell/buy_sell_view_page.dart';
import 'package:cityinpocket/View/BuySell/item_details.dart';
import 'package:cityinpocket/View/Jobs/add_job.dart';
import 'package:cityinpocket/View/Jobs/job_details.dart';
import 'package:cityinpocket/View/Jobs/jobs_view_page.dart';
import 'package:cityinpocket/View/favorites_page.dart';
import 'package:cityinpocket/View/search_page.dart';
// import 'package:cityinpocket/View/notifications.dart';
import 'package:cityinpocket/Widget/adSlider/ad_details.dart';
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
  static String jobs = '/jobs';
  static String addJob = '/add_job';
  static String jobDetails = '/job_details';
  static String adDetails = '/ad_details';
  // static String notifications = '/notifications';
  static String search = '/search';
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
  GetPage(
    name: Routes.jobs,
    page: () => JobPage(),
  ),
  GetPage(
    name: Routes.addJob,
    page: () => AddJob(),
  ),
  GetPage(
    name: Routes.jobDetails,
    page: () => JobDetails(),
  ),
  GetPage(
    name: Routes.adDetails,
    page: () => AdDetails(),
  ),
  // GetPage(
  //   name: Routes.notifications,
  //   page: () => NotificationsPage(),
  // ),
  GetPage(
    name: Routes.search,
    page: () => SearchScreen(),
  ),
];

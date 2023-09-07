import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/favorites_controller.dart';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/shared_prefs_controller.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => SharedPreferences.getInstance());
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _sharedPrefController =
      Get.put(SharedPrefsController(), permanent: true);
  final userController = Get.put(UserController(), permanent: true);
  final favoritesController = Get.put(FavoritesController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        textDirection: TextDirection.rtl,
        debugShowCheckedModeBanner: false,
        theme: StyleManager.themeManager,
        // initialRoute: Routes.navbar,
        initialRoute: _sharedPrefController.userAuthenticated()
            ? Routes.navbar
            : Routes.login,
        getPages: getPages);
  }
}

import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/View/Auth/signup_page.dart';
import 'package:cityinpocket/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'View/Auth/login_page.dart';
import 'View/home_page.dart';
import 'Widget/nav_bar.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      initialRoute: Routes.login,
      getPages: getPages
    );
  }
}

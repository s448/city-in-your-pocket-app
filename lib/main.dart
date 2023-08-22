import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';
import 'Widget/nav_bar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      home: const SnakeNavigationBarExampleScreen(),
    );
  }
}


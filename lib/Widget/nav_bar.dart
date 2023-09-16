import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/auth_controller.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/View/favorites_page.dart';
import 'package:cityinpocket/View/messaging_page.dart';
import 'package:cityinpocket/View/home_page.dart';
import 'package:cityinpocket/View/Profile/profile_page.dart';
// import 'package:cityinpocket/routes.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SnakeNavigationBarExampleScreen extends StatefulWidget {
  const SnakeNavigationBarExampleScreen({Key? key}) : super(key: key);

  @override
  _SnakeNavigationBarState createState() => _SnakeNavigationBarState();
}

class _SnakeNavigationBarState extends State<SnakeNavigationBarExampleScreen> {
  final _authController = Get.put(AuthController());
  final _sharedPrefsController = Get.find<SharedPrefsController>();
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.fromLTRB(12, 2, 12, 10);

  int _selectedItemPosition = 0;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  SnakeShape snakeShape = SnakeShape.circle;

  Color selectedColor = ColorManager.primaryColor;
  Color unselectedColor = ColorManager.navBarUnselectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: _selectedItemPosition == 3 &&
                _sharedPrefsController.userAuthenticated()
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: (() {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // <-- SEE HERE
                        title: const Text('تسجيل الخروج'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('هل تريد تسجيل الخروج ؟'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('لا'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'نعم',
                              style: StyleManager.warningTextStyle,
                            ),
                            onPressed: () {
                              _authController.logout();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
              )
            : null,
        centerTitle: true,
        title: const Text(
          appName,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _pages.elementAt(_selectedItemPosition), //New
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        elevation: 20.0,
        shadowColor: Colors.black,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mark_unread_chat_alt_outlined),
              label: 'My chats'),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.heart_outline,
              ),
              label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}

List<Widget> _pages = <Widget>[
  const HomePage(),
  MessagingPage(),
  FavoritesPage(),
  const ProfilePage(),
];

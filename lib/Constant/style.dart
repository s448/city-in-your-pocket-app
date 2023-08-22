import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class StyleManager {
  //font name
  static const font = "regular";

  //text style
  static const TextStyle headline1 = TextStyle(
    fontSize: 23,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontFamily: font,
    color: Colors.grey,
  );

  //light theme
  static final themeManager = ThemeData(
      primaryColor: ColorManager.primaryColorDark,
      hintColor: ColorManager.accentColor,
      appBarTheme: const AppBarTheme(
        color: ColorManager.primaryColorDark,
        titleTextStyle: headline1
      )
  );

  //box decorations
  static const BoxDecoration roundedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: ColorManager.secondaryColor,
  );

  static const BoxDecoration gradientBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    gradient: LinearGradient(
      colors: [ColorManager.primaryColorDark, ColorManager.primaryColorLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  //button styles
  static final ButtonStyle primaryButtonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(Get.width, Get.height * 0.05)),
    backgroundColor: MaterialStateProperty.all(ColorManager.primaryColor),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
    // Add more properties like padding, shape, etc.
  );

  static final ButtonStyle secondaryButtonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(Get.width, Get.height * 0.05)),
    backgroundColor: MaterialStateProperty.all(ColorManager.secondaryColor),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
    // Add more properties like padding, shape, etc.
  );
}
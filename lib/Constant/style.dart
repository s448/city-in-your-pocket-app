import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class StyleManager {
  //font name
  static const font = "regular";

  //text style
  static const TextStyle headline1 = TextStyle(
    fontSize: 18,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );


  static const TextStyle headlineWhite = TextStyle(
      fontSize: 18,
      fontFamily: font,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1);

  static const TextStyle bodyText1 =
      TextStyle(fontSize: 16, fontFamily: font, color: Colors.black, height: 1);

  static const TextStyle bodyWithPrimaryColor =
  TextStyle(fontSize: 16, fontFamily: font, color: ColorManager.primaryColorDark, height: 1);


  static const TextStyle bodyWhiteText = TextStyle(
    fontSize: 16,
    fontFamily: font,
    height: 1,
    color: Colors.white,
  );

  //light theme
  static final themeManager = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      primaryColor: ColorManager.primaryColorDark,
      hintColor: ColorManager.accentColor,
      appBarTheme: const AppBarTheme(
          color: ColorManager.primaryColorDark, titleTextStyle: headline1));

  //box decorations
  static const BoxDecoration roundedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: ColorManager.secondaryColor,
  );
  static const BoxDecoration shadowBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.vertical(
        top: Radius.circular(0), bottom: Radius.circular(15)),
    color: Colors.black45,
  );

  static const BoxDecoration gradientBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    gradient: LinearGradient(
      colors: [ColorManager.primaryColorLight,ColorManager.primaryColorDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  //button styles
  static final ButtonStyle primaryButtonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(Get.width, Get.height * 0.05)),
    backgroundColor: MaterialStateProperty.all(ColorManager.primaryColor),
    textStyle: MaterialStateProperty.all(StyleManager.headlineWhite),
    // Add more properties like padding, shape, etc.
  );

  static final ButtonStyle secondaryButtonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(Get.width, Get.height * 0.05)),
    backgroundColor: MaterialStateProperty.all(ColorManager.secondaryColor),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
    // Add more properties like padding, shape, etc.
  );
}

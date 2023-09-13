import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class StyleManager {
  //font name
  static const font = "regular";

  //text style
  static const TextStyle headline1 = TextStyle(
    fontSize: 14,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.2,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 15,
    fontFamily: font,
    fontWeight: FontWeight.w700,
    color: Colors.green,
    height: 1.2,
  );

  static const TextStyle title = TextStyle(
    fontSize: 13,
    fontFamily: font,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1.1,
  );

  static const TextStyle warningTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: font,
    color: Colors.redAccent,
    height: 1,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle headlineWhite = TextStyle(
      fontSize: 14,
      fontFamily: font,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.2);

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 12,
    fontFamily: font,
    color: Colors.black,
    height: 1,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle bodyWithPrimaryColor = TextStyle(
    fontSize: 12,
    fontFamily: font,
    color: ColorManager.primaryColorDark,
    fontWeight: FontWeight.w100,
    height: 1,
  );

  static const TextStyle bodyWhiteText = TextStyle(
    fontSize: 12,
    fontFamily: font,
    height: 1.2,
    fontWeight: FontWeight.w100,
    color: Colors.white,
  );

  //light theme
  static final themeManager = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      fontFamily: font,
      primaryColor: ColorManager.primaryColorDark,
      hintColor: ColorManager.accentColor,
      appBarTheme: const AppBarTheme(
          color: ColorManager.primaryColorDark, titleTextStyle: headlineWhite));

  //box decorations
  static const BoxDecoration roundedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: ColorManager.secondaryColor,
  );

  static BoxDecoration borderedRoundedBoxDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    border: Border.all(color: Colors.black54),
    color: ColorManager.secondaryColor,
  );

  static const BoxDecoration dangerRoundedDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Colors.redAccent,
  );
  static BoxDecoration shadowBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: ColorManager.primaryColor,
  );

  static BoxDecoration senderBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: ColorManager.primaryColorDark,
  );

  static BoxDecoration recieverBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: Colors.grey,
  );

  static BoxDecoration listTileStyle = BoxDecoration(
    border: Border.all(
      color: const Color.fromARGB(31, 39, 36, 36),
    ),
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
  );

  static const BoxDecoration gradientBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    gradient: LinearGradient(
      colors: [ColorManager.primaryColorLight, ColorManager.primaryColorDark],
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

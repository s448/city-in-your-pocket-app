import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSign extends StatelessWidget {
  const LoginSign({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offAndToNamed(Routes.login);
      },
      child: Container(
        decoration: StyleManager.senderBoxDecoration,
        child: const ListTile(
          title: Text(
            "تسجيل الدخول",
            style: StyleManager.headlineWhite,
          ),
          subtitle: Text(
            "تحتاج الي تسجيل الدخول لكي تتمكن من استخدام التطبيق",
            style: StyleManager.bodyWhiteText,
          ),
          trailing: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          isThreeLine: false,
        ),
      ),
    );
  }
}

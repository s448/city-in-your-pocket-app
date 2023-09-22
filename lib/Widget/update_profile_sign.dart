import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileSign extends StatelessWidget {
  const UpdateProfileSign({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.editProfile);
      },
      child: Container(
        decoration: StyleManager.senderBoxDecoration,
        padding: const EdgeInsets.all(4.0),
        child: const ListTile(
          title: Text(
            "محتاج تراجع شوية بيانات",
            style: StyleManager.headlineWhite,
          ),
          subtitle: Text(
            "الذهاب الي صفحة التحديث",
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

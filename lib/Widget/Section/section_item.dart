import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionItem extends StatelessWidget {
  const SectionItem({Key? key, required this.icon, required this.title, required this.route}) : super(key: key);
  final IconData icon;
  final String title;
  final String route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //implement the route
      },
      child: Column(
        children: [
        CircleAvatar(
        radius: Get.width * 0.08,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: ColorManager.primaryColorLight,
          size: Get.width *0.09,
        ),
      ),
          Text(
            title,
            style: StyleManager.bodyText1
          ),
        ],
      ),
    );
  }
}

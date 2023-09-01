import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuySellPage extends StatelessWidget {
  const BuySellPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'] ?? "البيع والشراء";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.toNamed(Routes.addItem, arguments: {"type": title});
        },
       // tooltip: "أضف $title للبيع ",
        child: const Icon(CupertinoIcons.add),
      )
    );
  }
}

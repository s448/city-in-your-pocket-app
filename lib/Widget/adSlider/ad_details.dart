import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Model/banner.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdDetails extends StatelessWidget {
  AdDetails({super.key});
  BannerAd bannerAd = Get.arguments['ad'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("التفاصيل"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(6.0),
          width: Get.width,
          child: Text(
            bannerAd.details.toString(),
            softWrap: true,
            textAlign: TextAlign.right,
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          UrlLauncherService.launch(bannerAd.contactUrl.toString());
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: Get.height * 0.1,
            alignment: Alignment.center,
            decoration: StyleManager.shadowBoxDecoration,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'أعرف المزيد',
                  style: StyleManager.headlineWhite,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

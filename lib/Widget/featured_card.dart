import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: StyleManager.gradientBoxDecoration,
      width: Get.width,
      // height: Get.height * 0.35,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Column(
              children: [
                InkWell(
                  onTap: () => Get.toNamed(Routes.jobs),
                  child: const ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        'أعلانات الوظائف',
                        style: StyleManager.headlineWhite,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    subtitle: Text(
                      'هنا يمكنك تصفح الوظائف المتاحة أو حتى أضافة أعلان سواء كنت تبحث عن وظيفة أو تحتاج موظفين في جميع التخصصات',
                      style: StyleManager.bodyWhiteText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.jobs);
                  },
                  style: StyleManager.primaryButtonStyle,
                  child: const Text(
                    'عرض الكل',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            // height: double.infinity,
            child: Image.asset(
              'assets/images/jobs.png',
              fit: BoxFit.contain,
              width: Get.width * 0.3,
            ),
          )
        ],
      ),
    );
  }
}

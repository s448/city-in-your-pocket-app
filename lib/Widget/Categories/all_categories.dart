import 'package:cityinpocket/Constant/Carousel/categories_section.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategories extends StatelessWidget {
  AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جميع الفئات"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        width: Get.width,
        height: Get.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: shoppingCategories.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> element =
                shoppingCategories[index] as Map<String, dynamic>;
            return InkWell(
              onTap: () {
                // Implement the route
                Get.toNamed(Routes.buySell, arguments: {"element": element});
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 8),
                // margin: EdgeInsets.only(right: 12),
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: StyleManager.accentBoxDecoration,
                  // height: Get.height * 0.09,
                  width: Get.width * 0.3,
                  alignment: Alignment.centerRight,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              element['icon'],
                              color: ColorManager.primaryColor,
                              size: Get.width * 0.09,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              element['title'],
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: StyleManager.metaDataText,
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:cityinpocket/Constant/font_sizes.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Widget/Categories/section_item.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer(
      {Key? key, required this.listOfElements, required this.heading})
      : super(key: key);
  final List<dynamic> listOfElements;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                heading,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.headline1,
              ),
              TextButton(
                onPressed: (() => Get.toNamed(Routes.allCategories)),
                child: Text(
                  "عرض كل الفئات",
                  style: StyleManager.metaDataText,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: Get.height * 0.07,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(listOfElements.length, (index) {
                Map<String, dynamic> element =
                    listOfElements[index] as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    // Implement the route
                    Get.toNamed(Routes.buySell,
                        arguments: {"element": element});
                  },
                  child: Container(
                    // width: 100, // Set the desired width of each item
                    margin: EdgeInsets.only(right: 12),
                    child: SectionItem(
                      icon: element['icon'],
                      title: element['title'],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // SizedBox(
        //   width: Get.width,
        //   height: 200,
        //   child: GridView.count(
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     mainAxisSpacing: 12,
        //     crossAxisSpacing: 6.0,
        //     crossAxisCount: 1,
        //     childAspectRatio: (1 / .3),
        //     physics: const ScrollPhysics(),
        //     children: List.generate(listOfElements.length, (index) {
        //       Map<String, dynamic> element =
        //           listOfElements[index] as Map<String, dynamic>;
        //       return InkWell(
        //           onTap: () {
        //             //implement the route
        //             Get.toNamed(Routes.buySell,
        //                 arguments: {"element": element});
        //           },
        //           child: SectionItem(
        //             icon: element['icon'],
        //             title: element['title'],
        //           ));
        //     }),
        //   ),
        // ),
      ],
    );
  }
}

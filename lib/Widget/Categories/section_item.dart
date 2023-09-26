import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionItem extends StatelessWidget {
  const SectionItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  // final BuySell category;
  @override
  Widget build(BuildContext context) {
    // return IntrinsicHeight(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(
    //             color: ColorManager.primaryColorLight,
    //             width: 2,
    //           ),
    //         ),
    //         child: CircleAvatar(
    //           radius: Get.width * 0.06,
    //           backgroundColor: Colors.white,
    //           child: Icon(
    //             icon,
    //             color: ColorManager.primaryColorLight,
    //             size: Get.width * 0.09,
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 3,
    //       ),
    //       Expanded(
    // child: Text(
    //   title,
    //   softWrap: true,
    //   overflow: TextOverflow.ellipsis,
    //   textAlign: TextAlign.center,
    //   maxLines: 2,
    //   style: StyleManager.bodyText1,
    // ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
        padding: EdgeInsets.all(6.0),
        decoration: StyleManager.accentBoxDecoration,
        // height: Get.height * 0.09,
        width: Get.width * 0.3,
        alignment: Alignment.centerRight,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: ColorManager.primaryColor,
                size: Get.width * 0.09,
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: StyleManager.metaDataText,
                ),
              ),
            ],
          ),
        ));
  }
}

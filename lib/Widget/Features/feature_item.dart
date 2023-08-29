import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem(
      {Key? key,
      required this.color,
      required this.title,
      required this.route,
      required this.imgPath})
      : super(key: key);
  final Color color;
  final String title;
  final String imgPath;
  final String route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //implement the route
      },
      child: Container(
        width: Get.width * 0.4,
        // height: Get.height * 0.08,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imgPath),
              ),
              Expanded(
                  child: Text(
                title,
                maxLines: 3,
                softWrap: true,
                    overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

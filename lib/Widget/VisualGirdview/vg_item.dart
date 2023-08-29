import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VGItem extends StatelessWidget {
  final String title;
  final String route;
  final String imagePath;
  const VGItem({
    Key? key,
    required this.route,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(route);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              //category item
              return InkWell(
                onTap: (() => {}),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: StyleManager.roundedBoxDecoration,
                  width: Get.width * 0.4,
                  child: GridTile(
                    //gif of every category
                    footer: Container(
                      decoration: StyleManager.shadowBoxDecoration,
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        "texttexttexts texttexttexts texttexttexts",
                        style: StyleManager.bodyWhiteText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //gif of every category
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://graphicsfamily.com/wp-content/uploads/edd/2021/10/Facebook-Ads-Banner-Design-Photoshop-Tutorial-1180x664.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

import 'package:cityinpocket/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

import '../Constant/style.dart';

class AdCarouselSlider extends StatelessWidget {
  const AdCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Carousel(
      autoScroll: true,
      height: Get.height * 0.35,
      width: Get.width,
      activateIndicatorColor: ColorManager.primaryColor,
      indicatorBarColor: ColorManager.secondaryColor,
      unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
      isCircle: false,
      items: [
        carouselItem(),
        carouselItem(),
        carouselItem(),
      ],
    );
  }

  Widget carouselItem() {
    return InkWell(
      onTap: () {
        //implement the launch here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: StyleManager.roundedBoxDecoration,
        child: Image.network(
          'https://graphicsfamily.com/wp-content/uploads/edd/2021/10/Facebook-Ads-Banner-Design-Photoshop-Tutorial-1180x664.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

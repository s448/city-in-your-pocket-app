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
      //animationPageDuration: const Duration(microseconds: 500),
      indicatorBarColor: ColorManager.secondaryColor,
      unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
      isCircle: true,
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
        decoration: StyleManager.roundedBoxDecoration,
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAGbzrhpTi4Q0o5o0JSRVDSZ6zifJth2yxXYg26zgW&s',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

import 'package:cityinpocket/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import '../Constant/style.dart';

class CarouselSlider extends StatelessWidget {
  const CarouselSlider({Key? key, required this.images}) : super(key: key);
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Carousel(
        autoScroll: true,
        height: Get.height * 0.35,
        width: Get.width,
        autoScrollDuration: const Duration(seconds: 4),
        activateIndicatorColor: ColorManager.primaryColor,
        indicatorBarColor: ColorManager.secondaryColor,
        unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
        isCircle: true,
        items: [for (var image in images) carouselItem(image.toString())]);
  }

  Widget carouselItem(String imgUrl) {
    return InkWell(
      onTap: () {
        //implement the launch here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: StyleManager.roundedBoxDecoration,
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

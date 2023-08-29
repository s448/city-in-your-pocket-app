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
     autoScrollDuration: const Duration(seconds: 4),
      activateIndicatorColor: ColorManager.primaryColor,
      indicatorBarColor: ColorManager.secondaryColor,
      unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
      isCircle: true,
      items: [
        carouselItem("https://graphicsfamily.com/wp-content/uploads/edd/2021/10/Facebook-Ads-Banner-Design-Photoshop-Tutorial-1180x664.jpg"),
        carouselItem("https://cdnb.artstation.com/p/assets/images/images/019/250/843/large/ali-nouman-pocket-t-shirt-add-banner.jpg?1562679888"),
        carouselItem("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5XALJfHrrKrnjfsnfothd0VxTWifzDFrSuw&usqp=CAU"),
      ],
    );
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
          imgUrl ?? '',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

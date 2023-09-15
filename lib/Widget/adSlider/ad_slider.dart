import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Controller/banner_ads_controller.dart';
import 'package:cityinpocket/Model/banner.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({Key? key}) : super(key: key);

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final bannerController = Get.find<BannerAdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => bannerController.listOfAds.isEmpty
        ? const SizedBox(
            height: 2,
          )
        : Carousel(
            autoScroll: true,
            height: Get.height * 0.3,
            width: Get.width,
            autoScrollDuration: const Duration(seconds: 4),
            activateIndicatorColor: ColorManager.primaryColor,
            indicatorBarColor: ColorManager.secondaryColor,
            unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
            isCircle: true,
            items: [
                for (var banner in bannerController.listOfAds)
                  carouselItem(banner)
              ]));
  }

  Widget carouselItem(BannerAd bannerAd) {
    return InkWell(
      onTap: () {
        // print(bannerAd.contactUrl);
        Get.toNamed(Routes.adDetails, arguments: {
          'ad': bannerAd,
        });
      },
      child: Image.network(
        bannerAd.imgUrl!,
        fit: BoxFit.fill,
      ),
    );
  }
}

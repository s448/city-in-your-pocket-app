import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Controller/banner_ads_controller.dart';
import 'package:cityinpocket/Model/banner.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
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
            width: Get.width,
            height: Get.height * 0.25,
            autoScrollDuration: const Duration(seconds: 4),
            activateIndicatorColor: Colors.white,
            indicatorBarColor: Colors.transparent,
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
        switch (bannerAd.navType) {
          case 0:
            //it's an ad with details
            Get.toNamed(Routes.adDetails, arguments: {
              'ad': bannerAd,
            });
            break;
          case 1:
            //it's an ad with direct route
            UrlLauncherService.launch(bannerAd.contactUrl.toString());
            break;
          case 2:
            //it doesn't have a router lonk
            break;
          default:
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.network(
          bannerAd.imgUrl!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

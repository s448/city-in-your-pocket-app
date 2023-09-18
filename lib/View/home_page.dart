import 'package:cityinpocket/Constant/Carousel/categories_section.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/banner_ads_controller.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Widget/adSlider/ad_slider.dart';
import 'package:cityinpocket/Widget/featured_card.dart';
import 'package:cityinpocket/Widget/login_sign.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/Categories/section_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bannerController = Get.put(BannerAdsController());

  final _sharedPrefController = Get.find<SharedPrefsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: Get.height,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.search),
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: StyleManager.listTileStyle,
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: ColorManager.primaryColor),
                        Text(
                          "بحث . .",
                          style: TextStyle(color: ColorManager.primaryColor),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 8.0,
            ),
            // const CarouselSlider(),
            const SizedBox(
              height: 12,
            ),
            SectionContainer(
              listOfElements: shoppingCategories,
              heading: 'بيع وشراء',
            ),
            const SizedBox(
              height: 8.0,
            ),
            _sharedPrefController.userAuthenticated()
                ? const SizedBox()
                : const LoginSign(),
            const SizedBox(height: 15),
            const FeaturedCard(),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

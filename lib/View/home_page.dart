import 'package:cityinpocket/Constant/Carousel/categories_section.dart';
import 'package:cityinpocket/Widget/Features/feature_container.dart';
import 'package:cityinpocket/Widget/ad_slider.dart';
import 'package:cityinpocket/Widget/featured_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/Categories/section_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: Get.height,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AdCarouselSlider(),
            // GridView.count(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     crossAxisCount: 4,
            //     physics: const NeverScrollableScrollPhysics(),
            //     children: const [
            //       VGItem(route: "route", title: "title", imagePath: 'assets/images/coffee_shop.png'),
            //       VGItem(route: "route", title: "title", imagePath: 'assets/images/coffee_shop.png'),
            //       VGItem(route: "route", title: "title", imagePath: 'assets/images/coffee_shop.png'),
            //       VGItem(route: "route", title: "title", imagePath: 'assets/images/coffee_shop.png'),
            //     ]),
           // VGItem(route: "route", title: "title", imagePath: 'assets/images/coffee_shop.png'),
            SectionContainer(
              listOfElements: shoppingCategories,
              heading: 'بيع وشراء',
            ),
            const SizedBox(height: 15),
            const FeaturedCard(),
            const SizedBox(height: 15),
            const FeatureContainer(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

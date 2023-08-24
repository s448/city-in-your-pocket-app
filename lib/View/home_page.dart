import 'package:cityinpocket/Constant/Carousel/categories_section.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Widget/Features/feature_container.dart';
import 'package:cityinpocket/Widget/Features/feature_item.dart';
import 'package:cityinpocket/Widget/ad_slider.dart';
import 'package:flutter/material.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            const AdCarouselSlider(),
            SectionContainer(
              listOfElements: shoppingCategories,
              heading: 'بيع وشراء',
            ),
            const SizedBox(height: 15),
            SectionContainer(
              listOfElements: freelanceCategories,
              heading: 'المهن والأعمال اليدوية',
            ),
            const SizedBox(height: 15),
            const FeatureContainer(),
          ],
        ),
      ),
    );
  }
}

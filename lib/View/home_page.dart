import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Widget/ad_slider.dart';
import 'package:flutter/material.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: [
           const AdCarouselSlider(),
        StaggeredGrid.count(
          crossAxisCount: 4,

          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          axisDirection: AxisDirection.up,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Container(
                color: ColorManager.accentColor,
              )
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 0.8,
              child: Container(
              color: ColorManager.primaryColorLight,
            )
            ),
            StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: Container(
                  color: ColorManager.accentColor,
                )
            ),
            StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 0.8,
                child: Container(
                  color: ColorManager.primaryColorLight,
                )
            ),
          ],
        )
          ],
        ),
      )
    );
  }
}

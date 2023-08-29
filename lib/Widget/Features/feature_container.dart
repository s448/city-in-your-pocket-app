import 'package:cityinpocket/Widget/Features/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeatureContainer extends StatelessWidget {
  const FeatureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      axisDirection: AxisDirection.up,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FeatureItem(
            color: Colors.red.shade100,
            title: "عروض وخصومات",
            route: "route",
            imgPath: "assets/images/discount.png",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FeatureItem(
            color: Colors.indigo.shade100,
            title: "أشياء مفقودة",
            route: "route",
            imgPath: "assets/images/lost_things.png",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FeatureItem(
            color: Colors.blue.shade100,
            title: "مطاعم المدينة",
            route: "route",
            imgPath: "assets/images/restaurant.png",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FeatureItem(
            color: Colors.indigoAccent.shade100,
            title: "كافيهات",
            route: "route",
            imgPath: "assets/images/coffee_shop.png",
          ),
        ),
      ],
    );
  }
}

import 'package:cityinpocket/Controller/favorites_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/Widget/product_item.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});
  final favoritesController = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: ((controller) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReusableStreamBuilder(
              stream: favoritesController.fetchMarketFavoriteItems(),
              builder: (context, snapshot) {
                if (favoritesController.favorites.isEmpty) {
                  return const Center(
                    child: Text("لا يوجد عناصر مفضلة بعد"),
                  );
                } else if (snapshot.hasData) {
                  final List<BuySell> marketItems = snapshot.data!;
                  return ProductItem(marketItems: marketItems);
                } else if (snapshot.hasError) {
                  // print(snapshot.error.toString());
                  return Text('خطأ: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )),
    );
  }
}

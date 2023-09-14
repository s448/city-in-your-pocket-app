import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Controller/buy_sell_controller.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/Widget/product_item.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuySellPage extends StatefulWidget {
  const BuySellPage({Key? key}) : super(key: key);

  @override
  State<BuySellPage> createState() => _BuySellPageState();
}

class _BuySellPageState extends State<BuySellPage> {
  final marketController = Get.put(BuySellController(), permanent: false);
  final _prefs = Get.find<SharedPrefsController>();
  @override
  void dispose() {
    Get.delete<BuySellController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(marketController.product['title']),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
                Get.delete<BuySellController>();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ReusableStreamBuilder(
            stream: marketController.fetchMarketItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<BuySell> marketItems = snapshot.data!;
                return ProductItem(marketItems: marketItems);
              } else if (snapshot.hasError) {
                return Text('خطأ: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            _prefs.userAuthenticated()
                ? Get.toNamed(
                    Routes.addItem,
                    arguments: {
                      "title": marketController.product['title'],
                      "id": marketController.product['id'],
                    },
                  )
                : Get.snackbar("يجب تسجيل حساب اولا", '');
          },
          // tooltip: "أضف $title للبيع ",
          child: const Icon(CupertinoIcons.add),
        ));
  }
}

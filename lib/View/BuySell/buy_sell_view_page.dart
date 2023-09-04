import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/buy_sell_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuySellPage extends StatelessWidget {
  BuySellPage({Key? key}) : super(key: key);
  final marketController = Get.put(BuySellController());
  @override
  Widget build(BuildContext context) {
    print(marketController.product['title']);
    return Scaffold(
        appBar: AppBar(
          title: Text(marketController.product['title']),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ReusableStreamBuilder(
            stream: marketController.fetchMarketItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<BuySell> marketItems = snapshot.data!;
                return ListView.builder(
                  itemCount: marketItems.length,
                  itemBuilder: (context, index) {
                    final item = marketItems[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.productDetails,
                          arguments: {"product": item},
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: StyleManager.listTileStyle,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.7,
                                  // decoration: StyleManager.listTileStyle,
                                  child: ListTile(
                                    isThreeLine: true,
                                    title: Text(
                                      item.title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      item.description!,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.25,
                                  child: Image.network(
                                    item.images![0],
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
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
            Get.toNamed(
              Routes.addItem,
              arguments: {
                "title": marketController.product['title'],
                "id": marketController.product['id'],
              },
            );
          },
          // tooltip: "أضف $title للبيع ",
          child: const Icon(CupertinoIcons.add),
        ));
  }
}

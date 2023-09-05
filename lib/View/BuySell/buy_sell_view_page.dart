import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/buy_sell_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
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
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${item.price} جنيه",
                                          style: StyleManager.priceStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.25,
                                  child: Image.network(
                                    item.images![0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
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

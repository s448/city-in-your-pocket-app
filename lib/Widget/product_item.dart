import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.marketItems,
  });

  final List<BuySell> marketItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marketItems.length,
      itemBuilder: (context, index) {
        final item = marketItems[index];
        String Usagetype = item.household == true ? "مستعمل" : "جديد";
        String dealtype = item.rental == true ? "ايجار" : "بيع نهائي";

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${item.price}  ج.م",
                                  style: StyleManager.priceStyle,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  decoration: StyleManager.accentBoxDecoration,
                                  child: Text(
                                    Usagetype,
                                    style: StyleManager.metaDataText,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  decoration: StyleManager.accentBoxDecoration,
                                  child: Text(
                                    dealtype,
                                    style: StyleManager.metaDataText,
                                  ),
                                ),
                              ],
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
  }
}

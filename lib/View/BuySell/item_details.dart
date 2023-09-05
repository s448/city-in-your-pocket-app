import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/product_details_controller.dart';
import 'package:cityinpocket/Widget/ad_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key}) : super(key: key);

  final productController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("تفاصيل العنصر"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: StyleManager.roundedBoxDecoration,
              height: Get.height * .35,
              padding: const EdgeInsets.all(1.0),
              width: double.infinity,
              child: CarouselSlider(
                images: productController.product.images as List<String>,
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
            ListTile(
              title: Text(productController.product.user!.name.toString()),
              subtitle: Text(productController.product.user!.phone.toString()),
              leading: const Icon(
                CupertinoIcons.person_alt_circle,
                size: 45,
                color: ColorManager.primaryColorLight,
              ),
            ),
            // const Divider(
            //   thickness: 1.2,
            // ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: StyleManager.borderedRoundedBoxDecoration,
              child: ListTile(
                title: Text(
                  "${productController.product.price ?? '0.0'} جنيه",
                  style: StyleManager.priceStyle,
                ),
                subtitle: const Text("السعر"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              productController.product.title.toString(),
              style: StyleManager.title,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "التفاصيل",
              style: StyleManager.headline1,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              productController.product.description.toString(),
              style: StyleManager.bodyText1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.1,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: StyleManager.roundedBoxDecoration,
              child: const Icon(
                Ionicons.heart_outline,
                size: 30,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  //  productController.addToCart();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: StyleManager.shadowBoxDecoration,
                  child: Obx(
                    () => productController.isAddLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'تواصل مع البائع',
                                style: StyleManager.headlineWhite,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Icon(
                                CupertinoIcons.chat_bubble_2_fill,
                                color: Colors.white,
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

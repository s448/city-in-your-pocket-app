import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/favorites_controller.dart';
import 'package:cityinpocket/Controller/product_details_controller.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key}) : super(key: key);
  final favoritesController = Get.find<FavoritesController>();

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
              child: Carousel(
                autoScroll: true,
                height: Get.height * 0.3,
                width: Get.width,
                autoScrollDuration: const Duration(seconds: 4),
                activateIndicatorColor: ColorManager.primaryColor,
                indicatorBarColor: ColorManager.secondaryColor,
                unActivatedIndicatorColor: ColorManager.navBarUnselectedColor,
                isCircle: true,
                items: [
                  for (var image
                      in productController.product.images as List<String>)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: StyleManager.roundedBoxDecoration,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                ],
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 20),
            InkWell(
                onTap: () {
                  UrlLauncherService.launch(
                      'https://api.whatsapp.com/send?phone=+20${productController.product.user?.phone}&text=${Uri.encodeComponent("مرحبا أ/${productController.product.user?.name}, انا مهتم بشراء العنصر ${productController.product.title} المعروض في تطبيق $appName")}');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: StyleManager.roundedBoxDecoration,
                  child: Icon(
                    Ionicons.logo_whatsapp,
                    size: 30,
                    color: Colors.greenAccent.shade700,
                  ),
                )),
            const SizedBox(width: 6),
            Expanded(
              child: InkWell(
                onTap: () {
                  UrlLauncherService.launch(
                      'tel:${productController.product.user?.phone}');
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
                                'أتصل بالبائع',
                                style: StyleManager.headlineWhite,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Icon(
                                CupertinoIcons.phone_arrow_up_right,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: InkWell(
          onTap: () => favoritesController
              .addRemoveFavItem(productController.product.docId),
          child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: StyleManager.roundedBoxDecoration,
              child: Obx(
                () => Icon(
                  favoritesController.favorites
                          .contains(productController.product.docId)
                      ? Ionicons.heart_sharp
                      : Ionicons.heart_outline,
                  size: 30,
                  color: ColorManager.primaryColorDark,
                ),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

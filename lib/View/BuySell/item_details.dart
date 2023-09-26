import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/favorites_controller.dart';
import 'package:cityinpocket/Controller/product_details_controller.dart';
import 'package:cityinpocket/Services/time_management.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key}) : super(key: key);
  final favoritesController = Get.find<FavoritesController>();

  final productController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    String Usagetype =
        productController.product.household == true ? "مستعمل" : "جديد";
    String dealtype =
        productController.product.rental == true ? "ايجار" : "بيع نهائي";
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

            //START BUTTON GROUP
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => favoritesController
                        .addRemoveFavItem(productController.product.docId),
                    child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        // decoration: StyleManager.roundedBoxDecoration,
                        child: Obx(
                          () => Icon(
                            favoritesController.favorites
                                    .contains(productController.product.docId)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            size: 30,
                            color: ColorManager.primaryColorDark,
                          ),
                        )),
                  ),
                  const VerticalDivider(
                    thickness: 1.5,
                  ),
                  IconButton(
                      onPressed: (() => FlutterShare.share(
                            title: appName,
                            text:
                                'مشاركة العنصر: ${productController.product.title} & حمل تطبيق $appName من خلال الرابط $appUrl',
                          )),
                      icon: const Icon(
                        Ionicons.share_social_outline,
                        color: ColorManager.primaryColorDark,
                      ))
                ],
              ),
            ),
            const Divider(),
            //END BUTTON GROUP
            const SizedBox(
              height: 8.0,
            ),
            // Center(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("السعر"),
            //       Text(
            //         "${productController.product.price ?? '0.0'} ج.م",
            //         style: StyleManager.priceStyle,
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "${productController.product.price ?? '0.0'} ج.م",
                    style: StyleManager.priceStyle,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.time,
                      color: Colors.redAccent[400],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Text(
                        TimeManager.formatDateTimeOfMessage(
                            productController.product.date!.toDate()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              productController.product.title.toString(),
              style: StyleManager.title,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: StyleManager.borderedRoundedBoxDecoration,
                  child: Text(
                    Usagetype,
                    style: StyleManager.bodyText1,
                  ),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: StyleManager.borderedRoundedBoxDecoration,
                  child: Text(
                    dealtype,
                    style: StyleManager.bodyText1,
                  ),
                ),
              ],
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
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: productController.isPublisher()
            ? IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('حذف العنصر ؟'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('لا'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'نعم',
                                style: StyleManager.warningTextStyle,
                              ),
                              onPressed: () {
                                productController.deleteItem(
                                    productController.product.docId);
                                Get.offAllNamed(Routes.navbar);
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.red,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 20),
                  InkWell(
                      onTap: () {
                        UrlLauncherService.launch(
                            'https://api.whatsapp.com/send?phone=+2${productController.product.phone}&text=${Uri.encodeComponent("مرحبا أ/${productController.product.user?.name}, انا مهتم بشراء العنصر ${productController.product.title} المعروض في تطبيق $appName")}');
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
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: Colors.white,
      //     child: IconButton(
      //       icon: const Icon(
      //         Icons.delete,
      //         size: 35,
      //         color: Colors.red,
      //       ),
      //       onPressed: () {
      //         productController.deleteItem(productController.product.docId);
      //       },
      //     )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

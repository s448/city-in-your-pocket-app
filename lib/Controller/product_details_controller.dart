import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  BuySell product = Get.arguments['product'];
  var isAddLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}

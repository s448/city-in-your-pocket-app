import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  BuySell product = Get.arguments['product'];
  var isAddLoading = false.obs;
  final CollectionReference buySellRef =
      FirebaseFirestore.instance.collection('buy_and_sell');

  @override
  void dispose() {
    Get.delete<ProductDetailsController>();
    super.dispose();
  }

  var userController = Get.find<UserController>();

  isPublisher() {
    return product.user!.id == userController.userModel.id &&
        product.user!.id != "";
  }

  deleteItem(String? docId) async {
    await buySellRef.doc(docId).delete();
    customSnackbar("تم حذف العنصر", '');
  }
}

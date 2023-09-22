import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class UserController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sharedPrefController = Get.find<SharedPrefsController>();
  late UserModel userModel = UserModel();
  RxBool editButtonIndicator = false.obs;

  final editFormKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    await loadUserData();
    await setInitalData();
    // bindStream(FirebaseAuth.instance.authStateChanges());
  }

  setInitalData() {
    nameController.text = userModel.name!;
    phoneController.text = userModel.phone!;
    emailController.text = userModel.email!;
    update();
  }

  loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> data = await fetchUserData();
    userModel = UserModel.fromJson(data.data() ?? {});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    String userId = _sharedPrefController.getItem('phoneNumber');
    // print(userId);
    var result = await _firestore.collection("users").doc(userId).get();
    // print(result.data().toString());
    return result;
  }

  deleteUserPublications(String id, String? collectionId) async {
    // Delete user documents in the "buy_and_sell" collection
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionId!)
          .where('user.id', isEqualTo: id)
          .get();
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  deleteAccount(String? userPhone) async {
    var user = _auth.currentUser;
    try {
      await deleteUserPublications(userPhone!, 'buy_and_sell');
      await _firestore.collection('users').doc(userPhone).delete();
      _sharedPrefController.clearUserCredentials();
      await user!.delete();
      Get.offAllNamed(Routes.navbar);
      Get.snackbar("تم حذف حسابك نهائيا", "بما في ذلك كل منشوراتك على التطبيق");
    } catch (e) {
      Get.snackbar(
          "لم نستطع حذف حسابك حالبا", "برجاء التحقق من جودة الشبكه لديك",
          backgroundColor: Colors.redAccent.shade100,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  updateProfile(String userId) async {
    try {
      if (editFormKey.currentState!.validate()) {
        editButtonIndicator.value = true;

        await _firestore.collection('users').doc(userId).update({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
        });
      } else {
        return;
      }
      //ارجع للبوفايل
      Get.back();
      //اسحب البوفايل وحط مكانها الرئيسيه
      Get.offAndToNamed(Routes.navbar);
      Get.snackbar("تم التعديل بنجاح", "");
      editButtonIndicator.value = false;
      return true;
    } catch (error) {
      Get.snackbar("لم نستطع تطبيق التغيير المطلوب", "برجاء المحاولة مجددا");
      editButtonIndicator.value = false;
      return false;
    }
  }
}

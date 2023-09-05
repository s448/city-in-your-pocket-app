import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sharedPrefController = Get.find<SharedPrefsController>();
  late UserModel userModel = UserModel();

  @override
  void onInit() async {
    super.onInit();
    await loadUserData();
    // bindStream(FirebaseAuth.instance.authStateChanges());
  }

  loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> data = await fetchUserData();
    userModel = UserModel.fromJson(data.data() ?? {});
    print("user data retreived .......");

    print(userModel.toJson());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    String userId = _sharedPrefController.getPhoneNumber();
    var result = await _firestore.collection("users").doc(userId).get();
    if (kDebugMode) {
      print(result.data().toString());
    }
    return result;
  }

  deleteUserPublications(String id, String? collectionId) async {
    // Delete user documents in the "buy_and_sell" collection
    print("call delete docs");
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionId!)
          .where('user.id', isEqualTo: id)
          .get();
      print(querySnapshot.docs);
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
    } catch (e) {
      print("cannot delete the docs ...$e");
    }
  }

  deleteAccount(String? userPhone) async {
    var user = _auth.currentUser;
    print("user >>>>>>>>>>>>>>>${userPhone}");
    try {
      await deleteUserPublications(userPhone!, 'buy_and_sell');
      await _firestore.collection('users').doc(userPhone).delete();
      _sharedPrefController.clearUserCredentials();
      await user!.delete();
      Get.offAllNamed(Routes.login);
      Get.snackbar("تم حذف حسابك نهائيا", "بما في ذلك كل منشوراتك على التطبيق");
    } catch (e) {
      Get.snackbar(
          "لم نستطع حذف حسابك حالبا", "برجاء التحقق من جودة الشبكه لديك",
          backgroundColor: Colors.redAccent.shade100,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Future<void> updateUserProfile(String displayName) async {
  //   try {
  //     // if (_user.value != null) {
  //     //   await _user.value.updateDisplayName(displayName);
  //     //   _user.refresh(); // Refresh the user object to reflect changes
  //     // }
  //   } catch (e) {
  //     // Handle error
  //     print('Error updating user profile: $e');
  //   }
  // }
  //
  // // Example method to update user data in Firestore
  // Future<void> updateUserData(Map<String, dynamic> data) async {
  //   try {
  //     // if (_user.value != null) {
  //     //   await _firestore.collection('users').doc(_user.value.uid).update(data);
  //     // }
  //   } catch (e) {
  //     // Handle error
  //     print('Error updating user data: $e');
  //   }
  // }
  //
  // // Example method to delete user data from Firestore
  // Future<void> deleteUserData() async {
  //   try {
  //     if (_user.value != null) {
  //       await _firestore.collection('users').doc(_user.value.uid).delete();
  //     }
  //   } catch (e) {
  //     // Handle error
  //     print('Error deleting user data: $e');
  //   }
  // }
}

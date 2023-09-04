import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

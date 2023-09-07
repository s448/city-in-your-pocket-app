import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController extends GetxController {
  final prefs = Get.find<SharedPreferences>();

  Future<void> saveUserCredentials(
      String phoneNumber, String verificationId) async {
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('verificationId', verificationId);
    if (kDebugMode) {
      print(
          "<<..shared prefs..>>credentials $phoneNumber -- $verificationId  was saved successfully");
    }
  }

  String getPhoneNumber() {
    return prefs.getString('phoneNumber') ?? '';
  }

  String getVerificationId() {
    return prefs.getString('verificationId') ?? '';
  }

  Future<void> clearUserCredentials() async {
    await prefs.remove('phoneNumber');
    await prefs.remove('verificationId');
  }

  //if true then user is authorized
  bool userAuthenticated() {
    String phone = getPhoneNumber();
    String verificationId = getVerificationId();

    if (phone == '' || verificationId == '') {
      if (kDebugMode) {
        print(false);
      }
      return false;
    } else {
      if (kDebugMode) {
        print(true);
      }
      return true;
    }
  }
}

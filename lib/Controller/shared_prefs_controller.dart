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

  String getItem(String id) {
    return prefs.getString(id) ?? '';
  }

  Future<void> clearUserCredentials() async {
    await prefs.remove('phoneNumber');
    await prefs.remove('verificationId');
  }

  //if true then user is authorized
  bool userAuthenticated() {
    String phone = getItem('phoneNumber');
    String verificationId = getItem('verificationId');

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

  // void saveNotificationToLocal(String? title, String? body) async {
  //   // Create a list of notifications
  //   List<Map<String, String>> notifications = prefs
  //           .getStringList('notifications')
  //           ?.map((e) => Map<String, String>.from(json.decode(e)))
  //           .toList() ??
  //       [];

  //   // Add the new notification
  //   notifications.add({'title': title!, 'body': body!});

  //   // Save the updated list back to local storage
  //   prefs.setStringList(
  //       'notifications', notifications.map((e) => json.encode(e)).toList());
  //   print(notifications);
  //   print("addedd ......");
  // }

  // Future<List<Map<String, String>>> getSavedNotifications() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   List<String> notificationStrings =
  //       prefs.getStringList('notifications') ?? [];

  //   // Convert stored strings back to a list of maps
  //   List<Map<String, String>> notifications = notificationStrings
  //       .map((e) => Map<String, String>.from(json.decode(e)))
  //       .toList();
  //   print(notifications);

  //   return notifications;
  // }
}

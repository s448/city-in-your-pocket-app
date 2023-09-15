// import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Model/banner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

handleBackgroundMessage(RemoteMessage msg) async {
  // if (kDebugMode) {
  //   print("payload ==> ${msg.data}");
  //   print("Title ==> ${msg.notification?.title}");
  //   print("body ==> ${msg.notification?.body}");
  // }
}

class FcmServices {
  //final _prefs = Get.put(SharedPrefsController());

  final _fcm = FirebaseMessaging.instance;
  static var _token = '';

  getToken() => _token;

  initNotification() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmToken = await _fcm.getToken();
    // if (kDebugMode) {
    //   print(fcmToken);
    // }
    _token = fcmToken ?? 'unknown';
    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //handle the event happens when you click on the notification
      final Map<String, dynamic> data = event.data;
      final BannerAd adDetails = BannerAd(
        contactUrl: data['contact'] ?? '',
        details: data['details'] ?? '',
        imgUrl: data['imgUrl'] ?? '',
      );
      // if (kDebugMode) {
      //   print(data);
      // }
      Get.toNamed(data['route'], arguments: {
        'ad': adDetails,
      });
    });
    // await FirebaseMessaging.instance.subscribeToTopic('buy-sell');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //save the notification to the local storage
      // _prefs.saveNotificationToLocal(
      //     message.notification?.title, message.notification?.body);
      // Handle the notification when the app is in the foreground
      // print(
      //     'Received a notification: ${message.notification?.title} - ${message.notification?.body}');
    });
  }
}

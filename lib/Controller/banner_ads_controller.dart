import 'package:cityinpocket/Model/banner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerAdsController extends GetxController {
  @override
  void onInit() {
    getBannersList();
    super.onInit();
  }

  final CollectionReference _bannerRef =
      FirebaseFirestore.instance.collection('banner');

  RxList<BannerAd> listOfAds = RxList<BannerAd>();

  getBannersList() async {
    await _bannerRef.get().then((value) {
      for (var i in value.docs) {
        listOfAds.add(
          BannerAd(
            details: i['details'],
            imgUrl: i['imgUrl'],
            contactUrl: i['contact'],
            navType: i['nav'],
          ),
        );
      }
    });
  }
}

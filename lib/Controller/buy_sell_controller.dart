import 'dart:io';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BuySellController extends GetxController {
  final CollectionReference buySellRef =
      FirebaseFirestore.instance.collection('buy_and_sell');

  final userController = Get.find<UserController>();
  final addItemKey = GlobalKey<FormState>();

  final product = Get.arguments['element'] ?? "البيع والشراء";

  RxString title = ''.obs;
  RxString description = ''.obs;
  RxList<File> selectedImages = <File>[].obs;
  List<String> imageUrls = [];

  RxBool isUploading = false.obs;
  RxBool uploadButtonEnabled = true.obs;

  Future<void> selectImages() async {
    final List<XFile> images =
        await ImagePicker().pickMultiImage(imageQuality: 80);

    if (images.isNotEmpty) {
      selectedImages.value = images.map((image) => File(image.path)).toList();
    }
  }

  Future<void> createItem() async {
    try {
      print(Get.arguments['id']);
      BuySell model = BuySell(
        title: title.value,
        id: product['id'],
        description: description.value,
        user: userController.userModel,
        images: imageUrls,
      );
      userController.loadUserData();
      await buySellRef.add(model.toJson());
      print("Post created successfully");
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Future<void> submitPost() async {
    if (addItemKey.currentState!.validate()) {
      isUploading.value = true;
      try {
        userController.loadUserData();
        // Upload each image and retrieve the download URL
        for (File imageFile in selectedImages) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref().child(fileName);
          firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
          firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
        await createItem().then((value) {
          isUploading.value = false;
          Get.back();
          // Get.snackbar("تم رفع الاعلان للمراجعة", "سيتم نشرة خلال دقائق");
        });
        print(imageUrls);
      } catch (e) {
        print('Error uploading images: $e');
      }
    } else if (selectedImages.isEmpty || selectedImages.length > 6) {
      Get.snackbar("يشترط أن يكون عدد الصور بين 1 و6", "");
    } else {
      return;
    }
  }

  Stream<List<BuySell>> fetchMarketItems() {
    //   final List<BuySell> market = [
    //     BuySell(
    //         user: userController.userModel,
    //         title: "Title 1",
    //         description: "description description description description 1",
    //         images: [
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //         ],
    //         type: "Electronics"),
    //     BuySell(
    //         user: userController.userModel,
    //         title: "Title 1",
    //         description: "description description description description 1",
    //         images: [
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //         ],
    //         type: "Electronics"),
    //     BuySell(
    //         user: userController.userModel,
    //         title: "Title 1",
    //         description: "description description description description 1",
    //         images: [
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //           "https://m.media-amazon.com/images/I/51UhkQTNxmL.__AC_SX300_SY300_QL70_ML2_.jpg",
    //         ],
    //         type: "Electronics"),
    //   ];
    //   return Stream<List<BuySell>>.fromIterable([market]);

    return buySellRef.snapshots().map((snapshot) {
      print("category >>>>>>" + product['id']);
      return snapshot.docs.where((e) => e['id'] == product['id']).map((doc) {
        Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
        return BuySell.fromJson(data);
      }).toList();
    });
  }
}

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

  var type = Get.arguments['type'];
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxList<File> selectedImages = <File>[].obs;
  List<String> imageUrls = [];

  RxBool isUploading = false.obs;
  RxBool uploadButtonEnabled = true.obs;

  Future<void> selectImages() async {
    final List<XFile> images =
        await ImagePicker().pickMultiImage(imageQuality: 80);

    if (images != null && images.isNotEmpty) {
      selectedImages.value = images.map((image) => File(image.path)).toList();
    }
  }

  Future<void> createItem() async {
    try {
      BuySell model = BuySell(
        type: type,
        title: title.value,
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
    isUploading.value = true;
    if (addItemKey.currentState!.validate()) {
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
          Get.snackbar("تم رفع الاعلان للمراجعة", "سيتم نشرة خلال دقائق");
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
}

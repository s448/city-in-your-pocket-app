import 'dart:io';

import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BuySellController extends GetxController {

  final CollectionReference buySellRef =
  FirebaseFirestore.instance.collection('buy_and_sell');

  final userController = Get.find<UserController>();

  var type = Get.arguments['type'];
  RxString description = ''.obs;
  RxList<File> selectedImages = <File>[].obs;
  List<String> imageUrls = [];


  Future<void> selectImages() async {
    final List<XFile> images =
    await ImagePicker().pickMultiImage(imageQuality: 80);

    if (images != null && images.isNotEmpty) {
      selectedImages.value =
              images.map((image) => File(image.path)).toList();
    }
  }

  Future<void> createItem() async {
    try {
     BuySell model = BuySell(
       type: type,
       description: description.value,
       user: userController.userModel,
       images: imageUrls,
      );
     await buySellRef.add(model.toJson());
     print("Post created successfully");
    } catch (e) {
      print('Error creating user: $e');
    }
  }


  Future<void> submitPost() async {

    try {
      // Upload each image and retrieve the download URL
      for (File imageFile in selectedImages.value) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      await createItem();
      print(imageUrls);

    } catch (e) {
      print('Error uploading images: $e');
    }
  }

}
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessagingController extends GetxController {
  TextEditingController sendMessageController = TextEditingController();
  final CollectionReference messageRef =
      FirebaseFirestore.instance.collection('messages');

  final userController = Get.find<UserController>();
  Timestamp timestamp = Timestamp.now();

  Stream<List<Message>> getMessages() {
    return messageRef
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
        return Message.fromJson(data);
      }).toList();
    });
  }

  sendMessage() async {
    try {
      Message message = Message(
        date: timestamp,
        message: sendMessageController.text.toString(),
        user: userController.userModel,
      );
      userController.loadUserData();
      await messageRef.add(message.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}

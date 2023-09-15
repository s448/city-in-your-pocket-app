import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MessagingController extends GetxController {
  TextEditingController sendMessageController = TextEditingController();
  final CollectionReference messageRef =
      FirebaseFirestore.instance.collection('messages');
  var uuid = const Uuid();

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
    var docId = uuid.v1();

    try {
      Message message = Message(
        date: timestamp,
        message: sendMessageController.text.toString(),
        user: userController.userModel,
        id: docId,
      );
      userController.loadUserData();
      await messageRef.doc(docId).set(message.toJson());
    } catch (e) {
      // print(e.toString());
    }
  }

  deleteMessage(String? docId) async {
    await messageRef.doc(docId).delete();
  }
}

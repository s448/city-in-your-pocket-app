import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Widget/login_sign.dart';
import 'package:cityinpocket/Widget/message_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Controller/messaging_controller.dart';
import 'package:cityinpocket/Model/message.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagingPage extends StatelessWidget {
  MessagingPage({Key? key}) : super(key: key);
  final controller = Get.put(MessagingController());
  final _prefs = Get.find<SharedPrefsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ReusableStreamBuilder(
          stream: controller.getMessages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Message> messages = snapshot.data!;
              return ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  bool isSender = message.user!.id ==
                      controller.userController.userModel.id;
                  return InkWell(
                    onLongPress: () => isSender
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('حذف الرسالة ؟'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('لا'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'نعم',
                                      style: StyleManager.warningTextStyle,
                                    ),
                                    onPressed: () {
                                      controller.deleteMessage(message.id);
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: MessageBubble(
                        isSender: isSender,
                        message: message.message!,
                        timeStamp: message.date!,
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('خطأ: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: _prefs.userAuthenticated()
            ? TextField(
                controller: controller.sendMessageController,
                onSubmitted: (value) {
                  controller.sendMessage();
                  controller.sendMessageController.clear();
                },
                cursorColor: ColorManager.primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  enabled: true,
                  hintText: 'أكتب رسالة..',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send,
                        color: ColorManager.primaryColor),
                    onPressed: () {
                      if (controller.sendMessageController.text.isNotEmpty) {
                        controller.sendMessage();
                        controller.sendMessageController.clear();
                      } else {
                        Fluttertoast.showToast(
                          msg: "لا يمكن ارسال رسالة فارغة",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 1,
                        );
                      }
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

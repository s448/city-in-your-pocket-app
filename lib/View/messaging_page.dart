import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/messaging_controller.dart';
import 'package:cityinpocket/Model/message.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessagingPage extends StatelessWidget {
  MessagingPage({Key? key}) : super(key: key);
  final controller = Get.put(MessagingController());
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
              print(messages.length);
              return ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  bool isSender = message.user!.id ==
                      controller.userController.userModel.id;
                  String formattedTime =
                      DateFormat.jm().format(message.date!.toDate());
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BubbleSpecialThree(
                        text: message.message.toString(),
                        tail: false,
                        isSender: isSender,
                        color: isSender
                            ? ColorManager.primaryColorDark
                            : ColorManager.navBarUnselectedColor,
                        textStyle: StyleManager.bodyWhiteText,
                        // delivered: true,
                        sent: isSender,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Text(formattedTime),
                      ),
                      const SizedBox(
                        height: 6.0,
                      )
                    ],
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
        child: TextField(
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
              icon: const Icon(Icons.send, color: ColorManager.primaryColor),
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
        ),
      ),
      // bottomNavigationBar: MessageBar(
      //   onSend: (_) {
      //     if (controller.sendMessageController.text.isNotEmpty) {
      //       controller.sendMessage();
      //       controller.sendMessageController.clear();
      //     }
      //   },
      //   messageBarHitText: 'أكتب رسالة..',
      //   // actions: [
      //   //   InkWell(
      //   //     child: Icon(
      //   //       Icons.add,
      //   //       color: Colors.black,
      //   //       size: 24,
      //   //     ),
      //   //     onTap: () {},
      //   //   ),
      //   //   Padding(
      //   //     padding: EdgeInsets.only(left: 8, right: 8),
      //   //     child: InkWell(
      //   //       child: Icon(
      //   //         Icons.camera_alt,
      //   //         color: Colors.green,
      //   //         size: 24,
      //   //       ),
      //   //       onTap: () {},
      //   //     ),
      //   //   ),
      //   // ],
      // ),
    );
  }
}

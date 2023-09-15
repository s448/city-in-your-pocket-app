import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Services/time_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  MessageBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.timeStamp,
    required this.senderName,
    required this.senderPhone,
  });
  final bool isSender;
  final String message;
  final Timestamp timeStamp;
  final String? senderName;
  final String? senderPhone;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: Get.width * 0.2,
                    minHeight: Get.height * 0.1,
                    maxWidth: Get.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isSender
                        ? ColorManager.primaryColor
                        : const Color.fromARGB(255, 61, 60, 60),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$senderName ~$senderPhone",
                          style: StyleManager.bodyWhiteText,
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          TimeManager.formatDateTimeOfMessage(
                              timeStamp.toDate()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

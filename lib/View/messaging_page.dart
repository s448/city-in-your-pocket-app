import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text(
            "لا يوجد مراسلات",
            style: StyleManager.headline1,
          ),
        ),
      ],
    );
  }
}

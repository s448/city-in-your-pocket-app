import 'package:flutter/material.dart';
import 'package:cityinpocket/Constant/style.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: StyleManager.gradientBoxDecoration,
        child: Center(
          child: Text("الريسية",style: StyleManager.headline1,),
        ),
      ),
    );
  }
}

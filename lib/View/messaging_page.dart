import 'package:cityinpocket/Constant/style.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
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
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ElevatedButton(onPressed: () {
        //
        //   },
        //   style: StyleManager.primaryButtonStyle, child: const Text("Click"),),
        // )
      ],
    );
  }
}

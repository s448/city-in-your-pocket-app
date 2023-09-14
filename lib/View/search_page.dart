import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/search_controller.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final searchController = Get.put(FirestoreSearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: StyleManager.headlineWhite,
          decoration: const InputDecoration(
            hintText: "بحث ...",
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          cursorColor: Colors.white,
          onChanged: (value) async {
            searchController.searchQuery.value = value;
            await searchController.searchFirestore('buy_and_sell');
          },
          onSubmitted: (value) async {
            await searchController.searchFirestore('buy_and_sell');
          },
          onTap: () => Get.toNamed(Routes.search),
        ),
        // title: TextField(
        //   onChanged: (value) {
        //     searchController.searchQuery.value = value;
        //   },
        //   onSubmitted: (value) async {
        //     await searchController.searchFirestore('buy_and_sell');
        //   },
        //   decoration: const InputDecoration(
        //     hintText: ,
        //   ),
        // ),
      ),
      body: Obx(
        () {
          if (searchController.searchResults.value.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final results = searchController.searchResults.value;
          if (results.isEmpty) {
            return const Center(
              child: Text('لا يود نتائج مطابقة'),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final document = results[index];
              // Render your search results here
              return ListTile(
                title: Text(document['title']),
                subtitle: Text(document['description']),
              );
            },
          );
        },
      ),
    );
  }
}

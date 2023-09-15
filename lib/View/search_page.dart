import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/search_controller.dart';
import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cityinpocket/routes.dart';
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
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "بحث . .",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          cursorColor: Colors.white,
          onChanged: (value) async {
            searchController.searchQuery.value = value;
            await searchController.searchDocuments(null);
          },
          onSubmitted: (value) async {
            await searchController.searchDocuments(null);
          },
          onTap: () => Get.toNamed(Routes.search),
        ),
      ),
      body: Obx(
        () {
          // ignore: invalid_use_of_protected_member
          if (searchController.filteredData.value.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (searchController.searchQuery.value.isEmpty) {
            return const SizedBox();
          } else {
            return Obx(() {
              if (searchController.filteredData.isEmpty) {
                return const SizedBox();
              }
              return ListView.builder(
                itemCount: searchController.filteredData.length,
                itemBuilder: (context, index) {
                  final BuySell item = searchController.filteredData[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.productDetails,
                        arguments: {"product": item},
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(item.title!),
                          subtitle: Text(
                            item.description!,
                            maxLines: 4,
                          ),
                        ),
                        const Divider(
                          thickness: 1.7,
                        )
                      ],
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}

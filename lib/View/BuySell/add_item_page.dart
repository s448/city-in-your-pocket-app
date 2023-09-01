import 'package:cityinpocket/Controller/buy_sell_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddItem extends StatelessWidget {
  final controller = Get.put(BuySellController());

  AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DropdownButtonFormField<String>(
            //   value: controller.type.value,
            //   decoration: InputDecoration(labelText: 'Type'),
            //   onChanged: (value) {
            //     controller.type.value = value!;
            //   },
            //   items: ['Type 1', 'Type 2', 'Type 3']
            //       .map(
            //         (type) => DropdownMenuItem<String>(
            //       value: type,
            //       child: Text(type),
            //     ),
            //   )
            //       .toList(),
            // ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                controller.description.value = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: controller.selectImages,
              child: Text('Select Images'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Image.file(controller.selectedImages[index]);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: controller.submitPost,
              child: Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }
}
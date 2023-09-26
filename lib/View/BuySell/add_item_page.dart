import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/buy_sell_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddItem extends StatelessWidget {
  final controller = Get.find<BuySellController>();

  AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة عنصر مجانا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const SizedBox(height: 16.0),
              Container(
                decoration: StyleManager.shadowBoxDecoration,
                child: ListTile(
                  trailing: Text(
                    Get.arguments['title'],
                    style: StyleManager.headlineWhite,
                  ),
                  title: const Text(
                    "نوع العنصر",
                    style: StyleManager.bodyWhiteText,
                  ),
                ),
              ),
              const SizedBox(height: 22.0),
              Form(
                key: controller.addItemKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 80,
                      decoration: InputDecoration(
                        labelText: 'اسم العنصر',
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        controller.title.value = value;
                        // print(controller.title.value);
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'السعر',
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        controller.price.value = value;
                        //    print(controller.price.value);
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      autofocus: true,
                      minLines: 4,
                      maxLines: 10,
                      maxLength: 800,
                      decoration: InputDecoration(
                        labelText: 'الوصف والتفاصيل',
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        controller.description.value = value;
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    ///////
                    const SizedBox(
                      height: 7.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      autofocus: true,
                      maxLines: 1,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'رقم التليفون للتواصل',
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        controller.phone.value = value;
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),
              Divider(
                thickness: 1,
              ),
              Text(
                "حدد جديد أو مستعمل *",
                style: StyleManager.title,
              ),
              ToggleSwitch(
                animate: true,
                initialLabelIndex: null,
                totalSwitches: 2,
                isVertical: true,
                dividerMargin: 0,
                dividerColor: Colors.white,
                labels: ["جديد", "مستعمل"],
                onToggle: (index) {
                  index == 0
                      ? controller.isHousehold.value = false
                      : controller.isHousehold.value = true;
                  print('switched to: $index');
                },
              ),

              const SizedBox(height: 10.0),
              Divider(
                thickness: 1,
              ),
              Text(
                "حدد بيع أو ايجار *",
                style: StyleManager.title,
              ),
              ToggleSwitch(
                animate: true,
                initialLabelIndex: null,
                totalSwitches: 2,
                isVertical: true,
                dividerMargin: 0,
                dividerColor: Colors.white,
                labels: ["بيع نهائي", "تأجير"],
                onToggle: (index) {
                  index == 0
                      ? controller.isRental.value = true
                      : controller.isHousehold.value = false;
                  print('switched to: $index');
                },
              ),
              const SizedBox(height: 16.0),
              TextButton.icon(
                onPressed: controller.selectImages,
                style: StyleManager.primaryButtonStyle,
                icon: const Icon(
                  CupertinoIcons.photo,
                  color: Colors.white,
                ),
                label: Obx(() {
                  return Text(
                    controller.selectedImages.isEmpty
                        ? 'أضف صور للعنصر'
                        : 'اعادة تعيين الصور',
                    style: StyleManager.bodyWhiteText,
                  );
                }),
              ),
              const Center(
                child: Text(
                  "اضغط ضغط مطول علي الصور لاختيار أكثر من صورة",
                ),
              ),
              Obx(
                () => SizedBox(
                  height: controller.selectedImages.isNotEmpty
                      ? Get.height * 0.2
                      : 0, // Set a fixed height for the GridView
                  child: ListView.builder(
                    scrollDirection: Axis
                        .horizontal, // Set the scroll direction to horizontal
                    itemCount: controller.selectedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width *
                            0.3, // Set the width of each item in the horizontal scroll
                        margin: const EdgeInsets.only(
                            right: 20.0), // Add spacing between items
                        child: Image.file(
                          controller.selectedImages[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.selectedImages.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
                child: ElevatedButton(
                  onPressed: controller.isUploading.value
                      ? null
                      : controller.submitPost,
                  style: StyleManager.primaryButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !controller.isUploading.value
                        ? const Text('نشر الاعلان')
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}

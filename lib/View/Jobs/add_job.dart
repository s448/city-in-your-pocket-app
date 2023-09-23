import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJob extends StatelessWidget {
  final controller = Get.find<JobsController>();

  AddJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة أعلان توظيف مجانا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 22.0),
              Form(
                key: controller.addJobKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 40,
                      decoration: InputDecoration(
                        labelText: 'وصف مختصر للوظيفة',
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'الراتب',
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
                        controller.salary.value = value;
                        // print(controller.salary.value);
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'أسم الشركة',
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
                        controller.company.value = value;
                        // print(controller.company.value);
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
                        labelText: 'تفاصيل الوظيفة',
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

                    ///
                    const SizedBox(
                      height: 7.0,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'البريد الالكتروني للتواصل',
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
                        controller.email.value = value;
                        // print(controller.salary.value);
                      },
                      validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Obx(
                () => ElevatedButton(
                  onPressed: () => controller.isUploading.value
                      ? null
                      : controller.createJobItem(),
                  style: StyleManager.primaryButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !controller.isUploading.value
                        ? const Text('نشر أعلان التوظيف')
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

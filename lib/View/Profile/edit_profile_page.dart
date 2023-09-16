import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final userController = Get.find<UserController>();
  final _sharedPrefController = Get.find<SharedPrefsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديث بياناتك'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: userController.editFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: userController.nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
              ),
              TextFormField(
                controller: userController.phoneController,
                decoration:
                    const InputDecoration(labelText: 'رقم الهاتف المحمول'),
                validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: userController.emailController,
                decoration:
                    const InputDecoration(labelText: 'البريد الالكتروني'),
                validator: (val) => (val!.isEmpty) ? "حقل فارغ" : null,
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    final userId = _sharedPrefController.getItem('phoneNumber');
                    print(userId);

                    await userController.updateProfile(userId);
                  },
                  style: StyleManager.primaryButtonStyle,
                  child: userController.editButtonIndicator.value
                      ? const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("تحديث"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

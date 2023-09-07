import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userController.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("خطأ"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorManager.primaryColorDark,
          ));
        } else if (snapshot.hasData) {
          var data = snapshot.data!.data();
          UserModel user = UserModel(
            id: data!['id'],
            name: data['name'],
            email: data['email'],
            imgUrl: data['imgUrl'],
            phone: data['phone'],
          );
          if (kDebugMode) {
            print("${user.name}>>>>>>>>>>>");
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: StyleManager.gradientBoxDecoration,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "المعلومات الشخصية",
                            style: StyleManager.headlineWhite,
                          ),
                          ListTile(
                            dense: false,
                            titleTextStyle: StyleManager.headlineWhite,
                            trailing: const Icon(
                              CupertinoIcons.person,
                              color: Colors.white,
                            ),
                            title: Text(user.name.toString()),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 2.0,
                          ),
                          ListTile(
                            dense: false,
                            titleTextStyle: StyleManager.headlineWhite,
                            title: Text(user.phone.toString()),
                            subtitle: const Text(
                              "رقم الهاتف المحمول",
                              style: StyleManager.bodyWhiteText,
                            ),
                            trailing: const Icon(
                              CupertinoIcons.device_phone_portrait,
                              color: Colors.white,
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 2.0,
                          ),
                          ListTile(
                            dense: false,
                            titleTextStyle: StyleManager.headlineWhite,
                            title: Text(user.email.toString()),
                            subtitle: const Text(
                              "البريد الالكتروني",
                              style: StyleManager.bodyWhiteText,
                            ),
                            trailing: const Icon(
                              CupertinoIcons.mail,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   decoration: StyleManager.gradientBoxDecoration,
                  //   child: const ListTile(
                  //     dense: false,
                  //     titleTextStyle: StyleManager.headlineWhite,
                  //     title: Text("تعديل الحساب"),
                  //     trailing: Icon(
                  //       Icons.edit,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // <-- SEE HERE
                            title: const Text('حذف الحساب'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'سيتم حذف حسابك نهائيا وحذف كل مل قمت بنشره, هل تريد المتابعة ؟'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('لا'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'نعم',
                                  style: StyleManager.warningTextStyle,
                                ),
                                onPressed: () {
                                  userController.deleteAccount(user.phone);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: StyleManager.dangerRoundedDecoration,
                      child: const ListTile(
                        dense: false,
                        titleTextStyle: StyleManager.headlineWhite,
                        title: Text("حذف الحساب"),
                        trailing: Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorManager.primaryColorDark,
          ));
        }
      },
    );
  }
}

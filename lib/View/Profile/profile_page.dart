import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Model/user.dart';
import 'package:cityinpocket/Widget/login_sign.dart';
import 'package:cityinpocket/Widget/profile_button.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../Controller/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: userController.fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const LoginSign();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.primaryColorDark,
                  ));
                } else if (snapshot.hasData) {
                  var data = snapshot.data!.data();
                  print(data);
                  UserModel user = UserModel(
                    id: data!['id'] == '' ? "غير معروف" : data['id'],
                    name: data['name'],
                    email: data['email'],
                    imgUrl: data['imgUrl'],
                    phone: data['phone'] == '' ? "غير معروف" : data['phone'],
                  );
                  if (kDebugMode) {
                    print("${user.id}>>>>>>>>>>>");
                  }
                  return Column(
                    children: [
                      //user information
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
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.editProfile),
                        child: Container(
                          decoration: StyleManager.senderBoxDecoration,
                          child: const ListTile(
                            dense: false,
                            titleTextStyle: StyleManager.headlineWhite,
                            title: Text("تعديل الملف لشخصي"),
                            trailing: Icon(
                              CupertinoIcons.pencil_circle_fill,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.primaryColorDark,
                  ));
                }
              },
            ),

            //-------------part 2 for un authorized ---------------

            const SizedBox(
              height: 30,
            ),
            ProfileButton(
              isShare: true,
              title: "صفحتنا علي الفيسبوك",
              icon: const Icon(
                Ionicons.logo_facebook,
                color: ColorManager.primaryColor,
              ),
              url: fbPageUrl,
            ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            ProfileButton(
              isShare: false,
              title: "تواصل معنا",
              icon: Icon(
                Ionicons.logo_whatsapp,
                color: Colors.green,
              ),
              url:
                  'https://api.whatsapp.com/send?phone=+201557912724&text=${Uri.encodeComponent("السلام عليكم")}',
            ),
            ProfileButton(
              isShare: false,
              title: "تقييم التطبيق",
              icon: Icon(
                CupertinoIcons.star_lefthalf_fill,
                color: Colors.yellow.shade700,
              ),
              url:
                  'https://play.google.com/store/apps/details?id=com.cnp.saidmodev&pcampaignid=web_share',
            ),
            ProfileButton(
              isShare: true,
              title: "شارك التطبيق",
              icon: const Icon(
                Icons.share,
                color: ColorManager.primaryColor,
              ),
              url:
                  'https://play.google.com/store/apps/details?id=com.cnp.saidmodev&pcampaignid=web_share',
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

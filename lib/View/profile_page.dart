import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userController.fetchUserData(),
      builder: (context, snapshot){

        if(snapshot.hasError){
          return const Text("Cannot retrieve user data");
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child:  CircularProgressIndicator(color: ColorManager.primaryColorDark,));
        }else if(snapshot.hasData){
          var data = snapshot.data!.data();
          UserModel user = UserModel(
            id: data!['uid'],
            name: data['username'],
            email: data['email'],
            imgUrl: data['imgUrl'],
            phone: data['phoneNumber'],
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
                    decoration: StyleManager.gradientBoxDecoration,
                    child: ListTile(
                      dense: false,
                      titleTextStyle: StyleManager.headlineWhite,
                      leading: Image.network(user.imgUrl ?? "https://img.icons8.com/fluency/48/user-male-circle--v1.png"),
                      title: Text(user.name.toString()),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    decoration: StyleManager.gradientBoxDecoration,
                    child: ListTile(
                      dense: false,
                      titleTextStyle: StyleManager.headlineWhite,
                      title: Text(user.phone.toString()),
                      subtitle: const Text("رقم الهاتف المحمول",style: StyleManager.bodyWhiteText,),
                      trailing: const Icon(Icons.phone_android_outlined,color: Colors.white,),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    decoration: StyleManager.gradientBoxDecoration,
                    child: ListTile(
                      dense: false,
                      titleTextStyle: StyleManager.headlineWhite,
                      title: Text(user.email.toString()),
                      subtitle: const Text("البريد الالكتروني",style: StyleManager.bodyWhiteText,),
                      trailing: const Icon(Icons.email,color: Colors.white,),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    decoration: StyleManager.gradientBoxDecoration,
                    child:const ListTile(
                      dense: false,
                      titleTextStyle: StyleManager.headlineWhite,
                      title: Text("تعديل الحساب"),
                      trailing: Icon(Icons.edit,color: Colors.white,),
                    ),
                  ),
                  // const SizedBox(height: 35,),
                  // Container(
                  //   child: ListTile(
                  //     dense: false,
                  //     titleTextStyle: StyleManager.bodyText1,
                  //     title: Text(user.name.toString()),
                  //     trailing: const Icon(Icons.logout,color: Colors.red,),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }else{
          return const Center(child:  CircularProgressIndicator(color: ColorManager.primaryColorDark,));
        }
      },
    );
  }
}

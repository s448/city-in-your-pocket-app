import 'dart:async';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Model/user.dart';
import 'package:cityinpocket/Services/fcm_services.dart';
import 'package:cityinpocket/Widget/nav_bar.dart';
import 'package:cityinpocket/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final _sharedPrefController = Get.put(SharedPrefsController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  logout() async {
    await _auth.signOut();
    _sharedPrefController.clearUserCredentials();
    Get.offAllNamed(Routes.navbar);
    Get.snackbar("تم تسجيل الخروج", '');
  }

  Future<bool> saveUserData() async {
    try {
      UserModel user = UserModel(
        id: phoneNo.value,
        name: username.value,
        email: email.value,
        imgUrl: "",
        phone: phoneNo.value,
        token: FcmServices().getToken(),
      );

      await _firestore
          .collection('users')
          .doc(phoneNo.value)
          .set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userExist(String documentId) async {
    if (kDebugMode) {
      print("call user exist methode >>>>>>>>>>");
    }
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        print('Document does not exist');
        return false;
      }
    } catch (e) {
      // Error occurred while searching for the document
      print('Error searching document: $e');
      return false;
    }
  }

  //Sign in with phone number
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;
  var timer;
  final loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  //sign up controllers
  var username = "".obs;
  var email = "".obs;
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AuthController();

  getOtp(bool login) async {
    isLoading.value = true;
    bool exist = await userExist(phoneNo.value);
    print(exist);

    if (exist == false && login == true) {
      // print("phone number does not exist");
      Get.snackbar(
          "الرقم ${phoneNo.value}غير مسجل لدينا", "قم بتسجيل حساب أولا");
      isLoading.value = false;
    } else if (exist == true && login == false) {
      Get.snackbar(
          "الرقم ${phoneNo.value} مسجل بالفعل", "قم بتسجيل الدخول بدلا من ذلك");
      isLoading.value = false;
    } else {
      //continue auth process
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2${phoneNo.value}',
        verificationCompleted: (PhoneAuthCredential credential) {
          saveUserData();
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            "الرسائل غير متاحة حاليا",
            "جرب تسجيل الدخول باستخدام جوجل",
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          firebaseVerificationId = verificationId;
          isOtpSent.value = true;
          statusMessage.value = "تم الارسال الى ${phoneNo.value}";
          startResendOtpTimer();
          isLoading.value = false;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      isLoading.value = false;
    }
  }

  resendOtp() async {
    resendOTP.value = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2${phoneNo.value}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "اعادة الارسال الى ${phoneNo.value}";
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      statusMessage.value = "يتم التحقق.. ${otp.value}";
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId, smsCode: otp.value);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      //save user credentials to local storage
      await _sharedPrefController.saveUserCredentials(
          phoneNo.value, firebaseVerificationId);
      if (!await userExist(phoneNo.value)) {
        saveUserData();
      }
      Get.off(const SnakeNavigationBarExampleScreen());
    } catch (e) {
      statusMessage.value = "رقم OTP غير صحيح";
      statusMessageColor = Colors.red.obs;
    }
  }

  startResendOtpTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 30;
        resendOTP.value = true;
        timer.cancel();
      }
      update();
    });
  }

  //google auth
  RxBool isGoogleLoading = false.obs;
  loginWithGoogle() async {
    isGoogleLoading.value = true;
    bool authSucceess = false;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuth =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      print(">>>>>202 ${user?.displayName}");
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          print(">>>>>>205 >>>>>new user");
          try {
            UserModel userModel = UserModel(
              id: user.phoneNumber ?? '',
              name: user.displayName,
              email: user.email,
              imgUrl: "",
              phone: user.phoneNumber ?? '',
              token: FcmServices().getToken(),
            );
            await _firestore
                .collection('users')
                .doc(user.phoneNumber ?? user.email)
                .set(userModel.toJson());
            print(">>>>>>user is set to the fiorestore");
            print("user credentails : phone>>>${user.metadata}");
            if (await userExist(user.phoneNumber ?? user.email!)) {
              authSucceess = true;
            }
            isGoogleLoading.value = false;
          } catch (e) {
            print("?????????can't save the user data");
            isGoogleLoading.value = false;
            Get.snackbar(
              "خطأ",
              "لا يمكن تسجيل الدخول برجاء المحاولة لاحقا",
            );
          }
        } else {
          isGoogleLoading.value = false;
          authSucceess = true;
          print("user is already registerd >>>> login");
        }
        await _sharedPrefController.saveUserCredentials(
            user.phoneNumber ?? user.email!,
            userCredential.additionalUserInfo!.authorizationCode ?? 'unknown');
        print(">>>>>>user is set to shared prefs");
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "خطأ",
        "لا يمكن تسجيل الدخول برجاء المحاولة لاحقا",
      );
      isGoogleLoading.value = false;
      authSucceess = false;
    }
    if (authSucceess) {
      print("auth success >>>>>>>>>>>>>>>>");
      Get.offAndToNamed(Routes.navbar);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.offAllNamed(Routes.navbar);
  }
}

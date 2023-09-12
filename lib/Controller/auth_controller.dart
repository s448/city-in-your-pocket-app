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
    Get.offAllNamed(Routes.login);
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

  //sign up controllers
  var username = "".obs;
  var email = "".obs;
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AuthController();

  getOtp(bool login) async {
    bool exist = await userExist(phoneNo.value);
    print(exist);
    if (exist == false && login == true) {
      print("phone number does not exist");
      Get.snackbar(
          "الرقم ${phoneNo.value}غير مسجل لدينا", "قم بتسجيل حساب أولا");
    } else {
      //continue auth process
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2${phoneNo.value}',
        verificationCompleted: (PhoneAuthCredential credential) {
          saveUserData();
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          firebaseVerificationId = verificationId;
          isOtpSent.value = true;
          statusMessage.value = "OTP sent to +2${phoneNo.value}";
          startResendOtpTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
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
        statusMessage.value = "OTP re-sent to +2${phoneNo.value}";
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
      statusMessage.value = "Invalid  OTP";
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
}

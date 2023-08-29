import 'dart:async';

import 'package:cityinpocket/View/home_page.dart';
import 'package:cityinpocket/Widget/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  loginWithGoogle() async {
    //bool res = false;
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

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //add user to firestore
          _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
            'phoneNumber': user.phoneNumber,
          });
        }
      }
      return true;
    } catch (e) {
      Get.snackbar("Error", "cannot login");
      return false;
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }

  Future<bool> saveUserData() async {
    try {
      await _firestore.collection('users').doc(phoneNo.value).set({
        'username': username.value,
        'uid': phoneNo.value,
        'phoneNumber': phoneNo.value,
        'email': email.value,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userExist(String documentId) async {
    print("call user exist methode >>>>>>>>>>");
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
      statusMessage.value = "Verifying... ${otp.value}";
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId, smsCode: otp.value);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
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

// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../View/home_page.dart';
//
// class AuthController extends GetxController{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<bool> signInWithGoogle() async {
//
//   }
// }
// //     with GetSingleTickerProviderStateMixin {
//   var showPrefix = false.obs;
//   var isLogin = true;
//   var phoneNo = "".obs;
//   var otp = "".obs;
//   var isOtpSent = false.obs;
//   var resendAfter = 30.obs;
//   var resendOTP = false.obs;
//   var firebaseVerificationId = "";
//   var statusMessage = "".obs;
//   var statusMessageColor = Colors.black.obs;

//   var timer;

//   AuthController();

//   getOtp() async {
//     FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+2${phoneNo.value}',
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int? resendToken) {
//         firebaseVerificationId = verificationId;
//         isOtpSent.value = true;
//         statusMessage.value = "OTP sent to +2${phoneNo.value}";
//         startResendOtpTimer();
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   resendOtp() async {
//     resendOTP.value = false;
//     FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+2${phoneNo.value}',
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int? resendToken) {
//         firebaseVerificationId = verificationId;
//         isOtpSent.value = true;
//         statusMessage.value = "OTP re-sent to +2${phoneNo.value}";
//         startResendOtpTimer();
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   verifyOTP() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     try {
//       statusMessage.value = "Verifying... ${otp.value}";
//       // Create a PhoneAuthCredential with the code
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: firebaseVerificationId, smsCode: otp.value);
//       // Sign the user in (or link) with the credential
//       await auth.signInWithCredential(credential);
//       Get.off('/home');
//     } catch (e) {
//       statusMessage.value = "Invalid  OTP";
//       statusMessageColor = Colors.red.obs;
//     }
//   }

//   startResendOtpTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (resendAfter.value != 0) {
//         resendAfter.value--;
//       } else {
//         resendAfter.value = 30;
//         resendOTP.value = true;
//         timer.cancel();
//       }
//       update();
//     });
//   }

// // // }

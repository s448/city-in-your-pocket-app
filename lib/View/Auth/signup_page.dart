import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/colors.dart';
import '../../routes.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "تسجيل حساب جديد",
          style: StyleManager.headlineWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Obx(() => authController.isOtpSent.value
                  ? _buildVerifyOtpForm()
                  : _signUpForm())
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: authController.signupFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("أدخل بياناتك", style: StyleManager.headline1),
          const SizedBox(
            height: 6.0,
          ),
          TextFormField(
            controller: authController.nameController,
            decoration: InputDecoration(
              labelText: "الاسم",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (val) {
              authController.username.value = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'من فضلك أدخل الاسم';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: authController.emailController,
            decoration: InputDecoration(
              labelText: "عنوان البريد الالكتروني",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (val) {
              authController.email.value = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'من فضلك أدخل عنوان البريد الألكتروني';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 11,
            onChanged: (val) {
              authController.phoneNo.value = val;
              authController.showPrefix.value = val.isNotEmpty;
            },
            onSaved: (val) => authController.phoneNo.value = val!,
            validator: (val) =>
                (val!.isEmpty || val.length < 11) ? "أدخل رقم صحيح" : null,
            decoration: InputDecoration(
              labelText: "رقم المحمول",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
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
              prefix: authController.showPrefix.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '(+2)',
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (authController.signupFormKey.currentState!.validate()) {
                print("username >>>>>>>>" + authController.username.value);
                print("email >>>>>>>>" + authController.email.value);
                print("phone ??????" + authController.phoneNo.value);
                authController.getOtp(false);
              }
            },
            style: StyleManager.primaryButtonStyle,
            child: const Text('تسجيل'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("لديك حياب"),
              TextButton(
                  onPressed: (() {
                    Get.offAllNamed(Routes.login);
                  }),
                  child: const Text("تسجيل الدخول"))
            ],
          ),
        ],
      ),
    );
  }

  ////////
  Widget _buildVerifyOtpForm() {
    List<TextEditingController> otpFieldsControler = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('التحقق', style: StyleManager.headline1),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "أدخل الرقم المرسل اليك",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(
                          first: true,
                          last: false,
                          controller: otpFieldsControler[0]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[1]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[2]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[3]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[4]),
                      _textFieldOTP(
                          first: false,
                          last: true,
                          controller: otpFieldsControler[5]),
                    ],
                  ),
                  Text(
                    authController.statusMessage.value,
                    style: TextStyle(
                        color: authController.statusMessageColor.value,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        authController.otp.value = "";
                        for (var controller in otpFieldsControler) {
                          authController.otp.value += controller.text;
                        }
                        authController.verifyOTP();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        // backgroundColor:
                        //     MaterialStateProperty.all<Color>(kPrimaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'التحقق',
                          style: StyleManager.headlineWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "لم تتلقى أي رسالة؟",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 18,
            ),
            Obx(
              () => TextButton(
                onPressed: () => authController.resendOTP.value
                    ? authController.resendOtp()
                    : null,
                child: Text(
                  authController.resendOTP.value
                      ? "أرسل الكود مجددا"
                      : "انتظر ${authController.resendAfter} ثانية",
                  style: StyleManager.bodyWithPrimaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool first = true, last, controller}) {
    var height = (Get.width - 82) / 6;
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: true,
          controller: controller,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              Get.focusScope?.nextFocus();
            }
            if (value.isEmpty && first == false) {
              Get.focusScope?.previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: height / 2, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: ColorManager.primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

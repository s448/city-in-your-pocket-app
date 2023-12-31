import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/auth_controller.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthIconType;
import 'dart:math' as math;

class LoginPage extends StatelessWidget {
  final authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "تسجيل الدخول",
          style: StyleManager.headlineWhite,
        ),
      ),
      body: Stack(
        children: [
          Obx(() => authController.isOtpSent.value
              ? _buildVerifyOtpForm()
              : _buildGetOtpForm())
        ],
      ),
    );
  }

  // Widget Login() {
  //   return Container(
  //     child: ElevatedButton(
  //       onPressed: (() {}),
  //       style: StyleManager.primaryButtonStyle,
  //       child: const Text("Sign in with google"),
  //     ),
  //   );
  // }

  Widget _buildGetOtpForm() {
    return SafeArea(
      child: Form(
        key: authController.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(math.pi / 4),
                  child: Container(
                    width: Get.width * 0.3,
                    height: Get.width * 0.3,
                    decoration: StyleManager.gradientBoxDecoration,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(
                          -math.pi / 4), // Apply the inverse rotation
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/cnp-logo-removebg.png',
                          width: Get.width * 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  appName,
                  style: StyleManager.headlineWithPrimaryColor,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        onChanged: (val) {
                          authController.phoneNo.value = val;
                          authController.showPrefix.value = val.isNotEmpty;
                        },
                        onSaved: (val) => authController.phoneNo.value = val!,
                        validator: (val) => (val!.isEmpty || val.length < 11)
                            ? "أدخل رقم صحيح"
                            : null,
                        decoration: InputDecoration(
                          labelText: "رقم المحمول",
                          fillColor: ColorManager.accentColor,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          suffix: authController.showPrefix.value
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '2+',
                                  ),
                                )
                              : null,
                          suffixIcon: _buildSuffixIcon(),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final form =
                                authController.loginFormKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              authController.getOtp(true);
                            }
                          },
                          style: StyleManager.primaryButtonStyle,
                          child: authController.isLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'موافق',
                                    style: StyleManager.headlineWhite,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      GoogleAuthButton(
                        isLoading: authController.isGoogleLoading.value,
                        onPressed: () => authController.loginWithGoogle(),
                        textDirection: TextDirection.ltr,
                        text: "تسجيل بحساب جوجل",
                        style: const AuthButtonStyle(
                          iconType: AuthIconType.secondary,
                          textStyle: StyleManager.headline1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("لا تملك حساب ؟"),
                  TextButton(
                      onPressed: (() {
                        Get.toNamed(Routes.signup);
                      }),
                      child: const Text("تسجيل حساب"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyOtpForm() {
    List<TextEditingController> otpFieldsController = [
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              "أدخل الرقم المرسل اليك في رسالة نصية",
              textAlign: TextAlign.center,
              style: StyleManager.title,
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
                textDirection: TextDirection.ltr,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(
                          first: true,
                          last: false,
                          controller: otpFieldsController[0]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsController[1]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsController[2]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsController[3]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsController[4]),
                      _textFieldOTP(
                          first: false,
                          last: true,
                          controller: otpFieldsController[5]),
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
                        for (var controller in otpFieldsController) {
                          authController.otp.value += controller.text;
                        }
                        authController.verifyOTP();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ColorManager.primaryColorDark,
                        ),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
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
                      ? "أرسل الكود مدجددا"
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

  Widget _buildSuffixIcon() {
    return AnimatedOpacity(
        opacity: authController.phoneNo.value.length == 11 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: const Icon(Icons.check_circle, color: Colors.green, size: 32));
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

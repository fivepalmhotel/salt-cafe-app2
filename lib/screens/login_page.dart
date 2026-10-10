import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/sign_up_controller.dart';
import 'package:salt_cafe_app/controller/social_media_controller.dart';
import 'package:salt_cafe_app/restaurent/nav_baar.dart';
import 'package:salt_cafe_app/screens/login_verify.dart';
import 'package:salt_cafe_app/screens/verification_code.dart';
import 'forgot_password.dart';
import 'sign_in_screen.dart';

class LoginScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  final SocialController socialController = Get.put(SocialController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600; // Tablet breakpoint
          final isDesktop = constraints.maxWidth >= 1024; // Desktop breakpoint

          // Adjust font sizes and paddings based on screen size
          double headingFontSize =
              isDesktop ? 40.sp : (isTablet ? 34.sp : 28.sp);
          double bodyFontSize = isDesktop ? 18.sp : (isTablet ? 16.sp : 14.sp);
          double buttonHeight = isDesktop ? 70.h : 55.h;

          return SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    height: isDesktop ? 350.h : (isTablet ? 300.h : 250.h),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login_imges_up.jpg"),
                        fit: BoxFit.cover,
                         alignment: Alignment(0, -0.9),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Log In",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w800,
                              fontSize: headingFontSize,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Please sign in to your existing account",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w400,
                              fontSize: bodyFontSize,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Mobile", bodyFontSize),
                      _buildPhoneField(
                        hint: "9999999999",

                        controller: signUpController.loginPhoneController,
                      ),
                      SizedBox(height: 15.h),
                      // _buildLabel("Password", bodyFontSize),
                      // _buildTextField(hint: "••••••", isPassword: true),
                      _buildRememberMeAndForgotPassword(context, bodyFontSize),
                      _buildLoginButton(context, buttonHeight),
                      // _buildSignUp(context, bodyFontSize),
                      SizedBox(height: 25),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(
                                  color: const Color(0xffFF7622),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle navigation
                                        print('Sign Up tapped');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SignInScreen(),
                                          ),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      _buildSocialLogins(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Reusable Label
  Widget _buildLabel(String text, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.sen(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: const Color(0xff32343E),
      ),
    );
  }

  // Reusable TextField
  Widget _buildPhoneField({
    required String hint,
    required TextEditingController controller,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        String? errorText = _getPhoneFieldError(controller.text);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: const Color(0xffF0F5FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.sen(color: Colors.grey, fontSize: 14.sp),
              errorText: errorText, // ✅ Use it here
            ),
            onChanged: (value) {
              setState(() {
                // Close keyboard if valid
                if (value.length == 10 && RegExp(r'^\d{10}$').hasMatch(value)) {
                  FocusScope.of(context).unfocus();
                }
              });
            },
          ),
        );
      },
    );
  }

  String? _getPhoneFieldError(String value) {
    if (!RegExp(r'^\d*$').hasMatch(value)) {
      return "Only digits allowed";
    } else if (value.length < 10) {
      return "Enter 10 digits";
    }
    return null;
  }

  // Remember Me & Forgot Password
  Widget _buildRememberMeAndForgotPassword(
    BuildContext context,
    double fontSize,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Remember me",
            style: GoogleFonts.sen(fontSize: fontSize, color: Colors.grey),
          ),
          InkWell(
            onTap:
                () => Get.to(
                  () => const ForgotPassword(),
                  transition: Transition.fadeIn,
                ),
            child: Text(
              "Forgot Password?",
              style: GoogleFonts.sen(
                fontSize: fontSize,
                color: const Color(0xffFF7622),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton(BuildContext context, double buttonHeight) {
    final AllCityController allCityController = Get.put(AllCityController());
    final data = allCityController.cityList;
    final cityIds = data.map((city) => city.id).toList();
    // Then use any ID from the list

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Obx(
        () => GestureDetector(
          onTap:
              signUpController.isLoading.value
                  ? null
                  : () async {
                    try {
                      final success = await signUpController.login();
                      if (success) {
                        final phone = signUpController.phoneController.text;
                        print("Registered user => phone: $phone,");

                        Get.to(() => const LoginVerify());
                      } else {
                        Get.snackbar(
                          "Error",
                          signUpController.errorMessage.value.isNotEmpty
                              ? signUpController.errorMessage.value
                              : "Something went wrong",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.black,
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        signUpController.errorMessage.value.isNotEmpty
                            ? signUpController.errorMessage.value
                            : "Something went wrong",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black,
                      );
                    }
                  },
          child: Container(
            alignment: Alignment.center,
            height: buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xffEEA534),
            ),
            child:
                signUpController.isLoading.value
                    ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                    : Text(
                      "Log In",
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  // Sign Up
  // Widget _buildSignUp(BuildContext context, double fontSize) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 15.h),
  //     child: InkWell(
  //       onTap:
  //           () => Get.to(
  //             () => const SignInScreen(),
  //             transition: Transition.fadeIn,
  //           ),
  //       child: Center(
  //         child: Text.rich(
  //           TextSpan(
  //             text: "Don’t have an account? ",
  //             style: GoogleFonts.sen(fontSize: fontSize, color: Colors.grey),
  //             children: [
  //               TextSpan(
  //                 text: "Sign Up",
  //                 style: GoogleFonts.sen(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: fontSize,
  //                   color: const Color(0xffFF7622),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Social Logins
  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _socialIcon("f", const Color(0xff395998)),
        _socialIcon(
          "",
          const Color(0xff169CE8),
          asset: "assets/images/tweter.png",
        ),
        _socialIcon(
          "",
          const Color(0xff1B1F2F),
          asset: "assets/images/apple.png",
        ),
      ],
    );
  }

  Widget _socialIcon(String text, Color bgColor, {String? asset}) {
    return GestureDetector(
       onTap: () async {
                          socialController.openFacebook(
                            "https://www.facebook.com/@thesaltcafe",
                          );
                        },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: bgColor,
        child:
            asset != null
                ? Image.asset(asset)
                : Text(
                  text,
                  style: GoogleFonts.sen(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }
}

// Custom Clipper for Bottom Curve
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - 20, 30, size.height - 20);
    path.quadraticBezierTo(
      0,
      size.height - 20,
      size.width - 30,
      size.height - 20,
    );
    path.quadraticBezierTo(
      size.width,
      size.height - 20,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

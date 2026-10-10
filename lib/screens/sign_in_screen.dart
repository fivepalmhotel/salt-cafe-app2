import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salt_cafe_app/controller/sign_up_controller.dart';
import 'package:salt_cafe_app/screens/login_verify.dart';
import 'package:salt_cafe_app/screens/verification_code.dart';

class SignInScreen extends StatefulWidget {
final String? cityId;

  const SignInScreen({super.key, this.cityId});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final SignUpController controller = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String selectedLocation = Get.arguments ?? "Noida";
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600; // Tablet breakpoint
          final isDesktop = constraints.maxWidth >= 1024; // Desktop breakpoint

          // Adjust font sizes and paddings based on screen size
          double headingFontSize =
              isDesktop ? 40.sp : (isTablet ? 34.sp : 28.sp);
          double bodyFontSize = isDesktop ? 18.sp : (isTablet ? 16.sp : 14.sp);
          double buttonHeight = isDesktop ? 70.h : 45.h;
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40,left: 10),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 22,
                                  child: Icon(Icons.arrow_back_ios,size: 16,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w800,
                            fontSize: headingFontSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Please sign up to get started",
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.sen(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff32343E),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                        child: TextFormField(
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffF0F5FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Ayush Mehra",
                            hintStyle: GoogleFonts.sen(
                              color: Colors.grey,
                              fontSize: bodyFontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        "Contact",
                        style: GoogleFonts.sen(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff32343E),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                        child: TextFormField(
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffF0F5FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "+91 1234567890",
                            hintStyle: GoogleFonts.sen(
                              color: Colors.grey,
                              fontSize: bodyFontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SlideTransition(
                    position: _animation,
                    child: Obx(() {
                      return GestureDetector(
                        onTap:
                            controller.isLoading.value
                                ? null
                                : () async {
                                  try {
                                    final success = await controller.signUp();
                                    if (success) {
                                      final name =
                                          controller.nameController.text;
                                      final phone =
                                          controller.phoneController.text;
                                      print(
                                        "Registered user => phone: $phone, name: $name",
                                      );

                                      Get.to(() => const LoginVerify());
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        controller.errorMessage.value.isNotEmpty
                                            ? controller.errorMessage.value
                                            : "Something went wrong",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red.shade100,
                                        colorText: Colors.black,
                                      );
                                    }
                                    
                                  } catch (e) {
                                    Get.snackbar(
                                      "Error",
                                      controller.errorMessage.value.isNotEmpty
                                          ? controller.errorMessage.value
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
                              controller.isLoading.value
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(
                                    "Sign Up",
                                    style: GoogleFonts.sen(
                                      fontSize: bodyFontSize,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom Clipper for the bottom curve
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
      secondFirstCurve.dx,
      secondFirstCurve.dy,
      secondLastCurve.dx,
      secondLastCurve.dy,
    );

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
      thirdFirstCurve.dx,
      thirdFirstCurve.dy,
      thirdLastCurve.dx,
      thirdLastCurve.dy,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

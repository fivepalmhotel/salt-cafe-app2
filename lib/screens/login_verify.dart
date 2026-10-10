import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/sign_up_controller.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:salt_cafe_app/screens/reserve_your_table.dart';

class LoginVerify extends StatefulWidget {
  const LoginVerify({super.key});

  @override
  State<LoginVerify> createState() => _LoginVerifyState();
}

class _LoginVerifyState extends State<LoginVerify>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  final SignUpController otpController = Get.put(SignUpController());
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the animation (bottom to top movement)
    _animation = Tween<Offset>(
      begin: const Offset(0, 2), // Start below the screen
      end: const Offset(0, 0), // End at the original position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the animation
    _animationController.forward();

    signUpController.startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final int otpLength = 4;
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNode = List.generate(4, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    //final String selectedLocation = Get.arguments ?? "Noida";
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(Icons.arrow_back_ios),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Verification",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w800,
                            fontSize: headingFontSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "We have sent a code to your email",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w400,
                            fontSize: bodyFontSize,
                            color: Colors.white,
                          ),
                        ),

                        Text(
                          signUpController.phoneController.text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.bold,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "code",
                            style: GoogleFonts.sen(
                              fontSize: bodyFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Obx(() {
                            final isClickable =
                                signUpController.isResendEnabled.value;
                            final seconds =
                                signUpController.secondsRemaining.value;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                signUpController.isResendLoading.value
                                    ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap:
                                          isClickable
                                              ? () {
                                                signUpController
                                                    .resendOtp(); // ✅ wrap the login/signup
                                              }
                                              : null,
                                      child: Text(
                                        "Resend",
                                        style: GoogleFonts.sen(
                                          decoration:
                                              isClickable
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              isClickable
                                                  ? Colors.blue
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ),
                                if (!isClickable)
                                  Text(
                                    " in ${seconds}s",
                                    style: GoogleFonts.sen(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            otpController.otpLength,
                            (index) => SizedBox(
                              width: 68.w,
                              child: TextFormField(
                                controller: otpController.otpControllers[index],
                                focusNode: otpController.focusNodes[index],
                                cursorColor: Colors.black,
                                onChanged: (val) {
                                  if (val.length == 1) {
                                    if (index < otpController.otpLength - 1) {
                                      FocusScope.of(context).requestFocus(
                                        otpController.focusNodes[index + 1],
                                      );
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  } else if (val.isEmpty && index > 0) {
                                    FocusScope.of(context).requestFocus(
                                      otpController.focusNodes[index - 1],
                                    );
                                  }
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: bodyFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                    fontSize: bodyFontSize,
                                    color: Colors.grey,
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      GestureDetector(
                        onTap:
                            otpController.isLoading.value
                                ? null
                                : () async {
                                  bool success =
                                      await otpController.otpVerifye();
                                  if (success) {
                                    Get.to(() => ReserveYourTable());
                                  }
                                },
                        child: SlideTransition(
                          position: _animation,
                          child: Container(
                            alignment: Alignment.center,
                            height: buttonHeight,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color(0xffEEA534),
                            ),
                            child: Obx(() {
                              return otpController.isLoading.value
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Text(
                                    "Verify",
                                    style: GoogleFonts.sen(
                                      fontSize: bodyFontSize,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  );
                            }),
                          ),
                        ),
                      ),
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
}

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

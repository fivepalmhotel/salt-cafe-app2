import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/auth_check_controller.dart';
import 'package:salt_cafe_app/screens/SpController/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashScreenController =
      Get.put(SplashScreenController(), permanent: true);
     
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 240.h, left: 90.w),
            child: Text(
              "Welcome",
              style: GoogleFonts.alexBrush(
                color: const Color(0xffEEA534),
                fontSize: 58.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "THE SALT CAFE",
                    style: GoogleFonts.anton(
                      color: const Color(0xffFFFFFF),
                      fontSize: 38.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 4,
                      color: Colors.white,
                      indent: 80,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 4,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 80,
                    ),
                  ),
                ],
              ),
              Text(
                "Multicuisine Restaurant & Bar",
                style: GoogleFonts.crimsonText(
                  color: const Color(0xffFFFFFF),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 326.h, left: 177.w),
            child: Text(
              "*",
              style: GoogleFonts.alexBrush(
                color: const Color(0xffEEA534),
                fontSize: 58.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

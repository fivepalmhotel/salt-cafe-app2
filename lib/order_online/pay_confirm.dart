import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../restaurent/nav_baar.dart';

class PayConfirm extends StatelessWidget {
  const PayConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned(
                  left: 46,
                  child: Image.asset(
                    "assets/images/happy_image.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  "assets/images/burgur_image.gif",
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                "Congratulations!",
                style: GoogleFonts.sen(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              '''You successfully maked a payment,
enjoy our service!''',
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: Get.height * 0.2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const BottomNavBar(
                      initialIndex: 1,
                    ),
                    transition: Transition.upToDown,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 55.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: const Color(0xffEEA534),
                  ),
                  child: Text(
                    "Congratulations",
                    style: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

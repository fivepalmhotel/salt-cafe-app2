import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/screens/reserve_your_table.dart';

import 'order.dart';

class SelectService extends StatelessWidget {
  const SelectService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lognimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 210.h, left: 90.w),
              child: Text(
                "Welcome",
                style: GoogleFonts.alexBrush(
                  color: const Color(0xffEEA534),
                  fontSize: 58.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
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
                  SizedBox(height: Get.height * 0.04),
                  InkWell(
                    onTap: () {
                      Get.off(
                        () => ReserveYourTable(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 37.h,
                      width: 204.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffFFFFFF), Color(0xffFFD57A)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Reserve Your Table",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  InkWell(
                    onTap: () {
                      Get.off(() => const Order());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 37.h,
                      width: 204.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffFFFFFF), Color(0xffFFD57A)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Order Online",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 295.h, left: 177.w),
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
      ),
    );
  }
}

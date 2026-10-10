import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/controller/social_media_controller.dart';

class ReferEarn extends StatelessWidget {
  ReferEarn({super.key});

  final SocialController socialController = Get.put(SocialController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/themeimg.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Refer & Earn",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Glow Effect (Outer Layer)
                      Container(
                        height: 210, // Slightly bigger than the main image
                        width: 210,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Ensures a circular glow
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xffF5BB3B,
                              ).withOpacity(0.6), // Yellow glow
                              spreadRadius:
                                  1, // Controls the spread of the glow
                              blurRadius: 10, // Soft glow effect
                            ),
                          ],
                        ),
                      ),

                      // Circular Image with Elevation (Inner Layer)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            shape:
                                BoxShape.circle, // Ensures proper rounded shape
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xffF5BB3B,
                                ).withOpacity(0.9), // Strong yellow glow
                                spreadRadius: 5, // Slight glow around the image
                                blurRadius: 10, // Smooth soft effect
                                offset: const Offset(
                                  0,
                                  5,
                                ), // Elevation shadow below
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(33),
                            child: Image.asset(
                              "assets/images/tata.jpeg",
                              height: 150, // Adjusted for better fit
                              width: 150,
                              fit:
                                  BoxFit
                                      .cover, // Ensures the image covers the space
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 186.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color(0xff9D6712),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "How it Works",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Share the referral link ",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "with your friend",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "After your friend places their first order, you ",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "get 10% off ",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "up to ₹100 on your next order",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "On 5 successful referrals,",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "you earn ₹ 1000",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(() {
                    final userData = profileController.userProfile.value;
                    return GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: userData!.data.referralCode.toString(),
                          ),
                        );
                        Get.snackbar(
                          "Copied",
                          "Referral code copied to clipboard!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        height: 52,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.copy, color: Colors.black),
                            SizedBox(width: 10.w),
                            Text(
                              userData!.data.referralCode.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {
                      socialController.openWhatsApp(
                        "+91 97118 28200",
                        "Hello, I’d like to know more!",
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      height: 52,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/whatsapp.png"),
                          SizedBox(width: 10.w),
                          const Text(
                            "Invite via WhatsApp",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

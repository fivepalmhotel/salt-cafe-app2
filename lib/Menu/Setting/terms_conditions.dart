import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/terms_con_controller.dart';

class TermsConditions extends StatelessWidget {
  final TermsController termsController = Get.put(TermsController());

  TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
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
                      "Terms & Conditions ",
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
                      height: 140, // Slightly bigger than the main image
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Ensures a circular glow
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xffF5BB3B,
                            ).withOpacity(0.6), // Yellow glow
                            spreadRadius: 1, // Controls the spread of the glow
                            blurRadius: 10, // Soft glow effect
                          ),
                        ],
                      ),
                    ),

                    // Circular Image with Elevation (Inner Layer)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 130,
                        width: 130,
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
                Obx(() {
                  final about = termsController.getTerms;

                  if (about.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  final data = about[0].terms;

                  if (data == null || data.isEmpty) {
                    return Center(
                      child: Text(
                        "Coming Soon",
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }

                  return Text(
                    data,
                    style: GoogleFonts.sen(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),

                SizedBox(height: Get.height * 0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/Setting/refer_earn.dart';
import 'package:salt_cafe_app/Menu/Setting/terms_conditions.dart';

import 'about_us.dart';
import 'contacts_support.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Settings",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Container(
                      height: 307,
                      width: 350.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(() => const ContactSupport());
                            },
                            leading: Image.asset("assets/images/Call.png"),
                            title: Text(
                              "Contact Support",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff32343E),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.info_outline,
                              color: Color(0xffFF7622),
                            ),
                            title: Text("Report"),
                            trailing: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() =>  ReferEarn());
                            },
                            leading: Image.asset("assets/images/refer.png"),
                            title: Text(
                              "Refer & Earn",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff32343E),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() =>  TermsConditions());
                            },
                            leading: const Icon(
                              Icons.notifications_none_outlined,
                              color: Color(0xffFF7622),
                            ),
                            title: Text(
                              "Terms & Condition",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff32343E),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() =>  AboutUs());
                            },
                            leading: Image.asset("assets/images/about.png"),
                            title: Text(
                              "About Salt Cafe",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff32343E),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

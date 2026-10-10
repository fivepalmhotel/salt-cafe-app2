import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/models/profile_model.dart';

import 'edit_profile.dart';

class PersonalInfo extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  PersonalInfo({super.key});

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
              padding: EdgeInsets.only(top: 50.h, left: 10, right: 10),
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
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back_ios, size: 15),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Personal Info",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                       onTap: () {
  final userData = profileController.userProfile.value;

  if (userData != null) {
    Get.to(() => EditProfile(userId: userData.data.id));
  } else {
    Get.snackbar("Error", "User data not available");
  }
},

                        child: Text(
                          "EDIT",
                          style: GoogleFonts.sen(
                            decorationColor: const Color(0xffEEA534),
                            decorationThickness: 2,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xffEEA534),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //assets/images/profile_pic.jpeg
                  SizedBox(height: Get.height * 0.04),
                  Obx(() {
                    final userData = profileController.userProfile.value;
                    final userImage =
                        profileController.userProfile.value?.data?.image;
                    if (userData == null) {
                      return const SizedBox(); // or a loading indicator
                    }

                    // final userImages = userData.data.image;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          '$userImage?v=${DateTime.now().millisecondsSinceEpoch}',
                        ),
                      ),
                      title: Text(
                        userData.data.fullName ?? '',
                        style: GoogleFonts.sen(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffEEA534),
                        ),
                      ),
                      subtitle: Text(
                        userData.data.bio ?? "",
                        style: GoogleFonts.sen(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    height: 240.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: Obx(() {
                      final userData =
                          profileController.userProfile.value?.data;

                      if (userData == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Image.asset(
                              "assets/images/men.png",
                              fit: BoxFit.cover,
                            ),
                            subtitle: Text(
                              userData.fullName ?? "Vishal Khadok",
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey,
                              ),
                            ),
                            title: Text(
                              "Personal Info",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff32343E),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset(
                              "assets/images/mail.png",
                              fit: BoxFit.cover,
                            ),
                            subtitle: Text(userData.email ?? "Not available"),
                            title: Text(
                              "Email",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff32343E),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset(
                              "assets/images/Call.png",
                              fit: BoxFit.cover,
                            ),
                            subtitle: Text(userData.phone ?? "Not available"),
                            title: Text(
                              "Phone Number",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff32343E),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),

                  SizedBox(height: Get.height * 0.7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/personal_info.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/controller/upload_image_globle.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class EditProfile extends StatelessWidget {
  final String? userId;
  final ProfileController profileController = Get.put(ProfileController());
  final UploadProfileController controller = Get.put(UploadProfileController());
  EditProfile({super.key, this.userId});

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
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back_ios, size: 15),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    return CircleAvatar(
                      key: ValueKey(controller.uploadedImageUrl.value),
                      radius: 60,
                      backgroundImage:
                          controller.uploadedImageUrl.isNotEmpty
                              ? NetworkImage(
                                // Add timestamp to force refresh if image updated
                                '${controller.uploadedImageUrl.value}?v=${DateTime.now().millisecondsSinceEpoch}',
                              )
                              : controller.profileImagePath.isNotEmpty
                              ? FileImage(
                                File(controller.profileImagePath.value),
                              )
                              : const AssetImage("") as ImageProvider,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: controller.pickImage, // Open image picker
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEEA534),
                                ),
                                child: const Icon(
                                  Icons.mode_edit_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  Text(
                    "FULL NAME",
                    style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Obx(() {
                    final userData = profileController.userProfile.value;
                    if (profileController.nameController.text.isEmpty) {
                      profileController.nameController.text =
                          userData!.data.fullName ?? '';
                    }

                    return TextFormField(
                      controller: profileController.nameController,
                      decoration: InputDecoration(
                        hintText: "Vishal Khadok",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "EMAIL",
                    style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Obx(() {
                    final userData = profileController.userProfile.value;
                    if (profileController.emailController.text.isEmpty) {
                      profileController.emailController.text =
                          userData!.data.email ?? '';
                    }

                    return TextFormField(
                      controller: profileController.emailController,
                      decoration: InputDecoration(
                        hintText: "hello@halallab.co",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "PHONE NUMBER",
                    style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Obx(() {
                    final userData = profileController.userProfile.value;
                    if (profileController.phoneController.text.isEmpty) {
                      profileController.phoneController.text =
                          userData!.data.phone ?? '';
                    }

                    return TextFormField(
                      controller: profileController.phoneController,
                      decoration: InputDecoration(
                        hintText: "408-841-0926",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "BIO",
                    style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      height: 150,
                      child: TextFormField(
                        controller: profileController.bioController,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: "I love fast food",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Obx(() {
                    return GestureDetector(
                      onTap: () async {
                        if (!profileController.isLoading.value) {
                          // Trim inputs if needed (usually you do this before updating controller)
                          profileController.nameController.text =
                              profileController.nameController.text.trim();
                          profileController.emailController.text =
                              profileController.emailController.text.trim();
                          profileController.phoneController.text =
                              profileController.phoneController.text.trim();
                          profileController.bioController.text =
                              profileController.bioController.text.trim();

                          print("Updating Profile With:");
                          print(
                            "Name: ${profileController.nameController.text}",
                          );
                          print(
                            "Email: ${profileController.emailController.text}",
                          );
                          print(
                            "Phone: ${profileController.phoneController.text}",
                          );
                          print("Bio: ${profileController.bioController.text}");

                          // Get token here before calling updateProfileWithImage
                          final prefs = await SharedPreferences.getInstance();
                          final token = prefs.getString("token");
                          await profileController.getProfile();
                          if (token != null) {
                            await profileController.updateProfileWithImage(
                              token,
                            );

                            // Navigate only if update finished (isLoading is false)
                            if (!profileController.isLoading.value) {
                              Get.off(
                                () => PersonalInfo(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500),
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Unauthorized",
                              "Token not found. Please login again.",
                            );
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 345.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: const Color(0xffEEA534),
                        ),
                        child:
                            profileController.isLoading.value
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: 2.5,
                                  ),
                                )
                                : Text(
                                  "Save",
                                  style: GoogleFonts.sen(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                      ),
                    );
                  }),

                  SizedBox(height: Get.height * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

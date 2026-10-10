import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/payment.dart';
import 'package:salt_cafe_app/Menu/personal_info.dart';
import 'package:salt_cafe_app/Menu/Setting/setting_screen.dart';
import 'package:salt_cafe_app/controller/auth_check_controller.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/controller/sign_up_controller.dart';
import 'package:salt_cafe_app/controller/social_media_controller.dart';
import 'package:salt_cafe_app/order_online/my_cart.dart';
import 'package:salt_cafe_app/screens/get_all_review_screen.dart';
import 'package:salt_cafe_app/screens/home_screen.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:salt_cafe_app/screens/sign_in_screen.dart';

import 'faq_screen.dart';
import 'fevourite.dart';
import 'menu_cart.dart';
import 'my_address.dart';
import 'my_orders.dart';
import 'notification.dart';

class Menu extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final SignUpController signUpController = Get.put(SignUpController());
  final SocialController socialController = Get.put(SocialController());

  Menu({super.key});

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
                        "Menu",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  //assets/images/profile_pic.jpeg
                  SizedBox(height: Get.height * 0.04),
                  Obx(() {
                    final userData = profileController.userProfile.value;

                    if (userData == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final dummyImages = userData.data.image;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("$dummyImages"),
                      ),
                      title: Text(
                        userData.data.fullName ?? "Unknown User",
                        style: GoogleFonts.sen(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffEEA534),
                        ),
                      ),
                      subtitle: Text(
                        userData.data.bio ?? "No bio available",
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
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(() => PersonalInfo());
                          },
                          leading: Image.asset(
                            "assets/images/men.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Personal Info",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => MyAddress());
                          },
                          leading: Image.asset(
                            "assets/images/map.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Addresses",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    height: 270.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(() => const MyOrders());
                          },
                          leading: Image.asset(
                            "assets/images/order_cart.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "My Orders",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const MyCart());
                          },
                          leading: Image.asset(
                            "assets/images/order_cart.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Cart",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        // ListTile(
                        //   onTap: () {
                        //     Get.to(() => const Favorite());
                        //   },
                        //   leading: Image.asset(
                        //     "assets/images/fev.png",
                        //     fit: BoxFit.cover,
                        //   ),
                        //   title: Text(
                        //     "Favourite",
                        //     style: GoogleFonts.sen(
                        //       fontSize: 16.sp,
                        //       fontWeight: FontWeight.w700,
                        //       color: const Color(0xff32343E),
                        //     ),
                        //   ),
                        //   trailing: const Icon(
                        //     Icons.arrow_forward_ios_sharp,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const MenuNotification());
                          },
                          leading: Image.asset(
                            "assets/images/noti.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Notifications",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const PaymentMethod());
                          },
                          leading: Image.asset(
                            "assets/images/paay.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Payment Method",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ListTile(
                        //   onTap: () {
                        //     Get.to(() => const FaqScreen());
                        //   },
                        //   leading: Image.asset(
                        //     "assets/images/faq.png",
                        //     fit: BoxFit.cover,
                        //   ),
                        //   title: Text(
                        //     "FAQs",
                        //     style: GoogleFonts.sen(
                        //       fontSize: 16.sp,
                        //       fontWeight: FontWeight.w700,
                        //       color: const Color(0xff32343E),
                        //     ),
                        //   ),
                        //   trailing: const Icon(
                        //     Icons.arrow_forward_ios_sharp,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        ListTile(
                          onTap: () {


                          Get.to(() => AllReviewsPage());
                          },
                          leading: Image.asset(
                            "assets/images/us.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "User Reviews",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const SettingScreen());
                          },
                          leading: Image.asset(
                            "assets/images/setting.png",
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Settings",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    alignment: Alignment.center,
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            insetPadding: const EdgeInsets.symmetric(
                              vertical: 210,
                              horizontal: 20,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Logout",
                                    style: GoogleFonts.sen(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff6E3C1B),
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Do you really  want \nto Log out your \naccount? 🥺",
                                    style: GoogleFonts.sen(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff181C2E),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await signUpController.logout();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 33.h,
                                            width: 144.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              border: Border.all(
                                                color: const Color(0xffEEA534),
                                              ),
                                            ),
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.sen(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xffEEA534),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 33.h,
                                            width: 144.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffEEA534),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Text(
                                              "No",
                                              style: GoogleFonts.sen(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/Logout.png",
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        "Log Out",
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff32343E),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          socialController.openFacebook(
                            "https://www.facebook.com/@thesaltcafe",
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff395998),
                          child: Text(
                            "f",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          socialController.openUrl(
                            "https://www.instagram.com/thesaltcafedelhi/",
                          );
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            "assets/images/insta.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

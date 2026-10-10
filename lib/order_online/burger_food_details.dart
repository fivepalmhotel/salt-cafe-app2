import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_cart.dart';

class FoodDetailsBurger extends StatefulWidget {
  const FoodDetailsBurger({super.key});

  @override
  State<FoodDetailsBurger> createState() => _FoodDetailsBurgerState();
}

class _FoodDetailsBurgerState extends State<FoodDetailsBurger> {
  final List<Map<String, String>> ingredients = [
    {"image": "assets/images/Salt.png", "name": "Salt"},
    {"image": "assets/images/chiken.png", "name": "Chicken"},
    {"image": "assets/images/Onion.png", "name": "Onion\n(Alergy)"},
    {"image": "assets/images/garlic.png", "name": "Garlic"},
    {"image": "assets/images/paper.png", "name": "Pappers\n(Alergy)"},
    {"image": "assets/images/paper.png", "name": "Pappers\n(Alergy)"},
    {"image": "assets/images/Onion.png", "name": "Onion\n(Alergy)"},
    {"image": "assets/images/Salt.png", "name": "Salt"},
  ];

  int currentQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xffEEA534),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentQuantity > 1) {
                        setState(() {
                          currentQuantity--;
                        });
                      }
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 10),
                  Text("$currentQuantity"),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentQuantity++;
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const MyCart());
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Text(
                  "Add item - ₹209",
                  style: GoogleFonts.sen(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/themeimg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          // Scrollable Content
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
                          child: Icon(Icons.arrow_back_ios, size: 10),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        "Details",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.04),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36.r),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 230,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/burgur2.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: CircleAvatar(
                          radius: 25,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    alignment: Alignment.center,
                    height: 47.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rest.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        const Text("Sector-104 Noida"),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "Burger Calzone European",
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    '''Prosciutto e funghi is a pizza variety that is topped with tomato sauce.''',
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: const Color(0xff9D9D9D),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border_purple500,
                        color: Color(0xffFFB71A),
                      ),
                      Text(
                        " 4.7",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 35.w),
                      Row(
                        children: [
                          Image.asset("assets/images/Delivery.png"),
                          Text(
                            " Free",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 35.w),
                      Row(
                        children: [
                          Image.asset("assets/images/Clock.png"),
                          Text(
                            " 20 min",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      Text(
                        "SIZE:",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Text("10”"),
                      ),
                      SizedBox(width: 15.w),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xffB78E4F),
                        child: Text(
                          "14”",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Text("16”"),
                      ),
                    ],
                  ),
                  // SizedBox(height: 30.h),
                  // Text(
                  //   "INGREDIENT:",
                  //   style: GoogleFonts.sen(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 17.sp,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   padding: const EdgeInsets.all(0),
                  //   crossAxisCount: 5,
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  //   childAspectRatio: 3 / 5,
                  //   children: ingredients.map((item) {
                  //     return Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         CircleAvatar(
                  //           backgroundColor: const Color(0xff30332c),
                  //           radius: 30.r,
                  //           child: Image.asset(
                  //             item['image']!,
                  //           ),
                  //         ),
                  //         SizedBox(height: 2.h),
                  //         Flexible(
                  //           child: Text(
                  //             item['name']!,
                  //             style: GoogleFonts.sen(
                  //               fontWeight: FontWeight.w700,
                  //               fontSize: 11.sp,
                  //               color: Colors.white,
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //
                  //       ],
                  //     );
                  //   }).toList(),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 490,
          //   left: 15,
          //   child: Text(
          //     "ingredients:",
          //     style: GoogleFonts.sen(
          //         fontWeight: FontWeight.w500,
          //         fontSize: 17.sp,
          //         color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}

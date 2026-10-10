import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order_online/burger_food_details.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final List<Map<String, dynamic>> weeklySpecial = [
    {
      "image": "assets/images/bristo.png",
      "title": "Prawn mix ",
      "subtitle": "Noida",
      "price": "₹500"
    },
    {
      "image": "assets/images/burgur1.png",
      "title": "BBQ",
      "subtitle": "Noida",
      "price": "₹750"
    },
    {
      "image": "assets/images/burgur2.png",
      "title": "Prawn mix ",
      "subtitle": "Noida",
      "price": "₹500"
    },
    {
      "image": "assets/images/burgur3.png",
      "title": "BBQ",
      "subtitle": "Noida",
      "price": "₹750"
    },
    
  ];
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
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        "Favorite",
                        style: GoogleFonts.sen(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  GridView.builder(
                      itemCount: weeklySpecial.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 3 / 4),
                      itemBuilder: (context, index) {
                        final item = weeklySpecial[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Card Container
                              InkWell(
                              onTap: () {
                        Get.to(() => const FoodDetailsBurger());},
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  margin: const EdgeInsets.only(
                                    top: 60,
                                  ), // Push down for overlap effect
                                  decoration: BoxDecoration(
                                    color: const Color(0xff070707),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xff474747), width: 2),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(top: 58, left: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            item["title"],
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        // Title
                                        Text(
                                          item['subtitle'],
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: const Color(0xff636363),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        // Price
                                        Padding(
                                          padding: EdgeInsets.only(right: 16.w),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item['price'],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: const Color(0xff03AD74),
                                                ),
                                              ),
                                              const CircleAvatar(
                                                backgroundColor: Color(0xffEEA534),
                                                radius: 15,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Image on Top
                              Positioned(
                                top: 0, // Overlap effect
                                left: 9, // Center the image on the card
                                right: 20,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: AssetImage(item['image']),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: Get.height*0.2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

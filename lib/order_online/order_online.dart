import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/banner_controller.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/food_category_controller.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/order_online/food_category.dart';
import 'package:salt_cafe_app/Menu/menu.dart';
import 'package:salt_cafe_app/order_online/offere_screen.dart';
import 'package:salt_cafe_app/order_online/popular_pizza.dart';

import 'item_search.dart';
import 'my_cart.dart';

class OrderOnline extends StatefulWidget {
  const OrderOnline({super.key});

  @override
  State<OrderOnline> createState() => _OrderOnlineState();
}

class _OrderOnlineState extends State<OrderOnline> {
  final AllFoodCategory foodCategory = Get.put(AllFoodCategory());
  final AddToCartController cartController = Get.put(AddToCartController());
  final AllCityController allController = Get.put(AllCityController());
  final ProfileController profileController = Get.put(ProfileController());
  final BannerController getBanner = Get.put(BannerController());

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
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Menu(),
                            transition: Transition.upToDown,
                            duration: const Duration(milliseconds: 500),
                            fullscreenDialog: true,
                          );
                        },
                        child: Image.asset("assets/images/Menu.png"),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deliver to",
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffEEA534),
                            ),
                          ),
                          Obx(() {
                            final hotels = allController.hotelList;

                            if (hotels.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 15.h,
                                  left: 15.w,
                                  right: 15.w,
                                ),
                                child: Text(
                                  "No hotels available",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                            final cityName =
                                hotels
                                    .firstWhere(
                                      (hotel) => hotel.city != null,
                                      orElse:
                                          () =>
                                              hotels
                                                  .first, // Fallback to first hotel if none have cities
                                    )
                                    .city
                                    ?.name ??
                                "Unknown Location"; // Null-safe city name

                            return Row(
                              children: [
                                Text(
                                  cityName,
                                  style: GoogleFonts.sen(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.white,
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          final cartData = cartController.getCart.value;

                          if (cartData == null || cartData.services.isEmpty) {
                            Get.snackbar(
                              "Cart is empty",
                              "Please add item",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                            );
                            return;
                          }

                          Get.to(() => const MyCart());
                        },
                        child: badges.Badge(
                          position: badges.BadgePosition.topEnd(
                            top: -5,
                            end: -10,
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: Colors.red,
                            padding: EdgeInsets.all(6),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          badgeContent: Obx(() {
                            final cartData = cartController.getCart.value;
                            final itemCount = cartData?.services.length ?? 0;

                            return Text(
                              "$itemCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xffEEA534),
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Greeting
                Obx(() {
                  final userData = profileController.userProfile.value;
                  if (userData == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  String getGreeting() {
                    final hour = DateTime.now().hour;
                    if (hour < 12) {
                      return 'Good Morning';
                    } else if (hour < 17) {
                      return 'Good Afternoon';
                    } else {
                      return 'Good Evening';
                    }
                  }

                  return Text(
                    "Hey ${userData.data.fullName}, ${getGreeting()}!",
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  );
                }),
                SizedBox(height: 15.h),

                // Search Bar
                InkWell(
                  onTap: () {
                    Get.to(() => const ItemSearch());
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search dishes, restaurants",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                //SizedBox(height: 20.h),

                // Special Offer Section
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Special Offer",
                //       style: GoogleFonts.sen(
                //         fontSize: 20.sp,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.white,
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => const OfferScreen(),
                //           ),
                //         );
                //       },

                //       child: Text(
                //         "See All >",
                //         style: GoogleFonts.sen(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w700,
                //           color: const Color(0xffEEA534),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Obx(() {
                  if (getBanner.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (getBanner.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        getBanner.errorMessage.value,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  if (getBanner.offerBanners.isEmpty) {
                    return const Center(
                      child: Text(
                        "No banners found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getBanner.offerBanners.length,
                    itemBuilder: (context, index) {
                      final bannerData = getBanner.offerBanners[index];
                      final titleParts = bannerData.title.split(' ');
                      final firstLine =
                          titleParts.length >= 2
                              ? "${titleParts[0]} ${titleParts[1]}"
                              : bannerData.title;
                      final secondLine =
                          titleParts.length > 2
                              ? titleParts.sublist(2).join(' ')
                              : "";

                      return Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          height: 185.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: const Color(0xffEEA534),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 210,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(35),
                                      topLeft: Radius.circular(35),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/renc.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 40,
                                        ),
                                        child: Text(
                                          bannerData.desc,
                                          style: GoogleFonts.poppins(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff533200),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        firstLine,
                                        style: GoogleFonts.inter(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff533200),
                                        ),
                                      ),
                                      Text(
                                        secondLine,
                                        style: GoogleFonts.inter(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff533200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.network(
                                bannerData.image,
                                height: 175,
                                width: 138,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                SizedBox(height: 20.h),
                Center(
                  child: Image.asset(
                    "assets/images/line.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Categories",
                      style: GoogleFonts.sen(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => FoodCategory());
                      },
                      child: Text(
                        "See More >",
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          color: const Color(0xffEEA534),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                SizedBox(
                  height: 150.h,
                  child: Obx(() {
                    if (foodCategory.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (foodCategory.foodList.isEmpty) {
                      return const Center(
                        child: Text(
                          "Try again later",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodCategory.foodList.length,
                      itemBuilder: (context, index) {
                        final foodImage = foodCategory.foodList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (foodImage.id.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "The food category ID is missing.",
                                    );
                                    return;
                                  }

                                  bool isSuccess = await foodCategory
                                      .getsubCategory(foodImage.id);

                                  if (isSuccess) {
                                    Get.to(
                                      () => PopularPizza(title: foodImage.name),
                                    );
                                  }
                                },

                                child: Container(
                                  width: 110, // Set fixed width
                                  height:
                                      110, // Set fixed height for the image container
                                  decoration: BoxDecoration(
                                    color: Colors.grey, // Background color
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 2, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ), // Rounded corners
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ), // Apply same border radius
                                    child:
                                        // ignore: unnecessary_null_comparison
                                        foodImage.image == null
                                            ? const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 50,
                                              ),
                                            )
                                            : Image.network(
                                              foodImage.image.toString(),
                                              fit:
                                                  BoxFit
                                                      .cover, // Ensures image covers the box
                                              loadingBuilder: (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              },
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return const Center(
                                                  child: Icon(Icons.error),
                                                );
                                              },
                                            ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 8.h),
                              SizedBox(
                                width:
                                    120, // Ensures text width matches image width
                                child: Text(
                                  foodImage.name,
                                  textAlign:
                                      TextAlign
                                          .center, // Centers text under the image
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),

                // SizedBox(height: 15.h),
                // Center(
                //     child: Image.asset(
                //   "assets/images/line.png",
                //   fit: BoxFit.cover,
                // )),
                // SizedBox(height: 20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Weekly Special ",
                //       style: GoogleFonts.sen(
                //         fontSize: 20.sp,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.white,
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         "See All >",
                //         style: GoogleFonts.sen(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w700,
                //           color: const Color(0xffEEA534),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 220,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: weeklySpecial.length,
                //     itemBuilder: (context, index) {
                //       final item = weeklySpecial[index];
                //       return Padding(
                //         padding: const EdgeInsets.only(right: 12.0),
                //         child: Stack(
                //           clipBehavior: Clip.none,
                //           children: [
                //             // Card Container
                //             Container(
                //               width: 180,
                //               height: 180,
                //               margin: const EdgeInsets.only(
                //                 top: 60,
                //               ), // Push down for overlap effect
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(16),
                //               ),
                //               child: Padding(
                //                 padding:
                //                     const EdgeInsets.only(top: 88, left: 15),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     // Title
                //                     Text(
                //                       item['title'],
                //                       style: GoogleFonts.poppins(
                //                         fontWeight: FontWeight.w600,
                //                         fontSize: 18,
                //                         color: Colors.black,
                //                       ),
                //                       overflow: TextOverflow.ellipsis,
                //                     ),
                //                     const SizedBox(height: 4),
                //                     // Price
                //                     Padding(
                //                       padding: EdgeInsets.only(right: 16.w),
                //                       child: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Text(
                //                             item['subtitle'],
                //                             style: GoogleFonts.poppins(
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: 18,
                //                               color: Colors.black,
                //                             ),
                //                           ),
                //                           Text(
                //                             item['price'],
                //                             style: GoogleFonts.poppins(
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: 23,
                //                               color: const Color(0xff03AD74),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             // Image on Top
                //             Positioned(
                //               top: 0, // Overlap effect
                //               left: 9, // Center the image on the card
                //               right: 20,
                //               child: Image.asset(
                //                 item['image'],
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

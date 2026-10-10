import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/food_category_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_cart.dart';

class FoodDetailsPizza extends StatefulWidget {
  const FoodDetailsPizza({super.key});

  @override
  State<FoodDetailsPizza> createState() => _FoodDetailsPizzaState();
}

class _FoodDetailsPizzaState extends State<FoodDetailsPizza> {
  final AllFoodCategory foodCategory = Get.put(AllFoodCategory());
  final AddToCartController cartController = Get.put(AddToCartController());

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
      bottomSheet: Obx(() {
        final offerDetails = foodCategory.foodDetail.value;
        final quantity = cartController.quantity.value;
        final price = (offerDetails?.discountPrice ?? 0) * quantity;

        return Container(
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
              // Quantity Control
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          cartController.quantity.value--;
                        }
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => Text(
                        '${cartController.quantity.value}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        cartController.quantity.value++;
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),

              // Add Item Button
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (offerDetails != null &&
                        !cartController.isLoading.value) {
                      cartController.isLoading.value = true;

                      cartController.serviceId.value = offerDetails.id;
                      await cartController.addToCart();
                      await cartController.getCartData();
                      cartController.isLoading.value = false;

                      Get.to(() => const MyCart());
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Center(
                      child:
                          cartController.isLoading.value
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                "Add item - ₹$price",
                                style: GoogleFonts.sen(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
                Obx(() {
                  if (foodCategory.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final offerDetails = foodCategory.foodDetail.value;

                  if (offerDetails == null || offerDetails.images.isEmpty) {
                    return const Center(
                      child: Text(
                        "No details found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(22.r),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            offerDetails.images.isNotEmpty
                                ? offerDetails.images[0].img
                                : "",
                          ), // Use a fallback image if the list is empty
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: const Padding(
                      //   padding: EdgeInsets.only(right: 30, bottom: 20),
                      //   child: CircleAvatar(
                      //     radius: 25,
                      //     child: Icon(
                      //       Icons.favorite_border,
                      //       color: Colors.white,
                      //       size: 30,
                      //     ),
                      //   ),
                      // ),
                    ),
                  );
                }),

                SizedBox(height: Get.height * 0.04),
                Obx(() {
                  final offerDetails = foodCategory.foodDetail.value;
                  return Container(
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
                        Text(
                          offerDetails!.city.name.toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  final offerDetails = foodCategory.foodDetail.value;
                  return Text(
                    offerDetails?.title ?? "",
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  );
                }),
                SizedBox(height: Get.height * 0.01),
                Obx(() {
                  final offerDetails = foodCategory.foodDetail.value;
                  return Text(
                    offerDetails?.description ??
                        '''Prosciutto e funghi is a pizza variety that is topped with tomato sauce.''',
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: const Color(0xff9D9D9D),
                    ),
                  );
                }),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  final offerDetails = foodCategory.foodDetail.value;
                  return Row(
                    children: [
                      const Icon(
                        Icons.star_border_purple500,
                        color: Color(0xffFFB71A),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${offerDetails?.rating ?? 4.7}",
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
                          const SizedBox(width: 5),
                          Text(
                            offerDetails?.totalTime ?? " Free",
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
                          const SizedBox(width: 5),
                          Text(
                            "${offerDetails!.timeInMin}",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  final offerDetails = foodCategory.foodDetail.value;
                  if (offerDetails?.size == null ||
                      offerDetails!.size.trim().isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Row(
                    children: [
                      Text(
                        "Size:",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Text(offerDetails!.size),
                      ),
                      // SizedBox(width: 15.w),
                      // CircleAvatar(
                      //   radius: 25,
                      //   backgroundColor: const Color(0xffB78E4F),
                      //   child: Text(
                      //     offerDetails.size,
                      //     style: GoogleFonts.sen(
                      //       fontWeight: FontWeight.w700,
                      //       fontSize: 14.sp,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 15.w),
                      //  CircleAvatar(
                      //   radius: 25,
                      //   backgroundColor: Colors.white,
                      //   child: Text(offerDetails.size),
                      // ),
                    ],
                  );
                }),
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
      ),
    );
  }
}

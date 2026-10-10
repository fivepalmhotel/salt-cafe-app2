import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/address_controller.dart';
import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/recent_searches_controller.dart';
import 'package:salt_cafe_app/controller/search_items_controller.dart';

import 'my_cart.dart';

class ItemSearch extends StatefulWidget {
  const ItemSearch({super.key});

  @override
  State<ItemSearch> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
  final ItemSearchController searchItemsController = Get.put(
    ItemSearchController(),
  );

  final RecentSearchesController recentSearchesController = Get.put(
    RecentSearchesController(),
  );
  final AddToCartController cartController = Get.put(AddToCartController());
  final AllCityController allCityController = Get.put(AllCityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 15.w, right: 15.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                      "Search",
                      style: GoogleFonts.sen(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        color: Colors.white,
                      ),
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
                          badgeColor: Color(0xff4B70F5),
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
                          child: Icon(Icons.shopping_bag, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        searchItemsController.getProductSearch(value);
                      }
                    },
                    controller: searchItemsController.searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      hintText: "Pizza",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchItemsController.searchController.clear();
                          searchItemsController.searchList.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  "Recent Keywords",
                  style: GoogleFonts.sen(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffEEA534),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                SizedBox(
                  height: 60.h,
                  child: Obx(() {
                    if (recentSearchesController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (recentSearchesController.recentSearches.isEmpty) {
                      return Center(
                        child: Text(
                          "No Recent Search Items",
                          style: GoogleFonts.sen(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: recentSearchesController.recentSearches.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final recentSearch =
                            recentSearchesController.recentSearches[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 46.h,
                            width: 102.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33.r),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Text(
                              recentSearch.searchQuery,
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  "Suggested Restaurants",
                  style: GoogleFonts.sen(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffEEA534),
                  ),
                ),
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allCityController.hotelList.length,
                    itemBuilder: (context, index) {
                      final item = allCityController.hotelList[index];
                      final cityImages = item.city;
                      final imageUrl = cityImages.image;
                      final addressArea = item.name;
                      final location = item.location;
                      final address = location.address;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child:
                                    imageUrl.isNotEmpty
                                        ? Image.network(
                                          imageUrl,
                                          height: 80.h,
                                          width: 70.w,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    height: 80.h,
                                                    width: 70.w,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                    ),
                                                  ),
                                        )
                                        : Container(
                                          height: 80.h,
                                          width: 70.w,
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image_not_supported,
                                          ),
                                        ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "$addressArea, ",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.sen(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          address,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.sen(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    cityImages.name,
                                    style: GoogleFonts.sen(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 6.h),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_border_purple500_outlined,
                                      color: Color(0xffFFB71A),
                                      size: 18,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      item.ratings.toStringAsFixed(1),
                                      style: GoogleFonts.sen(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(color: Colors.white),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

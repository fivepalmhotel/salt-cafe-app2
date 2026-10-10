import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/food_category_controller.dart';
import 'package:salt_cafe_app/controller/search_items_controller.dart';
import 'package:salt_cafe_app/order_online/popular_pizza.dart';

import 'my_cart.dart';

class FoodCategory extends StatelessWidget {
  FoodCategory({super.key});

  final AllFoodCategory foodCategory = Get.put(AllFoodCategory());

  final AddToCartController cartController = Get.put(AddToCartController());
  final ItemSearchController searchItemsController = Get.put(
    ItemSearchController(),
  );

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back_ios, size: 10),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "Food Categories",
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
             searchItemsController.searchText.value = value.trim();
  if (value.trim().isNotEmpty) {
    searchItemsController.getProductSearch(value.trim());
  } else {
    searchItemsController.searchList.clear();
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
              hintText: "Search dishes, restaurants",
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

Obx(() {
  final isSearching = searchItemsController.searchText.value.isNotEmpty;

  // Show Search Results when typing
  if (isSearching) {
    if (searchItemsController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (searchItemsController.errorMessage.value.isNotEmpty) {
      return Center(
        child: Text(
          searchItemsController.errorMessage.value,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (searchItemsController.searchList.isEmpty) {
      return const Center(
        child: Text(
          "No product found",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchItemsController.searchList.length,
        itemBuilder: (context, index) {
          final item = searchItemsController.searchList[index];
          if (item == null) return const SizedBox.shrink();
          final imageUrl = item.images.isNotEmpty ? item.images.first.img : '';

          return Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 100,
                          width: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 100,
                            width: 70,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 70,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                ),
                title: Text(
                  item.title,
                  style: GoogleFonts.sen(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xffFFB71A)),
                    SizedBox(width: 4.w),
                    Text(
                      "${item.rating}",
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white),
            ],
          );
        },
      );
    }
  }

  // Show Food Category Grid when not searching
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

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: foodCategory.foodList.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 3,
      crossAxisSpacing: 10,
      childAspectRatio: 3 / 5,
    ),
    itemBuilder: (context, index) {
      final foodImage = foodCategory.foodList[index];

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: GestureDetector(
              onTap: () async {
                if (foodImage.id.isEmpty) {
                  Get.snackbar("Error", "The food category ID is missing.");
                  return;
                }

                bool isSuccess =
                    await foodCategory.getsubCategory(foodImage.id);

                if (isSuccess) {
                  Get.to(() => PopularPizza(title: foodImage.name));
                }
              },
              child: Image.network(
                foodImage.image.toString(),
                height: 120,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            foodImage.name,
            style: GoogleFonts.sen(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ],
      );
    },
  );
})



              ],
            ),
          ),
        ),
      ),
    );
  }
}

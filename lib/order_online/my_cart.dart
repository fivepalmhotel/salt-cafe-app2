import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/address_controller.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/payment_gatway_controller.dart';
import 'package:salt_cafe_app/order_online/razorpay_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Menu/payment.dart';
import '../restaurent/nav_baar.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final AddToCartController cartController = Get.put(AddToCartController());
  final AddressController addressController = Get.put(AddressController());
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Obx(() {
        final getData = cartController.getCart.value;
        final hasServices = getData != null && getData.services.isNotEmpty;
        final totalPrice = getData?.totalAmount;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xffEEA534),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "PAY USING",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "PhonePe",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "UPI > ",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        final paymentController = Get.put(PaymentController());

                        bool success = await paymentController.checkoutCart();
                        if (success) {
                          // Navigate to payment screen
                          Get.to(() => PaymentScreen());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55.h,
                        width: 209,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.black,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "₹ ${totalPrice ?? 0.0}",

                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "TOTAL",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Place Order",
                                  style: GoogleFonts.sen(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back_ios, size: 15),
                          ),
                        ),
                        Obx(() {
                          final addressList = addressController.addressList;

                          if (addressList.isEmpty) {
                            return Text(
                              "No address available",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.white,
                              ),
                            );
                          }

                          final address = addressList[0]; // Safe to access now

                          return Text(
                            " ${address?.street}, ${address?.city}, ${address?.houseFlat}",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          );
                        }),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const BottomNavBar(initialIndex: 1),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            height: 40,
                            width: 80,
                            child: Text(
                              "Add +",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      final cartData = cartController.getCart.value;
                      print("Cart Data: $cartData");
                      print(
                        "Cart Data after API call: ${cartController.getCart.value}",
                      );

                      if (cartData == null || cartData.services.isEmpty) {
                        return const Center(
                          child: Text(
                            "Your cart is empty",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: cartData.services.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = cartData.services[index];
                          final service = item.serviceId;
                          print("serviceId: $service");

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        service.images.isNotEmpty
                                            ? service.images[0].img
                                            : '',
                                        fit: BoxFit.cover,
                                        height: 80.h,
                                        width: 80.w,
                                        errorBuilder:
                                            (_, __, ___) =>
                                                const Icon(Icons.broken_image),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),

                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            service.title ?? "Unknown",
                                            style: GoogleFonts.sen(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            service.description ??
                                                "No description",
                                            style: GoogleFonts.sen(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),

                                          // Price
                                          Text(
                                            "₹ ${service.discountPrice.toStringAsFixed(2)}",
                                            style: GoogleFonts.sen(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                            ),
                                          ),

                                          // Quantity Row
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15,
                                            ),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // Decrease
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (item.quantity > 1) {
                                                          item.quantity =
                                                              item.quantity -
                                                              1; // Local update
                                                          cartController
                                                                  .serviceId
                                                                  .value =
                                                              service.id;
                                                          cartController
                                                                  .quantity
                                                                  .value =
                                                              item.quantity;
                                                          cartController
                                                              .updateQuantity();
                                                        }
                                                      },

                                                      child: const CircleAvatar(
                                                        radius: 14,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),

                                                    // Quantity display
                                                    Text(
                                                      '${item.quantity}',
                                                      style: GoogleFonts.sen(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),

                                                    SizedBox(width: 10.w),

                                                    // Increase
                                                    GestureDetector(
                                                      onTap: () {
                                                        item.quantity =
                                                            item.quantity +
                                                            1; // Local update
                                                        cartController
                                                            .serviceId
                                                            .value = service.id;
                                                        cartController
                                                                .quantity
                                                                .value =
                                                            item.quantity;
                                                        cartController
                                                            .updateQuantity();
                                                      },

                                                      child: const CircleAvatar(
                                                        radius: 14,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                // Dashed divider
                                Dash(
                                  direction: Axis.horizontal,
                                  length: Get.width * 0.9,
                                  dashLength: 5,
                                  dashThickness: 1,
                                  dashColor: Colors.white54,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // // Quantity Row
  //                                         Padding(
  //                                           padding: const EdgeInsets.only(
  //                                             right: 15,
  //                                           ),
  //                                           child: Row(
  //                                             children: [
  //                                               const Spacer(),
  //                                               Row(
  //                                                 mainAxisSize:
  //                                                     MainAxisSize.min,
  //                                                 children: [
  //                                                   // Decrease
  //                                                   GestureDetector(
  //                                                     onTap: () {
  //                                                       final serviceIdFromCart =
  //                                                           service.id;
  //                                                       final cartQty =
  //                                                           item.quantity;

  //                                                       cartController
  //                                                               .serviceId
  //                                                               .value =
  //                                                           serviceIdFromCart;
  //                                                       cartController
  //                                                               .quantity
  //                                                               .value =
  //                                                           cartQty - 1;

  //                                                       cartController
  //                                                           .updateQuantity();
  //                                                     },
  //                                                     child: const CircleAvatar(
  //                                                       radius: 14,
  //                                                       backgroundColor:
  //                                                           Colors.white,
  //                                                       child: Icon(
  //                                                         Icons.remove,
  //                                                         size: 16,
  //                                                         color: Colors.black,
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                   SizedBox(width: 10.w),

  //                                                   // Quantity display
  //                                                   Text(
  //                                                     '${item.quantity}',
  //                                                     style: GoogleFonts.sen(
  //                                                       fontWeight:
  //                                                           FontWeight.w600,
  //                                                       fontSize: 16.sp,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),

  //                                                   SizedBox(width: 10.w),

  //                                                   // Increase
  //                                                   GestureDetector(
  //                                                     onTap: () {
  //                                                       final serviceIdFromCart =
  //                                                           service.id;
  //                                                       final cartQty =
  //                                                           item.quantity;

  //                                                       cartController
  //                                                               .serviceId
  //                                                               .value =
  //                                                           serviceIdFromCart;
  //                                                       cartController
  //                                                               .quantity
  //                                                               .value =
  //                                                           cartQty + 1;

  //                                                       cartController
  //                                                           .updateQuantity();
  //                                                     },
  //                                                     child: const CircleAvatar(
  //                                                       radius: 14,
  //                                                       backgroundColor:
  //                                                           Colors.white,
  //                                                       child: Icon(
  //                                                         Icons.add,
  //                                                         size: 16,
  //                                                         color: Colors.black,
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
}

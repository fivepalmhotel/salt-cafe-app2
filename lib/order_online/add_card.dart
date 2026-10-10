import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/payment.dart';
import 'package:salt_cafe_app/controller/card_detail_controller.dart';
import 'package:salt_cafe_app/order_online/payment_method.dart';

import '../Menu/payment_mth.dart';

class AddCard extends StatelessWidget {
  final CardAddController cardController = Get.put(CardAddController());

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/themeimg.jpeg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Obx(() {
  final cardData = cardController.cardDetails.isNotEmpty
      ? cardController.cardDetails.first
      : null;

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 50.h,
      horizontal: 15.w,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const PaymentMethod());
              },
              child: const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, size: 15),
              ),
            ),
            SizedBox(width: 13.w),
            Text(
              "Add Card",
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.04),

        /// CARD HOLDER NAME
        Text(
          "CARD HOLDER NAME",
          style: GoogleFonts.sen(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        TextFormField(
          controller: cardController.nameController,
          decoration: InputDecoration(
            hintText: cardData?.cardHolderName ?? "Enter cardholder name",
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
        ),

        SizedBox(height: Get.height * 0.04),

        /// CARD NUMBER
        Text(
          "CARD NUMBER",
          style: GoogleFonts.sen(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        TextFormField(
          controller: cardController.cardController,
          decoration: InputDecoration(
            hintText: cardData?.cardNumber ?? "Enter card number",
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
        ),

        SizedBox(height: Get.height * 0.04),

        /// EXPIRY AND CVC
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EXPIRE DATE",
              style: GoogleFonts.sen(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120),
              child: Text(
                "CVC",
                style: GoogleFonts.sen(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: cardController.expaireDateController,
                decoration: InputDecoration(
                  hintText: cardData?.expiryDate ?? "MM/YY",
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
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                controller: cardController.cvcController,
                decoration: InputDecoration(
                  hintText: cardData?.cvv ?? "CVC",
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
              ),
            ),
          ],
        ),

        SizedBox(height: Get.height * 0.4),

        /// Button
        Obx(() {
          return GestureDetector(
            onTap: () async {
              if (!cardController.isLoading.value) {
                await cardController.addCard();
                Get.to(() => const PaymentMaster());
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
              child: cardController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      "ADD & MAKE PAYMENT",
                      style: GoogleFonts.sen(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
            ),
          );
        }),
      ],
    ),
  );
}),

          ),
        ],
      ),
    );
  }
}

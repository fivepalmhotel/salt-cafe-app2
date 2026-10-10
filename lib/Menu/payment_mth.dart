import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/card_detail_controller.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';

import '../order_online/add_card.dart';

class PaymentMth extends StatefulWidget {
  const PaymentMth({super.key});

  @override
  State<PaymentMth> createState() => _PaymentMthState();
}

class _PaymentMthState extends State<PaymentMth> {
  final CardAddController cardController = Get.put(CardAddController());

  final List<Map<String, dynamic>> paymentMethod = [
    {"image": "assets/images/cash.png", "title": "Cash"},
    {"image": "assets/images/vsa.png", "title": "Visa"},
    {"image": "assets/images/Mastercard.png", "title": "Mastercard"},
    {"image": "assets/images/paypal.png", "title": "Paypal"},
  ];
  int selectedIndex = 1;
  final AddToCartController cartController = Get.put(AddToCartController());
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
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back_ios, size: 15),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.03),
                      Text(
                        "Payment",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 130.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethod.length,
                      itemBuilder: (context, index) {
                        final item = paymentMethod[index];
                        final isSelected = selectedIndex == index;
                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color:
                                              isSelected
                                                  ? Colors.transparent
                                                  : Colors.white,
                                          border:
                                              isSelected
                                                  ? Border.all(
                                                    color: const Color(
                                                      0xffFF7622,
                                                    ),
                                                    width: 2,
                                                  )
                                                  : Border.all(
                                                    color: Colors.transparent,
                                                  ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: Image.asset(
                                            item['image']!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            shape: BoxShape.circle,
                                            color: const Color(0xffFF7622),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                item['title'] ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (cardController.cardDetails.isEmpty) {
                      return Center(
                        child: Text(
                          "No Card Data Available",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: cardController.cardDetails.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cardData = cardController.cardDetails[index];

                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 10.w,
                          ),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Edit Icon
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      await cardController.updateCard(
                                        cardData.id,
                                      );

                                      Get.to(() => AddCard());

                                      // await cardController.deleteCard(
                                      //   cardData.id,
                                      // );
                                      // Get.to(() => AddCard());

                                      print(
                                        'Edit card: ${cardData.cardNumber}',
                                      );
                                    },
                                  ),
                                  // Delete Icon
                                  Obx(() {
                                    bool isDeletingThisCard =
                                        cardController.deletingCardId.value ==
                                        cardData.id;

                                    return IconButton(
                                      icon:
                                          isDeletingThisCard
                                              ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.red,
                                                    ),
                                              )
                                              : const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                      onPressed: () async {
                                        if (!isDeletingThisCard) {
                                          bool isDeleted = await cardController
                                              .deleteCard(cardData.id);
                                          if (isDeleted) {
                                            cardController.cardDetails.removeAt(
                                              index,
                                            );
                                            cardController.cardDetails
                                                .refresh();
                                          }
                                        }
                                      },
                                    );
                                  }),
                                ],
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/images/crd.png",
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Card Holder Name: ",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xff32343E,
                                        ), // Label color
                                      ),
                                    ),
                                    TextSpan(
                                      text: cardData.cardHolderName ?? "-",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xffEEA534,
                                        ), // Value color (different)
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 4.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Card Number: ",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.sp,
                                        color: const Color(0xff32343E),
                                      ),
                                    ),
                                    TextSpan(
                                      text: cardData.cardNumber ?? "-",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: const Color(0xffEEA534),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "CVC: ",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xff32343E,
                                        ), // Label color
                                      ),
                                    ),
                                    TextSpan(
                                      text: cardData.cvv ?? "-",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xffEEA534,
                                        ), // Value color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Expiry Date: ",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xff32343E,
                                        ), // Label color
                                      ),
                                    ),
                                    TextSpan(
                                      text: cardData.expiryDate ?? "-",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: const Color(
                                          0xffEEA534,
                                        ), // Value color
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10.h),
                              Center(
                                child: Text(
                                  'You can add a Mastercard and save it for later',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sen(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp,
                                    color: const Color(0xff32343E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),

                  SizedBox(height: Get.height * 0.03),
                  InkWell(
                    onTap: () {
                      Get.to(() => AddCard());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 350.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add, color: Color(0xffEEA534)),
                            Text(
                              "ADD NEW",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffEEA534),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.2),
                  Row(
                    children: [
                      Text(
                        "Total: ",
                        style: GoogleFonts.sen(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Obx(() {
                        final getData = cartController.getCart.value;
                        //final hasServices = getData != null && getData.services.isNotEmpty;
                        final totalPrice = getData?.totalAmount;

                        return Text(
                          "₹ $totalPrice",
                          style: GoogleFonts.sen(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 345.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xffEEA534),
                      ),
                      child: Text(
                        "PAY & CONFIRM",
                        style: GoogleFonts.sen(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

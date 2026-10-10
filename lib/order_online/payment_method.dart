import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/card_detail_controller.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/order_online/pay_confirm.dart';

import 'add_card.dart';

class PaymentMaster extends StatefulWidget {
  const PaymentMaster({super.key});

  @override
  State<PaymentMaster> createState() => _PaymentMasterState();
}

class _PaymentMasterState extends State<PaymentMaster> {
  final List<Map<String, String>> paymentMethod = [
    {"image": "assets/images/payphone.png", "title": "PhonePe UPI"},
    {"image": "assets/images/gpay.png", "title": "Google Pay UPI"},
    {"image": "assets/images/ptm.png", "title": "Paytm UPI"}
  ];
 final AddToCartController cartController = Get.put(AddToCartController());
 final CardAddController cardController = Get.put(CardAddController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 45.h, left: 15.w, right: 15.w),
          child: SingleChildScrollView(
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
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Obx(() {
            final getData = cartController.getCart.value;
             final totalPrice = getData?.totalAmount;
            return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Bill Total: ",
                            style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          TextSpan(
                            text: "₹ $totalPrice",
                            style: GoogleFonts.sen(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
              
                        ],
                      ),
                    );
            
            
                    })
                  ],
                ),
                //                        Obx((){
              // final getData = cartController.getCart.value;
              //       //final hasServices = getData != null && getData.services.isNotEmpty;
              //       final totalPrice = getData?.totalAmount;
            
              //                       return Text(
              //                       "₹ $totalPrice",
              //                       style: GoogleFonts.sen(
              //                         fontSize: 30.sp,
              //                         fontWeight: FontWeight.w700,
              //                         color: Colors.white,
              //                       ),
              //                     );
              //                     })
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Cards",
                  style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
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
            
                SizedBox(
                  height: Get.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>  AddCard());
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add credit or debit cards",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff32343E),
                            ),
                          ),
                          const Icon(Icons.add_circle_outline)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Text(
                  "Pay by any UPI APP",
                  style: GoogleFonts.sen(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54),
                ),
                ListView.builder(
                  itemCount: paymentMethod.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (contxet, index) {
                    final pay = paymentMethod[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            pay['image']!,
                            height: 40,
                            width: 40,
                          ),
                          title: Text(
                            pay['title']!,
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff32343E),
                              fontSize: 16.sp,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const PayConfirm());
                  },
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

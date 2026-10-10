import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_dash/flutter_dash.dart';

class MenuCart extends StatefulWidget {
  const MenuCart({super.key});

  @override
  State<MenuCart> createState() => _MenuCartState();
}

class _MenuCartState extends State<MenuCart> {
  final List<Map<String, dynamic>> cartItem = [
    {
      "image": "assets/images/pizza1.png",
      "title": "pizza calzone",
      "subtitle": "european",
      "price": "₹ 164",
      "size": '14"',
      "quantity": 2,
    },
    {
      "image": "assets/images/burgur.png",
      "title": "pizza calzone",
      "subtitle": "european",
      "price": "₹ 164",
      "size": '14"',
      "quantity": 2,
    },
    {
      "image": "assets/images/pizza1.png",
      "title": "pizza calzone",
      "subtitle": "european",
      "price": "₹ 164",
      "size": '14"',
      "quantity": 2,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/themeimg.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(children: [
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
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                        ),
                      ),
                      Text(
                        "Delivery at Home | Plot no. 104...",
                        style: GoogleFonts.sen(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp,
                            color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: cartItem.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final items = cartItem[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    items['image'],
                                    fit: BoxFit.cover,
                                    height: 80.h,
                                    width: 80.w,
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
                                        items['title'],
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        items['subtitle'],
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        "₹ ${items['price']}",
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              items['size'],
                                              style: GoogleFonts.sen(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Spacer(),
                                            const CircleAvatar(
                                              radius: 12,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              '${items['quantity']}',
                                              style: GoogleFonts.sen(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            const CircleAvatar(
                                              radius: 12,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // SizedBox(height: 10.h),
                                      // Quantity Selector
                                      // Row(
                                      //   children: [
                                      //     IconButton(
                                      //       onPressed: () {
                                      //         if (items['quantity'] > 1) {
                                      //           setState(() {
                                      //             cartItem[index]['quantity']--;
                                      //           });
                                      //         }
                                      //       },
                                      //       icon: const Icon(Icons.remove, color: Colors.white),
                                      //       constraints: const BoxConstraints(),
                                      //       padding: EdgeInsets.zero,
                                      //     ),
                                      //     Text(
                                      //       '${items['quantity']}',
                                      //       style: GoogleFonts.sen(
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 14.sp,
                                      //         color: Colors.white,
                                      //       ),
                                      //     ),
                                      //     IconButton(
                                      //       onPressed: () {
                                      //         setState(() {
                                      //           cartItem[index]['quantity']++;
                                      //         });
                                      //       },
                                      //       icon: const Icon(Icons.add, color: Colors.white),
                                      //       constraints: const BoxConstraints(),
                                      //       padding: EdgeInsets.zero,
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
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
                  ),
                  SizedBox(
                    height: Get.height*0.4,
                  ),
                ],
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Color(0xffEEA534),
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(20.r),
              //         topRight: Radius.circular(20.r),
              //       ),
              //     ),
              //     height: 100,
              //     width: 300,
              //     child: Padding(
              //       padding: EdgeInsets.only(top: 15.h),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: [
              //               Column(
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 children: [
              //                   Text(
              //                     "PAY USING",
              //                     style: GoogleFonts.sen(
              //                       fontWeight: FontWeight.w400,
              //                       fontSize: 14.sp,
              //                       color: Colors.black54,
              //                     ),
              //                   ),
              //                   Text(
              //                     "PhonePe",
              //                     style: GoogleFonts.sen(
              //                       fontWeight: FontWeight.w700,
              //                       fontSize: 16.sp,
              //                       color: Colors.black,
              //                     ),
              //                   ),
              //                   Text(
              //                     "UPI > ",
              //                     style: GoogleFonts.sen(
              //                       fontWeight: FontWeight.w700,
              //                       fontSize: 16.sp,
              //                       color: Colors.black,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               InkWell(
              //                 onTap: () {
              //                   Get.to(() => const PaymentMethod());
              //                 },
              //                 child: Container(
              //                   alignment: Alignment.center,
              //                   height: 55.h,
              //                   width: 209,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(8.r),
              //                     color: Colors.black,
              //                   ),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                         children: [
              //                           Column(
              //                             children: [
              //                               Text(
              //                                 "₹ 365",
              //                                 style: GoogleFonts.sen(
              //                                   fontWeight: FontWeight.w400,
              //                                   fontSize: 14.sp,
              //                                   color: Colors.white,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 "TOTAL",
              //                                 style: GoogleFonts.sen(
              //                                   fontWeight: FontWeight.w400,
              //                                   fontSize: 14.sp,
              //                                   color: Colors.white,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                           Text(
              //                             "place order",
              //                             style: GoogleFonts.sen(
              //                               fontWeight: FontWeight.w700,
              //                               fontSize: 18.sp,
              //                               color: Colors.white,
              //                             ),
              //                           )
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          ),
        ),
      ],),
    );
  }
}

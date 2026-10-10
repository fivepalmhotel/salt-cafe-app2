// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'burger_food_details.dart';
// import 'item_search.dart';

// class PopularBurgers extends StatefulWidget {
//   const PopularBurgers({super.key});

//   @override
//   State<PopularBurgers> createState() => _PopularBurgersState();
// }

// class _PopularBurgersState extends State<PopularBurgers> {
//   final List<String> dropdownItem = [
//     "Pizza",
//     "Burger",
//     "Biryani",
//     "Rolls",
//     "Chicken",
//     "Hot soup",
//     "Tikka",
//   ];
//   String? selectedValue = "Burger";

//   final List<Map<String, dynamic>> weeklySpecial = [
//     {
//       "image": "assets/images/bristo.png",
//       "title": "Prawn mix ",
//       "subtitle": "Noida",
//       "price": "₹500",
//     },
//     {
//       "image": "assets/images/burgur1.png",
//       "title": "BBQ",
//       "subtitle": "Noida",
//       "price": "₹750",
//     },
//     {
//       "image": "assets/images/burgur2.png",
//       "title": "Prawn mix ",
//       "subtitle": "Noida",
//       "price": "₹500",
//     },
//     {
//       "image": "assets/images/burgur3.png",
//       "title": "BBQ",
//       "subtitle": "Noida",
//       "price": "₹750",
//     },
//     {
//       "image": "assets/images/burgur2.png",
//       "title": "Prawn mix ",
//       "subtitle": "Noida",
//       "price": "₹500",
//     },
//     {
//       "image": "assets/images/burgur3.png",
//       "title": "BBQ",
//       "subtitle": "Noida",
//       "price": "₹750",
//     },
//     {
//       "image": "assets/images/burgur2.png",
//       "title": "Prawn mix ",
//       "subtitle": "Noida",
//       "price": "₹500",
//     },
//     {
//       "image": "assets/images/burgur1.png",
//       "title": "BBQ",
//       "subtitle": "Noida",
//       "price": "₹750",
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/themeimg.jpeg"),
//             fit: BoxFit.cover,
//           ),
//         ),

//         child:
//         // Positioned.fill(
//         //   child: Image.asset(
//         //     "assets/images/themeimg.jpeg",
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),
//         SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.arrow_back_ios, size: 10),
//                       ),
//                     ),
//                     SizedBox(width: 7.w),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         style: const TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: const BorderSide(
//                               color: Colors.white,
//                               width: 2,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: const BorderSide(
//                               color: Colors.white,
//                               width: 2,
//                             ),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 10,
//                           ),
//                         ),
//                         value: selectedValue,
//                         icon: const Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.white,
//                           size: 25,
//                         ),
//                         hint: Text(
//                           "Select an option",
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color:
//                                 selectedValue != null
//                                     ? Colors.black
//                                     : Colors.black,
//                           ),
//                         ),
//                         items:
//                             dropdownItem.map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(
//                                   value,
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color:
//                                         selectedValue == value
//                                             ? Colors.white
//                                             : Colors.black,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedValue =
//                                 newValue; // Updating the selected value with setState
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 35),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.to(() => const ItemSearch());
//                           },
//                           child: const CircleAvatar(
//                             backgroundColor: Color(0xffEEA534),
//                             radius: 20,
//                             child: Icon(Icons.search, color: Colors.white),
//                           ),
//                         ),
//                         SizedBox(width: 15.w),
//                         InkWell(
//                           onTap: () {
//                             Get.dialog(
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 20,
//                                 ),
//                                 child: Dialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.r),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 15.w,
//                                       vertical: 10.h,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               "Filter your search",
//                                               style: GoogleFonts.sen(
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: const Color(0xff181C2E),
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 Get.back();
//                                               },
//                                               child: CircleAvatar(
//                                                 backgroundColor:
//                                                     Colors.grey.shade200,
//                                                 child: const Icon(Icons.close),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "Offers",
//                                           style: GoogleFonts.sen(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w400,
//                                             color: const Color(0xff181C2E),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.02),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "Delivery",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "Pick Up",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "Offer",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: Get.height * 0.02),
//                                         Container(
//                                           alignment: Alignment.center,
//                                           height: 46.h,
//                                           width: 200.w,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               33.r,
//                                             ),
//                                             border: Border.all(
//                                               color: Colors.grey,
//                                               width: 2,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             "Online payment available",
//                                             style: GoogleFonts.sen(
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.02),
//                                         Text(
//                                           "Deliver Time",
//                                           style: GoogleFonts.sen(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w400,
//                                             color: const Color(0xff181C2E),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.01),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 color: const Color(0xffB78E4F),
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "10-15 min",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "20 min",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 46.h,
//                                               width: 85.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(33.r),
//                                                 border: Border.all(
//                                                   color: Colors.grey,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "30 min",
//                                                 style: GoogleFonts.sen(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: Get.height * 0.01),
//                                         Text(
//                                           "Pricing",
//                                           style: GoogleFonts.sen(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w400,
//                                             color: const Color(0xff181C2E),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.02),
//                                         Row(
//                                           children: [
//                                             const CircleAvatar(
//                                               backgroundColor: Colors.white,
//                                               radius: 20,
//                                               child: Text("\$"),
//                                             ),
//                                             SizedBox(width: 8.w),
//                                             const CircleAvatar(
//                                               backgroundColor: Colors.white,
//                                               radius: 20,
//                                               child: Text("\$\$\$"),
//                                             ),
//                                             SizedBox(width: 8.w),
//                                             const CircleAvatar(
//                                               backgroundColor: Color(
//                                                 0xffB78E4F,
//                                               ),
//                                               radius: 20,
//                                               child: Text("\$"),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: Get.height * 0.02),
//                                         Text(
//                                           "Rating",
//                                           style: GoogleFonts.sen(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w400,
//                                             color: const Color(0xff181C2E),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.01),
//                                         Row(
//                                           children: List.generate(
//                                             4,
//                                             (index) => const Padding(
//                                               padding: EdgeInsets.all(8.0),
//                                               child: Icon(
//                                                 Icons.star,
//                                                 color: Color(0xffB78E4F),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: Get.height * 0.05),
//                                         InkWell(
//                                           onTap: () {
//                                             Get.back();
//                                           },
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             width: 345.w,
//                                             height: 55.h,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(12.r),
//                                               color: const Color(0xffEEA534),
//                                             ),
//                                             child: Text(
//                                               "Apply",
//                                               style: GoogleFonts.sen(
//                                                 fontWeight: FontWeight.w700,
//                                                 color: Colors.black,
//                                                 fontSize: 16.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 20,
//                             child: Image.asset("assets/images/menu_icon.png"),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: Get.height * 0.03),
//                 Text(
//                   "Popular Burgers",
//                   style: GoogleFonts.sen(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//                 GridView.builder(
//                   itemCount: weeklySpecial.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 3 / 4,
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = weeklySpecial[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 12.0),
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           // Card Container
//                           Container(
//                             width: 180,
//                             height: 180,
//                             margin: const EdgeInsets.only(
//                               top: 60,
//                             ), // Push down for overlap effect
//                             decoration: BoxDecoration(
//                               color: const Color(0xff070707),
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(
//                                 color: const Color(0xff474747),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 58, left: 15),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       item["title"],
//                                       style: GoogleFonts.poppins(
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   // Title
//                                   Text(
//                                     item['subtitle'],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                       color: const Color(0xff636363),
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   // Price
//                                   Padding(
//                                     padding: EdgeInsets.only(right: 16.w),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           item['price'],
//                                           style: GoogleFonts.poppins(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 16,
//                                             color: const Color(0xff03AD74),
//                                           ),
//                                         ),
//                                         const CircleAvatar(
//                                           backgroundColor: Color(0xffEEA534),
//                                           radius: 15,
//                                           child: Icon(
//                                             Icons.add,
//                                             color: Colors.white,
//                                             size: 20,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Image on Top
//                           Positioned(
//                             top: 0, // Overlap effect
//                             left: 9, // Center the image on the card
//                             right: 12,
//                             child: InkWell(
//                               onTap: () {
//                                 Get.to(() => const FoodDetailsBurger());
//                               },
//                               child: CircleAvatar(
//                                 radius: 55,
//                                 backgroundImage: AssetImage(item['image']),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

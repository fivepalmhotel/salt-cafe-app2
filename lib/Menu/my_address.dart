import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/delet_address_widget.dart';
import 'package:salt_cafe_app/controller/address_controller.dart';
import 'package:salt_cafe_app/controller/menu_profile_controller.dart';
import 'package:salt_cafe_app/models/profile_model.dart';

import 'edit_address.dart';

class MyAddress extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());
  final ProfileController profileController = Get.put(ProfileController());

  MyAddress({super.key});

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
              padding: EdgeInsets.only(top: 50.h, left: 10, right: 10),
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
                          child: Icon(Icons.arrow_back_ios, size: 15),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "My Address",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  //assets/images/profile_pic.jpeg
                  SizedBox(height: Get.height * 0.04),
                  Obx(() {
                    final userData = profileController.userProfile.value?.data;

                    if (userData == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      ); // Display loading indicator when no data
                    }

                    final List<DummyImage> dummyImage =
                        userData.dummyImage ?? [];

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            dummyImage.isNotEmpty
                                ? NetworkImage(
                                  dummyImage.first.img ?? '',
                                ) // Fallback to empty string if img is null
                                : const AssetImage('assets/images/placeholder.png')
                                    as ImageProvider,
                      ),
                      title: Text(
                        userData.fullName ??
                            "User Name", // Assuming you want full name
                        style: GoogleFonts.sen(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffEEA534),
                        ),
                      ),
                      subtitle: Text(
                        userData.bio ?? "No bio available",
                        style: GoogleFonts.sen(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: Get.height * 0.04),

                  Obx(() {
                    if (addressController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (addressController.addressList.isEmpty) {
                      return const Center(child: Text('No addresses found.',style: TextStyle(color: Colors.white),));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addressController.addressList.length,
                      itemBuilder: (context, index) {
                        final addressData =
                            addressController.addressList[index];

                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 10.h,
                          ), // Space between cards
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      addressData!
                                          .houseType, // Show address type
                                      style: GoogleFonts.sen(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff32343E),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        await addressController.updateAddress(
                                          addressData.id,
                                        );
                                        Get.to(
                                          () => EditAddress(),

                                          transition: Transition.downToUp,
                                          duration: const Duration(milliseconds: 500),
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/images/edit icon.png",
                                        fit: BoxFit.cover,
                                        height: 20.h,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),

                                    GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          DeleteAddressDialog(
                                            onYesTap: () async {
                                              Get.back();
                                              await addressController
                                                  .deleteAddress(
                                                    addressData.id,
                                                  );

                                              print("Address deleted ✅");
                                            },
                                            onNoTap: () {
                                              Get.back(); // Just close dialog
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/images/Delete icon.png",
                                        fit: BoxFit.cover,
                                        height: 20.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                //horizontalTitleGap: 0,
                                //contentPadding: EdgeInsets.zero,
                                minLeadingWidth: 0,
                                minTileHeight: 0,

                                leading: Image.asset(
                                  "assets/images/homee.png",
                                  fit: BoxFit.cover,
                                  height: 24.h,
                                ),
                                title: Text(
                                  "${addressData.houseFlat}, ${addressData.street}",
                                  style: GoogleFonts.sen(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                subtitle: Text(
                                  "${addressData.city}, ${addressData.pincode}",
                                  style: GoogleFonts.sen(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),

                  SizedBox(height: Get.height * 0.2),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EditAddress());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xffEEA534),
                      ),
                      child: Text(
                        "Add new address",
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//  Container(
//                     height: 110.h,
//                     width: 350.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.r),
//                       color: Colors.white,
//                     ),
//                     child: Obx(() {
//                       if (addressController.isLoading.value) {
//                         return Center(child: CircularProgressIndicator());
//                       }

//                       if (addressController.addressList.isEmpty) {
//                         return Center(child: Text('No addresses found.'));
//                       }
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: addressController.addressList.length,
//                         itemBuilder: (context, index) {
//                           final addressData =
//                               addressController.addressList[index];

//                           return Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 40.w,
                                  
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "Home",
//                                       style: GoogleFonts.sen(
//                                         fontSize: 16.sp,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff32343E),
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     InkWell(
//                                       onTap: () {
//                                         Get.to(
//                                           () => EditAddress(),
//                                           transition: Transition.downToUp,
//                                           duration: const Duration(
//                                             milliseconds: 500,
//                                           ),
//                                         );
//                                       },
//                                       child: Image.asset(
//                                         "assets/images/edit icon.png",
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     SizedBox(width: 20.w),
//                                     InkWell(
//                                       onTap: () {
//                                         Get.dialog(
//                                           Dialog(
//                                             insetPadding:
//                                                 const EdgeInsets.symmetric(
//                                                   vertical: 210,
//                                                   horizontal: 20,
//                                                 ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     vertical: 20,
//                                                   ),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   RichText(
//                                                     textAlign: TextAlign.center,
//                                                     text: TextSpan(
//                                                       children: [
//                                                         TextSpan(
//                                                           text:
//                                                               "Do you really want \nto delete your \naccount? ",
//                                                           style: GoogleFonts.sen(
//                                                             fontSize: 24.sp,
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                             color: const Color(
//                                                               0xff181C2E,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         TextSpan(
//                                                           text: "🥺",
//                                                           style:
//                                                               GoogleFonts.notoColorEmoji(
//                                                                 fontSize: 18,
//                                                               ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceEvenly,
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Get.back();
//                                                           },
//                                                           child: Container(
//                                                             alignment:
//                                                                 Alignment
//                                                                     .center,
//                                                             height: 33.h,
//                                                             width: 144.w,
//                                                             decoration: BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     10.r,
//                                                                   ),
//                                                               border: Border.all(
//                                                                 color:
//                                                                     const Color(
//                                                                       0xffEEA534,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                             child: Text(
//                                                               "Yes",
//                                                               style: GoogleFonts.sen(
//                                                                 fontSize: 16.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color:
//                                                                     const Color(
//                                                                       0xffEEA534,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Get.back();
//                                                           },
//                                                           child: Container(
//                                                             alignment:
//                                                                 Alignment
//                                                                     .center,
//                                                             height: 33.h,
//                                                             width: 144.w,
//                                                             decoration: BoxDecoration(
//                                                               color:
//                                                                   const Color(
//                                                                     0xffEEA534,
//                                                                   ),
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     10.r,
//                                                                   ),
//                                                             ),
//                                                             child: Text(
//                                                               "No",
//                                                               style: GoogleFonts.sen(
//                                                                 fontSize: 16.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color:
//                                                                     Colors
//                                                                         .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       child: Image.asset(
//                                         "assets/images/Delete icon.png",
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ListTile(
//                                 leading: Image.asset(
//                                   "assets/images/homee.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                                 title: Text(
//                                   textAlign: TextAlign.start,
//                                   "${addressData.houseFlat}/${addressData.city}",
//                                   style: GoogleFonts.sen(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
                               
//                             ],
//                           );
//                         },
//                       );
//                     }),
//                   ),
                  
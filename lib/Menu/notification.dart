import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/rating.dart';
import 'package:salt_cafe_app/controller/notification_controller.dart'; // Make sure the path is correct

class MenuNotification extends StatefulWidget {
  const MenuNotification({super.key});

  @override
  State<MenuNotification> createState() => _MenuNotificationState();
}

class _MenuNotificationState extends State<MenuNotification> {
  final AllNotificationController notificationController = Get.put(AllNotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.getAllNotificationList();
  }

  // Helper function to group notifications by time
  String _getTimeGroup(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inHours;

    if (difference < 24) {
      return "Today";
    } else if (difference < 48) {
      return "Yesterday";
    } else {
      return "${dateTime.month}/${dateTime.day}/${dateTime.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Notifications",
                    style: GoogleFonts.sen(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Notifications List
              Expanded(
                child: Obx(() {
                  if (notificationController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (notificationController.getNotificationList.isEmpty) {
                    return Center(
                      child: Text(
                        "No notifications found.",
                        style: GoogleFonts.sen(color: Colors.white),
                      ),
                    );
                  }

                  // Group notifications by time (Today, Yesterday, etc.)
                  Map<String, List<Map<String, dynamic>>> groupedNotifications = {};
                  for (var notification in notificationController.getNotificationList) {
                    final timeGroup = _getTimeGroup(notification.createdAt); // Assuming 'createdAt' is in DateTime format
                    if (groupedNotifications[timeGroup] == null) {
                      groupedNotifications[timeGroup] = [];
                    }
                    groupedNotifications[timeGroup]!.add({
                      "title": notification.title,
                      "body": notification.content,
                      "time": timeGroup,
                      "color": const Color(0xffEEA534), // Or dynamically change this
                      "textColor": Colors.white,
                    });
                  }

                  // Display grouped notifications
                  return ListView.builder(
                    itemCount: groupedNotifications.keys.length,
                    itemBuilder: (context, index) {
                      final timeGroup = groupedNotifications.keys.elementAt(index);
                      final notifications = groupedNotifications[timeGroup]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group Header (e.g., Today, Yesterday)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                timeGroup,
                                style: GoogleFonts.sen(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Clear All",
                                  style: GoogleFonts.sen(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Notification Items
                          ...notifications.map((notification) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => const Rating());
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: notification["color"]),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification["title"] ?? "No Title",
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w600,
                                          color: notification["textColor"],
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        notification["body"] ?? "No Description",
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w400,
                                          color: notification["textColor"],
                                          fontSize: 12.sp,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:salt_cafe_app/Menu/rating.dart';
// import 'package:salt_cafe_app/controller/notification_controller.dart'; // make sure path is correct

// class MenuNotification extends StatefulWidget {
//   const MenuNotification({super.key});

//   @override
//   State<MenuNotification> createState() => _MenuNotificationState();
// }

// class _MenuNotificationState extends State<MenuNotification> {
//   final AllNotificationController notificationController = Get.put(AllNotificationController());



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
//         child: Padding(
//           padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Row
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () => Get.back(),
//                     child: const CircleAvatar(
//                       radius: 22,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(width: 10.w),
//                   Text(
//                     "Notifications",
//                     style: GoogleFonts.sen(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18.sp,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),

//               // Notifications List
//               Expanded(
//                 child: Obx(() {
//                   if (notificationController.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (notificationController.getNotificationList.isEmpty) {
//                     return Center(
//                       child: Text(
//                         "No notifications found.",
//                         style: GoogleFonts.sen(color: Colors.white),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     itemCount: notificationController.getNotificationList.length,
//                     itemBuilder: (context, index) {
//                       final item = notificationController.getNotificationList[index];
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 6.h),
//                         child: InkWell(
//                           onTap: () {
//                             Get.to(() => const Rating()); // Navigate on tap
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(10.w),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(color: const Color(0xffEEA534)),
//                               color: Colors.transparent,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.title ?? "No Title",
//                                   style: GoogleFonts.sen(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5.h),
//                                 Text(
//                                   item.content ?? "No Description",
//                                   style: GoogleFonts.sen(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.white70,
//                                     fontSize: 12.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

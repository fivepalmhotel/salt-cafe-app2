import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/track_call_screen.dart';
import 'package:salt_cafe_app/order_online/order_online.dart';

import '../GoogleMap/google_map.dart';
import 'massage_screen.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OrderTrackingPage(),
          // Background Image
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/images/mapimg.png"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          // AppBar Section
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20),
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  "Track Order",
                  style: GoogleFonts.sen(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.off(() => const OrderOnline());
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.home_outlined,
                        color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),

          // Draggable Scrollable Sheet (Bottom Sheet)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height, // Ensures proper layout
              child: DraggableScrollableSheet(
                initialChildSize: 0.3, // Start size (30% of screen)
                minChildSize: 0.2, // Min size (20% of screen)
                maxChildSize: 0.7, // Max size (70% of screen)
                snap: true,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Drag Handle
                        Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        // Scrollable Content
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: OrderTrackingScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Order Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/rider_meal.png",height: 60,width: 60,fit: BoxFit.cover,)
              ),
              const SizedBox(width: 12),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Goodluck Coffee House",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Ordered At 06 Sept, 10:00pm",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Order Details
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "2x ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Burger\n",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                          TextSpan(
                            text: "4x ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Sandwich",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Estimated Time
          Text(
            "20 min",
            style: GoogleFonts.sen(
              fontWeight: FontWeight.w800,
              color: const Color(0xff181C2E),
              fontSize: 30.sp,
            ),
          ),
          Text(
            "ESTIMATED DELIVERY TIME",
            style: GoogleFonts.sen(
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 16),

          // Timeline Steps (Wrapped in a SizedBox to prevent overflow)
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                buildTimelineStep(
                  isActive: true,
                  isCompleted: true,
                  text: "Your order has been received",
                  icon: Icons.check,
                  color: Colors.orange,
                  lineColor: Colors.orange,
                  textColor: Colors.orange,
                ),
                buildTimelineStep(
                  isActive: true, // Not active, so text stays grey
                  isCompleted: true,
                  text: "The restaurant is preparing your food",
                  isLoading: true, // Spinner appears in orange
                  color: Colors.orange,
                  lineColor: Colors.grey.shade400, // Keeps the line grey
                  textColor: Colors.grey, // Text stays grey
                ),
                buildTimelineStep(
                  isActive: false,
                  isCompleted: false,
                  text: "Your order has been picked up for delivery",
                  icon: Icons.check,
                  textColor: Colors.grey,
                ),
                buildTimelineStep(
                  isActive: false,
                  isCompleted: false,
                  text: "Order arriving soon!",
                  icon: Icons.check,
                  textColor: Colors.grey,
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Rider Info
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/rider.png"),
            ),
            title: Text(
              "Rider Name",
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff181C2E),
              ),
            ),
            subtitle: Text(
              "Courier",
              style: GoogleFonts.sen(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Prevents overflow issues
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const CallScreen(),
                        transition: Transition.upToDown,
                        duration: const Duration(milliseconds: 500));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffEEA534),
                    child: Icon(
                      Icons.local_phone,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Get.to(() => const MassageScreen(),
                        transition: Transition.upToDown,
                        duration: const Duration(milliseconds: 500));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(
                        color: const Color(0xffEEA534),
                      ),
                    ),
                    child: Image.asset("assets/images/massage.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimelineStep({
    required bool isActive,
    required bool isCompleted,
    required String text,
    bool isLoading = false,
    bool isLast = false,
    IconData? icon,
    Color color = Colors.grey,
    Color lineColor = Colors.grey,
    Color textColor = Colors.grey,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Indicator (Checkmark, Loading, or Grey Circle)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? color : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      icon ?? Icons.circle,
                      size: 16,
                      color: Colors.white,
                    ),
            ),

            // Line (hidden for last item)
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: lineColor,
              ),
          ],
        ),
        const SizedBox(width: 12), // Space between icon & text
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              text,
              style: TextStyle(
                color: textColor, // Controls text color
                fontWeight: isActive || isCompleted
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

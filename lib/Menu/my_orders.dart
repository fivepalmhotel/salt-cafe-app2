import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/rating.dart';
import 'package:salt_cafe_app/controller/book_table_controller.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final BookTableController bookTableController = Get.put(
    BookTableController(),
  );
  List<Map<String, String>> nameList = [
    {"name": "Dine out", "title1": "Edit"},
    {"name": "Lunch", "title1": "Track Order"},
    {"name": "Drink", "title1": "Track Order"},
  ];
  List<Map<String, String>> history = [
    {"name": "Lunch", "title": "Completed"},
    {"name": "Drink", "title": "Completed"},
    {"name": "Drink", "title": "Canceled"},
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),

        child:
        // Positioned.fill(
        //   child: Image.asset(
        //     "assets/images/themeimg.jpeg",
        //     fit: BoxFit.cover,
        //   ),
        // ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  child: Row(
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
                        "My orders",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //assets/images/profile_pic.jpeg
                Column(
                  children: [
                    // Tab Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween, // Use spaceEvenly for better spacing
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Text(
                              "Ongoing",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w700,
                                color:
                                    selectedIndex == 0
                                        ? const Color(0xffEEA534)
                                        : Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Text(
                              "History",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w700,
                                color:
                                    selectedIndex == 1
                                        ? const Color(0xffEEA534)
                                        : Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            height: 2,
                            width: double.infinity, // Match width of tabs
                            color: Colors.white.withOpacity(
                              0.3,
                            ), // Background line
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,

                            left:
                                selectedIndex == 0
                                    ? 0
                                    : 250, // Moves underline under selected text
                            child: Container(
                              height: 2,
                              width: 100,
                              color: const Color(
                                0xffEEA534,
                              ), // Active underline color
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Add space between line and content
                    const SizedBox(height: 16),

                    selectedIndex == 0
                        ? _buildOngoingContent()
                        : _buildHistoryContent(),
                  ],
                ),

                SizedBox(height: Get.height * 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildOngoingContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // List of Orders
      SizedBox(
        //height: Get.height, // Defined height to prevent infinite height issue
        child: Obx(() {
          if (bookTableController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (bookTableController.tabalBooking.isEmpty) {
            return const Center(
              child: Text(
                "No ongoing orders",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bookTableController.tabalBooking.length,
            itemBuilder: (context, index) {
              final item = bookTableController.tabalBooking[index];
              final hotel = item.hotelId;

              // Fetching hotel image and data
              final hotelImages = hotel.images as List?;
              final hotelImageUrl = (hotelImages != null && hotelImages.isNotEmpty)
                  ? hotelImages[0].toString()
                  : 'https://via.placeholder.com/150';

              final hotelName = hotel?.name ?? "Unknown Hotel";
              final hotelCity = hotel?.location?.city ?? "Unknown City";

              // Format booking date
              String formattedDate = 'Unknown Date';
              if (item.bookingDate != null && item.bookingDate.isUtc) {
                try {
                  final parsedDate = DateTime.parse("${item.bookingDate}");
                  formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
                } catch (e) {
                  formattedDate = 'Invalid Date';
                }
              }

              // Format booking time
              String timeSlot = item.timeSlot ?? 'Unknown Time';

              // Format number of guests
              String guests = item.numberOfGuests?.toString() ?? 'N/A';

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    // Hotel name and favorite icon
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hotelName,
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border_sharp,
                            color: Color(0xffEEA534),
                          ),
                        ],
                      ),
                    ),
                    // User image and details
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          hotelImageUrl,
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        hotelCity,
                        style: GoogleFonts.sen(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Text(
                        "#${item.id?.substring(0, 6).toUpperCase()}",
                        style: GoogleFonts.sen(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "Table for: $guests person\nDate: $formattedDate\nTime: $timeSlot",
                        style: GoogleFonts.sen(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Edit Action
                            Get.snackbar("Edit", "Editing booking #${item.id?.substring(0, 6)}");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 38.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: const Color(0xffEEA534),
                            ),
                            child: Text(
                              "Edit",
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle Cancel Action
                            Get.snackbar("Cancel", "Cancelled booking #${item.id?.substring(0, 6)}");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 38.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: const Color(0xffEEA534),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffEEA534),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const Divider(color: Colors.white),
                  ],
                ),
              );
            },
          );
        }),
      ),
    ],
  );
}



  // History Tab Content
  Widget _buildHistoryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // List of Orders
        SizedBox(
          height: 700, // Defined height to prevent infinite height issue
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              final item = history[index];
              Color titleColor =
                  item['title'] == 'Completed'
                      ? Colors.white
                      : (item['title'] == 'Canceled'
                          ? Colors.red
                          : Colors.white);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Text(
                            item['name']!,
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            item['title']!,
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: titleColor,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(height: 10),
                          const Icon(
                            Icons.favorite_border_sharp,
                            color: Color(0xffEEA534),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          "assets/images/tata.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "Salt Cafe, Noida",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Text(
                        "#242432",
                        style: GoogleFonts.sen(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "\$40.15",
                            style: GoogleFonts.sen(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(height: 20, width: 1, color: Colors.white),
                          const SizedBox(width: 3),
                          Text(
                            "30 Jan, 12:30",
                            style: GoogleFonts.sen(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Color(0xffEEA534),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "02 Items",
                            style: GoogleFonts.sen(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => const Rating(),
                              transition:
                                  Transition.downToUp, // Drop-down transition
                              duration: const Duration(
                                milliseconds: 500,
                              ), // Duration of the animation
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 38.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: const Color(0xffEEA534),
                              ),
                            ),
                            child: Text(
                              "Rate",
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffEEA534),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 38.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: const Color(0xffEEA534),
                          ),
                          child: Text(
                            "Re-Order",
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const Divider(color: Colors.white),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

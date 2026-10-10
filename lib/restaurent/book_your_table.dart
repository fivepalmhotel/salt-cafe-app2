import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_flip/page_flip.dart';
import 'package:pdfx/pdfx.dart'
    show
        DefaultBuilderOptions,
        PdfController,
        PdfDocument,
        PdfPageImageFormat,
        PdfView,
        PdfViewBuilders;
import 'package:salt_cafe_app/GoogleMap/hotel_location_map.dart';

import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/banner_controller.dart';
import 'package:salt_cafe_app/controller/offer_controller.dart';
import 'package:salt_cafe_app/controller/review_controller.dart';
import 'package:salt_cafe_app/controller/social_media_controller.dart';
import 'package:salt_cafe_app/controller/upload_review_controller.dart';
import 'package:salt_cafe_app/custom_widget/favorite_floating_button.dart';
import 'package:salt_cafe_app/custom_widget/hotels_carousel.dart';
import 'package:salt_cafe_app/expandeble_text.dart';
import 'package:salt_cafe_app/restaurent/fullimage_screen_viewer.dart';
import 'package:salt_cafe_app/screens/get_all_review_screen.dart';
import 'package:salt_cafe_app/screens/reserve_your_table.dart';
import 'package:salt_cafe_app/text_blink_controller.dart';

import 'book_table.dart';

class BookYourTable extends StatefulWidget {
  const BookYourTable({super.key});

  @override
  State<BookYourTable> createState() => _BookYourTableState();
}

class _BookYourTableState extends State<BookYourTable> {
  final ScrollController _scrollController = ScrollController();
  final AllCityController allController = Get.put(AllCityController());
  final AllOfferController allOffer = Get.put(AllOfferController());
  final UploadReviewController reviewControllerImage = Get.put(
    UploadReviewController(),
  );

  final SocialController socialController = Get.put(SocialController());
  final BannerController getBanner = Get.put(BannerController());
  final GlobalKey<PageFlipWidgetState> pdfViewerKey = GlobalKey();

  final GlobalKey _offersKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _photoKey = GlobalKey();
  final GlobalKey _reviewKey = GlobalKey();
  final ReviewController controllerReview = Get.put(ReviewController());

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(
        Offset.zero,
        ancestor:
            context.findAncestorRenderObjectOfType<RenderAbstractViewport>(),
      );

      double targetPosition = _scrollController.offset + position.dy - 200;

      _scrollController.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600; // Tablet breakpoint
          final isDesktop = constraints.maxWidth >= 1024; // Desktop breakpoint

          // Adjust font sizes and paddings based on screen size
          // double headingFontSize =
          //     isDesktop ? 40.sp : (isTablet ? 34.sp : 28.sp);
          // double bodyFontSize = isDesktop ? 18.sp : (isTablet ? 16.sp : 14.sp);
          double buttonHeight = isDesktop ? 70.h : 45.h;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/themeimg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                final hotels = allController.hotelList;
                final cityId = hotels.first.id;

                await allController.getHotelByCity(cityId);
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            RecentHotelsCarousel(controller: allController),
                            Padding(
                              padding: EdgeInsets.only(top: 50.h, left: 15.w),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(ReserveYourTable());
                                    },

                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //const FavoriteFloatingButton(),
                          ],
                        ),

                        Obx(() {
                          final hotels = allController.hotelList;

                          // Handle empty state
                          if (hotels.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 15.h,
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Text(
                                "No hotels available",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          // Get first available city name safely
                          final cityName =
                              hotels
                                  .firstWhere(
                                    (hotel) => hotel.city != null,
                                    orElse:
                                        () =>
                                            hotels
                                                .first, // Fallback to first hotel if none have cities
                                  )
                                  .city
                                  ?.name ??
                              "Unknown Location"; // Null-safe city name

                          return Padding(
                            padding: EdgeInsets.only(
                              top: 15.h,
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${hotels[0].name} ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffEEA534),
                                    ),
                                  ),
                                  TextSpan(
                                    text: cityName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          final hotels = allController.hotelList;

                          // Handle empty state
                          if (hotels.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 15.h,
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Text(
                                "No hotels available",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          // Get the first hotel with description or fallback to first hotel
                          final displayHotel = hotels.firstWhere(
                            (hotel) => hotel.description?.isNotEmpty ?? false,
                            orElse: () => hotels.first,
                          );

                          // Use actual rating from data if available
                          // final ratings =
                          //     displayHotel.ratings?.toString() ?? "4.7";
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              children: [
                                ExpandableDescription(
                                  description: displayHotel.description,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Color(0xffFFB71A),
                                        size: 30,
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      Text(
                                        displayHotel.ratings.toStringAsFixed(1),
                                        style: GoogleFonts.sen(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        socialController.openUrl(
                                          "https://www.instagram.com/thesaltcafedelhi/",
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/images/instagram.png",
                                        fit: BoxFit.cover,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                    _iconButton(
                                      "assets/images/placeholder.png",
                                    ),

                                    GestureDetector(
                                      onTap: () async {
                                        socialController.openWhatsApp(
                                          "+91 97118 28200",
                                          "Hello, I’d like to know more!",
                                        );
                                      },

                                      child: Image.asset(
                                        "assets/images/whats.png",
                                      ),
                                    ),
                                    // Image.asset("assets/images/whatsapp_color.png",height: 40,width: 40,)
                                  ],
                                ),

                                SizedBox(height: Get.height * 0.03),
                                Image.asset("assets/images/line.png"),
                              ],
                            ),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Offers Button
                              // Expanded(
                              //   child: InkWell(
                              //     onTap: () => scrollToSection(_offersKey),
                              //     child: Container(
                              //       alignment: Alignment.center,
                              //       height: 48,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(
                              //           100.r,
                              //         ),
                              //         border: Border.all(
                              //           color: Colors.white,
                              //           width: 2,
                              //         ),
                              //       ),
                              //       child: Text(
                              //         "Offers",
                              //         style: GoogleFonts.sen(
                              //           fontWeight: FontWeight.w400,
                              //           fontSize: 14.sp,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 8.w,
                              // ), // Adds spacing between buttons
                              // Menu Button
                              Expanded(
                                child: InkWell(
                                  onTap: () => scrollToSection(_menuKey),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(
                                      "Menu",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),

                              // Photos Button
                              Expanded(
                                child: InkWell(
                                  onTap: () => scrollToSection(_photoKey),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(
                                      "Gallery",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),

                              // Reviews Button
                              Expanded(
                                child: InkWell(
                                  onTap: () => scrollToSection(_reviewKey),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(
                                      "Reviews",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Text(
                            "Book a table",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Obx(() {
                          if (getBanner.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (getBanner.errorMessage.isNotEmpty) {
                            return Center(
                              child: Text(
                                getBanner.errorMessage.value,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }

                          if (getBanner.offerBanners.isEmpty) {
                            return const Center(
                              child: Text(
                                "No banners found",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: getBanner.offerBanners.length,
                            itemBuilder: (context, index) {
                              final bannerData = getBanner.offerBanners[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 20.h,
                                  right: 10,
                                  left: 10,
                                ),
                                child: Container(
                                  height: 185.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.r),
                                    color: const Color(0xffEEA534),
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 210,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    35,
                                                  ),
                                                  topLeft: Radius.circular(35),
                                                ),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/renc.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          right: 40,
                                                        ),
                                                    child: Text(
                                                      bannerData.desc,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 28.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xff533200,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    bannerData.title
                                                        .split(' ')
                                                        .take(2)
                                                        .join(' '),
                                                    style: GoogleFonts.inter(
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                        0xff533200,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    bannerData.title
                                                        .split(' ')
                                                        .skip(2)
                                                        .join(' '),
                                                    style: GoogleFonts.inter(
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                        0xff533200,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 50,
                                            ),
                                            child: Image.network(
                                              bannerData.image,
                                              height: 200,
                                              width: 148,
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// Positioned Button on Image
                                      Positioned(
                                        bottom: 10.h,
                                        right: 20.w,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.to(() => const BookTable());
                                          },
                                          child: const BlinkingText(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                        SizedBox(height: Get.height * 0.02),

                        //const SizedBox(height: 20),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Image.asset(
                              "assets/images/line.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            key: _menuKey,
                            "Menu",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w800,
                              fontSize: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(() {
                          final hotel = allController.selectedHotel.value;

                          if (hotel == null || hotel.createdAt == null)
                            return const SizedBox();

                          final createdAt = hotel.createdAt;
                          final now = DateTime.now();
                          final diff = now.difference(createdAt);

                          String timeAgo;
                          if (diff.inDays >= 30) {
                            final months = (diff.inDays / 30).floor();
                            timeAgo =
                                "$months month${months > 1 ? 's' : ''} ago";
                          } else if (diff.inDays >= 1) {
                            timeAgo =
                                "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
                          } else if (diff.inHours >= 1) {
                            timeAgo =
                                "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
                          } else {
                            timeAgo =
                                "${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago";
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Last update $timeAgo",
                              style: GoogleFonts.sen(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),

                        Obx(() {
                          final hotel = allController.selectedHotel.value;
                          final menuList = hotel?.menu ?? [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                menuList.isNotEmpty
                                    ? [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          menuList[0].type,
                                          style: GoogleFonts.sen(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                            color: const Color(0xffEEA534),
                                          ),
                                        ),
                                      ),
                                    ]
                                    : [],
                          );
                        }),
                        // Obx(() {
                        //   final hotel = allController.selectedHotel.value;
                        //   final menuList = hotel?.menu ?? [];

                        //   return SizedBox(
                        //     height: 240.h,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: menuList.length,
                        //       itemBuilder: (context, index) {
                        //         final item = menuList[index];
                        //         return Padding(
                        //           padding: EdgeInsets.only(left: 10.w),
                        //           child: Image.network(
                        //             item.image[0],
                        //             width: 200.w,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   );
                        // }),
                        Obx(() {
                          final hotel = allController.selectedHotel.value;
                          final menuList = hotel?.menu ?? [];

                          return SizedBox(
                            height: 350.h,

                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemCount: menuList.length,
                              itemBuilder: (context, index) {
                                final item = menuList[index];
                                return GestureDetector(
                                  onTap:
                                      () => _showPdfDialog(
                                        context,
                                        item.image[0],
                                      ),
                                  child: Container(
                                    width: 280.w,
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 30.w : 10.w,
                                      right:
                                          index == menuList.length - 1
                                              ? 30.w
                                              : 10.w,
                                    ),
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(color: Colors.grey),
                                    //   borderRadius: BorderRadius.circular(8),
                                    // ),
                                    child: Center(
                                      // This ensures content is centered vertically
                                      child: FutureBuilder<List<Uint8List>>(
                                        future: _getPdfImages(item.image[0]),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (snapshot.hasError ||
                                              !snapshot.hasData) {
                                            return const Center(
                                              child: Icon(Icons.error),
                                            );
                                          }

                                          return PageFlipWidget(
                                            // Replace with this
                                            key: pdfViewerKey,
                                            //backgroundColor: Colors.black,
                                            initialIndex: 0,
                                            lastPage: Container(
                                              color: Colors.black,
                                              child: const Center(
                                                child: Text('End of Document'),
                                              ),
                                            ),
                                            children:
                                                snapshot.data!.map((imageData) {
                                                  return Container(
                                                    // Remove margins for full-page flip
                                                    child: InteractiveViewer(
                                                      child: Image.memory(
                                                        imageData,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        //SizedBox(height: Get.height * 0.03),
                        SizedBox(height: Get.height * 0.03),
                        Center(
                          child: Image.asset(
                            "assets/images/line.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            key: _photoKey,
                            "Gallery",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                              color: const Color(0xffEEA534),
                            ),
                          ),
                        ),
                        Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allController.hotelList.length,
                            itemBuilder: (context, index) {
                              final hotel = allController.hotelList[index];
                              final images = hotel.images;

                              // Ensure at least 6 images, fallback to default or empty string if missing
                              List<String> safeImages = List.generate(
                                6,
                                (i) =>
                                    (images.length > i)
                                        ? images[i]
                                        : "", // fallback if index out of range
                              );

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      children: [
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 2,
                                          mainAxisCellCount: 2,
                                          child: _buildImageTile(safeImages[0]),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: _buildImageTile(safeImages[1]),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: _buildImageTile(safeImages[2]),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: _buildImageTile(safeImages[3]),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: _buildImageTile(safeImages[4]),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: _buildImageTile(safeImages[5]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.03),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder:
                                            (_) => Dialog(
                                              backgroundColor: Colors.black,
                                              insetPadding: EdgeInsets.zero,
                                              child: ImageViewerScreen(
                                                images: hotel.images,
                                              ),
                                            ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 44.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEA534),
                                        borderRadius: BorderRadius.circular(33),
                                        border: Border.all(
                                          width: 2,
                                          color: const Color(0xffEEA534),
                                        ),
                                      ),
                                      child: Text(
                                        "View All",
                                        style: GoogleFonts.sen(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),

                        SizedBox(height: Get.height * 0.03),
                        Center(child: Image.asset("assets/images/line.png")),
                        SizedBox(height: Get.height * 0.03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            key: _reviewKey,
                            "Reviews",
                            style: GoogleFonts.sen(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(() {
                          if (controllerReview.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (controllerReview.errorMessage.isNotEmpty) {
                            return Center(
                              child: Text(
                                controllerReview.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          if (controllerReview.flattenedRatings.isEmpty) {
                            return const Center(
                              child: Text(
                                "No reviews found!",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount:
                                controllerReview.flattenedRatings.length > 3
                                    ? 3
                                    : controllerReview.flattenedRatings.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final rating =
                                  controllerReview.flattenedRatings[index];
                              final date = rating.date ?? "";
                              final user = rating.userId;

                              final userImage = user?.image ?? "";
                              final hasProfileImage =
                                  userImage.isNotEmpty &&
                                  userImage.startsWith('http');
                              final userName = user?.fullName ?? 'Guest';

                              final comment = rating.comment ?? "";
                              final images = rating.image ?? "";
                              final ratingValue = rating.rating ?? 0;
                              final DateTime parseDate = DateTime.parse(
                                date.toString(),
                              );
                              final timeAgo = _timeAgo(parseDate);

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading:
                                            hasProfileImage
                                                ? CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                    userImage,
                                                  ),
                                                )
                                                : CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  child: const Icon(
                                                    Icons.person,
                                                    size: 18,
                                                  ),
                                                ),
                                        title: Text(userName),

                                        subtitle: Text(timeAgo),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (ratingValue > 0)
                                              Row(
                                                children: List.generate(
                                                  5,
                                                  (starIndex) => Icon(
                                                    Icons.star,
                                                    color:
                                                        starIndex < ratingValue
                                                            ? const Color(
                                                              0xffFFB71A,
                                                            )
                                                            : Colors.grey,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            if (images.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    images,
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 140,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => const Icon(
                                                          Icons.broken_image,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            if (comment.trim().isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                child: Text(
                                                  comment,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),

                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Dialog(
                                  insetPadding:
                                      EdgeInsets
                                          .zero, // Prevents default padding issues
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize:
                                                MainAxisSize.min, // Important
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemBuilder:
                                                    (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Color(0xffFFB71A),
                                                    ),
                                                onRatingUpdate: (rating) {
                                                  controllerReview
                                                      .ratingValue
                                                      .value = rating.toInt();
                                                },
                                              ),

                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: List.generate(3, (
                                                  index,
                                                ) {
                                                  // You can decide which imageUrl to use for each slot.
                                                  String? imageUrl =
                                                      reviewControllerImage
                                                          .uploadedImageUrl
                                                          .value; // Assuming this is the list for uploaded images.

                                                  return GestureDetector(
                                                    onTap: () async {
                                                      // Trigger pick image method when tapped
                                                      await reviewControllerImage
                                                          .pickImage();
                                                    },
                                                    child: Column(
                                                      children: [
                                                        imageUrl != null &&
                                                                imageUrl
                                                                    .isNotEmpty
                                                            // If imageUrl exists, show image
                                                            ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10,
                                                                  ),
                                                              child: Image.network(
                                                                imageUrl,
                                                                height: 60,
                                                                width: 60,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                                errorBuilder:
                                                                    (
                                                                      context,
                                                                      error,
                                                                      stackTrace,
                                                                    ) => const Icon(
                                                                      Icons
                                                                          .broken_image,
                                                                      size: 60,
                                                                    ),
                                                              ),
                                                            )
                                                            // If no imageUrl, show the upload icon
                                                            : const Icon(
                                                              Icons
                                                                  .cloud_upload_outlined,
                                                              color: Color(
                                                                0xff523BB1,
                                                              ),
                                                              size: 30,
                                                            ),
                                                        // "Add" text below the image/icon
                                                        Text(
                                                          "Add",
                                                          style:
                                                              GoogleFonts.sen(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),

                                              const SizedBox(height: 20),
                                              Container(
                                                height: 118,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      controllerReview
                                                          .commentController,
                                                  cursorColor: Colors.black,
                                                  maxLines: null,
                                                  decoration: const InputDecoration(
                                                    hintText:
                                                        "write your review......",
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                        ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 60,
                                                    ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                              0xffEEA534,
                                                            ),
                                                        minimumSize: const Size(
                                                          double.infinity,
                                                          44,
                                                        ),
                                                      ),
                                                  onPressed: () async {
                                                    try {
                                                      print(
                                                        '✅ Submit button pressed',
                                                      );

                                                      // 1. Get and validate inputs
                                                      final comment =
                                                          controllerReview
                                                              .commentController
                                                              .text
                                                              .trim();
                                                      final rating =
                                                          controllerReview
                                                              .ratingValue
                                                              .value;
                                                      final hotels =
                                                          allController
                                                              .hotelList;

                                                      if (comment.isEmpty ||
                                                          rating == null ||
                                                          rating == 0 ||
                                                          hotels.isEmpty) {
                                                        Get.snackbar(
                                                          'Incomplete',
                                                          'Please provide all details',
                                                        );
                                                        return;
                                                      }

                                                      // 2. Show loading indicator
                                                      Get.dialog(
                                                        const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        barrierDismissible:
                                                            false,
                                                        name:
                                                            'loading_dialog', // Unique name for this dialog
                                                      );

                                                      // 3. Prepare review data
                                                      controllerReview
                                                          .comment
                                                          .value = comment;
                                                      controllerReview
                                                              .date
                                                              .value =
                                                          DateTime.now()
                                                              .toIso8601String();
                                                      controllerReview
                                                          .hotelIds
                                                          .value = hotels[0].id;
                                                      controllerReview
                                                          .type
                                                          .value = "hotel";
                                                      controllerReview
                                                              .images
                                                              .value =
                                                          reviewControllerImage
                                                              .uploadedImageUrl
                                                              .value;

                                                      print(
                                                        '🔄 Submitting review...',
                                                      );
                                                      final success =
                                                          await controllerReview
                                                              .addReview();
                                                      print(
                                                        '🎯 Submission result: $success',
                                                      );

                                                      // 4. Close ALL dialogs including the loading and review dialogs
                                                      Get.until(
                                                        (route) =>
                                                            !Get.isDialogOpen!,
                                                      );

                                                      // 5. Show result
                                                      if (success) {
                                                        Get.snackbar(
                                                          'Success',
                                                          'Thank you for your review!',
                                                          backgroundColor:
                                                              Colors.green,
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          margin:
                                                              const EdgeInsets.all(
                                                                10,
                                                              ),
                                                          borderRadius: 8,
                                                          duration:
                                                              const Duration(
                                                                seconds: 2,
                                                              ),
                                                        );
                                                      } else {
                                                        Get.snackbar(
                                                          'Error',
                                                          'Failed to submit review',
                                                        );
                                                      }
                                                    } catch (e) {
                                                      print('❌ Error: $e');
                                                      // Close any open dialogs
                                                      if (Get.isDialogOpen!)
                                                        Get.back();
                                                      Get.snackbar(
                                                        'Error',
                                                        e.toString(),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    "Submit",
                                                    style: GoogleFonts.sen(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            height: buttonHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/edit.png"),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Leave a review",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: const Color(0xffEEA534),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AllReviewsPage());
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            height: buttonHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(0xffEEA534),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.w),
                                  Text(
                                    "View All Review",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(height: 30.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _iconButton(String assetPath) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HotelLocationMapping());
      },

      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: 59,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(100.r),
        //   border: Border.all(color: const Color(0xffEEA534), width: 2),
        // ),
        child: Image.asset(assetPath),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays > 30) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }

  Widget _buildImageTile(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child:
          imageUrl.isNotEmpty
              ? Image.network(
                imageUrl,
                width: 800,
                height: 600,
                fit: BoxFit.cover,
              )
              : Container(
                color: Colors.grey.shade300,
              ), // Placeholder if URL is empty
    );
  }
}

final _pdfCache = <String, Uint8List>{};

Future<Uint8List> _loadPdfFromNetwork(String url) async {
  if (_pdfCache.containsKey(url)) {
    return _pdfCache[url]!;
  }

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _pdfCache[url] = response.bodyBytes;
      return response.bodyBytes;
    }
    throw Exception('Failed to load PDF: ${response.statusCode}');
  } catch (e) {
    throw Exception('PDF load error: $e');
  }
}

final _imageCache = <String, List<Uint8List>>{};

Future<List<Uint8List>> _getPdfImages(String url) async {
  if (_imageCache.containsKey(url)) {
    return _imageCache[url]!;
  }

  final pdfBytes = await _loadPdfFromNetwork(url);
  final images = await _convertPdfToImages(pdfBytes);
  _imageCache[url] = images;
  return images;
}

void _showPdfDialog(BuildContext context, String pdfUrl) async {
  final bytes =
      (await NetworkAssetBundle(
        Uri.parse(pdfUrl),
      ).load(pdfUrl)).buffer.asUint8List();

  showDialog(
    context: context,
    builder: (context) {
      final controller = PdfController(
        document: PdfDocument.openData(bytes), // <-- correct here
        initialPage: 1,
      );

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              PdfView(
                controller: controller,
                scrollDirection: Axis.horizontal, // Horizontal scroll
                pageSnapping: true,
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<List<Uint8List>> _convertPdfToImages(Uint8List pdfData) async {
  final document = await PdfDocument.openData(pdfData);
  final pageCount = document.pagesCount;
  final images = <Uint8List>[];

  for (var i = 1; i <= pageCount; i++) {
    final page = await document.getPage(i);
    final pageImage = await page.render(
      width: page.width * 2, // Higher resolution for better quality
      height: page.height * 2,
      format: PdfPageImageFormat.png,
    );
    await page.close();
    images.add(pageImage!.bytes);
  }

  await document.close();
  return images;
}

// Future<List<String>> fetchImagePaths() async {
//   await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
//   return [
//     "assets/images/noida_img.jpeg",
//     "assets/images/noida_img2.jpeg",
//     "assets/images/delhi_img.jpeg",
//     "assets/images/delhi_img2.jpeg",
//     "assets/images/agra_img.jpeg",
//     "assets/images/agra_img2.jpeg",
//   ];
// }

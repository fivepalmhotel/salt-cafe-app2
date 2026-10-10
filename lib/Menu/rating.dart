import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/review_controller.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  final ReviewController controllerReview = Get.put(ReviewController());

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
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
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
                        "Rating & Reviews",
                        style: GoogleFonts.sen(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {


                      if (controllerReview.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
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
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
                    return ListView.builder(
                       itemCount: controllerReview.flattenedRatings.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final rating = controllerReview.flattenedRatings[index];
                final user = rating.userId;
                final comment = rating.comment ?? "";
                final ratingValue = rating.rating ?? 0;
                final image = rating.image ?? "";
                final rawDate = rating.date?.toString() ?? "";

                final userName = user?.fullName ?? "Guest";
                final userImage = user?.image ?? "";

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            height: 230.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Salt Cafe, Noida ",
                                        style: GoogleFonts.sen(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "3 Hours ago",
                                        style: GoogleFonts.sen(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset("assets/images/deicon.png"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              4,
                                              (index) => const Icon(
                                                Icons.star,
                                                color: Color(0xffFFB71A),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "4 Star Reviews",
                                            style: GoogleFonts.sen(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                "assets/images/rapizza.png",
                                                fit: BoxFit.cover,
                                                height: 80,
                                                width: 140,
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.02),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                "assets/images/rating_pizza.png",
                                                fit: BoxFit.cover,
                                                height: 80,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          'ely loved my experience at this place! the balcony view, combined with the refreshing breeze, made for the perfect ambiance.',
                                          style: GoogleFonts.sen(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 13.sp,
                                            color: Colors.black,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

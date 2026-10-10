import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/offer_controller.dart';


class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final AllOfferController allOffer = Get.put(AllOfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Your Offers",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Obx(() {
                  if (allOffer.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (allOffer.offerList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Try again later",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: allOffer.offerList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 0.75, // Adjust for your content height
                    ),
                    itemBuilder: (context, index) {
                      final offers = allOffer.offerList[index];
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/background.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 15.h,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      offers.title,
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.sp,
                                        color: const Color(0xff6E1F11),
                                      ),
                                    ),
                                    Image.network(
                                      offers.image,
                                      height: 42,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      offers.couponCode,
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      offers.description,
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          "Got it",
                                          style: GoogleFonts.sen(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: -15,
                            right: -10,
                            child: CircleAvatar(
                              backgroundColor: Color(0xffFFE194),
                              radius: 15,
                              child: Icon(
                                Icons.close,
                                color: Color(0xffEF761A),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/auth_check_controller.dart';
import 'package:salt_cafe_app/restaurent/nav_baar.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:salt_cafe_app/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReserveYourTable extends StatelessWidget {
  final AllCityController allCityController = Get.put(AllCityController());

  
  ReserveYourTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h, left: 15.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 15,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Please Click to Chose the ",
                      style: GoogleFonts.alikeAngular(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "Restaurant",
                      style: GoogleFonts.alikeAngular(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffEEA534),
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "branch ",
                      style: GoogleFonts.alikeAngular(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffEEA534),
                      ),
                    ),
                    TextSpan(
                      text: "for table reservation",
                      style: GoogleFonts.alikeAngular(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (allCityController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (allCityController.cityList.isEmpty) {
                  return Center(
                    child: Text(
                      "Data not found",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allCityController.cityList.length,
                    itemBuilder: (context, index) {
                      final data = allCityController.cityList[index];

                      print("data: ${data.image}");
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                  text: "The Salt cafe  ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                  text: data.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffEEA534),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () async {
                              await allCityController.getHotelByCity(data.id);

                              // Replace "yourHotelId" with the actual ID you want to navigate to
                              final yourHotelId = data.id; // <- example ID

                              final matchingHotel = allCityController.hotelList
                                  .firstWhere(
                                    (hotel) => hotel.id == yourHotelId,
                                    orElse:
                                        () =>
                                            allCityController
                                                .hotelList
                                                .first, // fallback
                                  );

                              allCityController.selectedHotel.value =
                                  matchingHotel;

                              Get.to(() => BottomNavBar());
                            },

                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 90,
                                    left: 250,
                                  ),
                                  height: 141.h,
                                  width: 350.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      filterQuality: FilterQuality.low,
                                      image: ResizeImage(
                                        NetworkImage(data.image),
                                        width: 800,
                                        height: 600,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  );
                }
              }),

              SizedBox(height: Get.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/track_order.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

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
              padding: EdgeInsets.only(
                top: 80.h,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Glow Effect (Outer Layer)
                      Container(
                        height: 140, // Slightly bigger than the main image
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Ensures a circular glow
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffF5BB3B)
                                  .withOpacity(0.6), // Yellow glow
                              spreadRadius:
                                  1, // Controls the spread of the glow
                              blurRadius: 10, // Soft glow effect
                            ),
                          ],
                        ),
                      ),

                      // Circular Image with Elevation (Inner Layer)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            shape:
                                BoxShape.circle, // Ensures proper rounded shape
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffF5BB3B)
                                    .withOpacity(0.9), // Strong yellow glow
                                spreadRadius: 5, // Slight glow around the image
                                blurRadius: 10, // Smooth soft effect
                                offset: const Offset(0, 5), // Elevation shadow below
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(33),
                            child: Image.asset(
                              "assets/images/tata.jpeg",
                              height: 150, // Adjusted for better fit
                              width: 150,
                              fit: BoxFit
                                  .cover, // Ensures the image covers the space
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: Get.height * 0.2,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff001A2E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: 350,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/rider.png"),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text("Rider name",style: GoogleFonts.sen(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20.sp
                        ),),
                        Text("Connecting.......",style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                            fontSize: 15.sp
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset("assets/images/Mute.png"),
                            InkWell(
                              onTap: () {
                                Get.to(() => const TrackOrder(),transition: Transition.upToDown,duration: const Duration(milliseconds: 500));
                              },
                                child: Image.asset("assets/images/End Icon.png")),
                            Image.asset("assets/images/Speaker.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

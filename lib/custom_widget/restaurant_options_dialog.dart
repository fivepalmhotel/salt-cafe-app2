import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantOptionsDialog extends StatelessWidget {
  final String selectedLocation;

  const RestaurantOptionsDialog({super.key, required this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedLocation,
                style: GoogleFonts.sen(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff181C2E),
                ),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, size: 30),
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.04),
        Card(
          elevation: 2,
          child: Column(
            children: [
              _optionRow("assets/images/flag.png", "Add to collection"),
              _optionRowWithIcon(Icons.info_outline, "See More About this restaurant"),
              _optionRowWithIcon(Icons.share, "Share this restaurant"),
              _optionRowWithIcon(Icons.visibility_off_outlined, "Hide this restaurant"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _optionRow(String image, String text) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(width: 10),
            Text(text, style: GoogleFonts.sen(fontSize: 16.sp)),
          ],
        ),
      );

  Widget _optionRowWithIcon(IconData icon, String text) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xffEEA534)),
            const SizedBox(width: 10),
            Text(text, style: GoogleFonts.sen(fontSize: 16.sp)),
          ],
        ),
      );
}

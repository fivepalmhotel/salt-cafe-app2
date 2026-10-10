import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableDescription extends StatelessWidget {
  final String? description;

  ExpandableDescription({super.key, this.description});

  final RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final descText =
          description?.trim().isNotEmpty == true
              ? description!
              : "No description available";

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descText,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.white54),
            maxLines: isExpanded.value ? null : 4,
            overflow:
                isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Text(
              isExpanded.value ? 'Read less' : 'Read more',
              style: GoogleFonts.poppins(
                color: Color(0xffEEA534),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    });
  }
}

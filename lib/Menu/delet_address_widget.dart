import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAddressDialog extends StatelessWidget {
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  const DeleteAddressDialog({
    super.key,
    required this.onYesTap,
    required this.onNoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 210.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Do you really want \nto delete your \naddress? ",
                    style: GoogleFonts.sen(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff181C2E),
                    ),
                  ),
                  TextSpan(
                    text: "🥺",
                    style: GoogleFonts.notoColorEmoji(fontSize: 22.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: onYesTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xffEEA534)),
                    ),
                    child: Text(
                      "Yes",
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffEEA534),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onNoTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEA534),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "No",
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

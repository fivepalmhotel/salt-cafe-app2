import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/Menu/my_address.dart';
import 'package:salt_cafe_app/controller/address_controller.dart';

import '../GoogleMap/google_map.dart';

class EditAddress extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClipRRect(
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: OrderTrackingPage(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ADDRESS",
                        style: GoogleFonts.sen(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: addressController.address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "3235 Royal Ln. mesa, new jersy 34567",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.location_pin,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "STREET",
                            style: GoogleFonts.sen(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 110),
                          Text(
                            "POST CODE",
                            style: GoogleFonts.sen(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressController.street,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "hason nagar",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: addressController.postCode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "3475",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "APARTMENT",
                        style: GoogleFonts.sen(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: addressController.apartment,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "323",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Button
                          Expanded(
                            child: Obx(() {
                              final isSelected =
                                  addressController.selectedHouseType.value ==
                                  "Home";
                              return ElevatedButton(
                                onPressed: () {
                                  addressController.selectedHouseType.value =
                                      "Home";
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  backgroundColor:
                                      isSelected
                                          ? const Color(0xffA97626)
                                          : Colors.white,
                                ),
                                child: Text(
                                  "Home",
                                  style: GoogleFonts.sen(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 10),

                          // Work Button
                          Expanded(
                            child: Obx(() {
                              final isSelected =
                                  addressController.selectedHouseType.value ==
                                  "Work";
                              return ElevatedButton(
                                onPressed: () {
                                  addressController.selectedHouseType.value =
                                      "Work";
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  backgroundColor:
                                      isSelected
                                          ? const Color(0xffA97626)
                                          : Colors.white,
                                ),
                                child: Text(
                                  "Work",
                                  style: GoogleFonts.sen(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 10),

                          // Other Button
                          Expanded(
                            child: Obx(() {
                              final isSelected =
                                  addressController.selectedHouseType.value ==
                                  "Other";
                              return ElevatedButton(
                                onPressed: () {
                                  addressController.selectedHouseType.value =
                                      "Other";
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  backgroundColor:
                                      isSelected
                                          ? const Color(0xffA97626)
                                          : Colors.white,
                                ),
                                child: Text(
                                  "Other",
                                  style: GoogleFonts.sen(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      Obx(() {
                        return GestureDetector(
                          onTap: () async {
                            if (addressController.isLoading.value) {
                              // If already loading, don't proceed further
                              return;
                            }
  print("Selected House Type: ${addressController.selectedHouseType.value}");
                            // Set the loading state to true before calling updateAdress
                            addressController.isLoading.value = true;

                            await addressController
                                .addAdress(); // Update the address

                            if (!addressController.isLoading.value) {
                              // Navigate to MyAddress after the update is complete
                              Get.to(() => MyAddress());
                            } else {
                              // Optionally, you can show a snackbar or handle errors if needed
                              Get.snackbar(
                                "Error",
                                "Failed to update address.",
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 345.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color(0xffEEA534),
                            ),
                            child:
                                addressController.isLoading.value
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                    : Text(
                                      "SAVE LOCATION",
                                      style: GoogleFonts.sen(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                          ),
                        );
                      }),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
           Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

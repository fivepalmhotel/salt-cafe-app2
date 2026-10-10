import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/custom_widget/restaurant_options_dialog.dart';
import 'package:salt_cafe_app/screens/reserve_your_table.dart';

class HeaderActionButtons extends StatelessWidget {
  final String selectedLocation;

  const HeaderActionButtons({super.key, required this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.off(() => ReserveYourTable()),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          InkWell(
            onTap: () {
              Get.dialog(
                Padding(
                  padding: const EdgeInsets.only(bottom: 300),
                  child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: RestaurantOptionsDialog(selectedLocation: selectedLocation),
                    ),
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../views/add_card_view.dart';

class AddCardView extends StatelessWidget {
  final AddCardViewModel controller = Get.put(AddCardViewModel());

  AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => controller.cardHolderName.value = value,
              decoration: InputDecoration(
                  hintText: "Vishal Khadok",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  )),
            ),

            TextField(
              onChanged: (value) => controller.cardNumber.value = value,
              decoration: const InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (value) => controller.expiryDate.value = value,
              decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
            ),
            TextField(
              onChanged: (value) => controller.cvc.value = value,
              decoration: const InputDecoration(labelText: 'CVC'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.addCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Add & Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

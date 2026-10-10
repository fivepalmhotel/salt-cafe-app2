import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../controller/cart_controller.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  var createdOrders = <String, dynamic>{}.obs;
String? savedOrderId;
  
  RxMap<String, dynamic> createdOrder = <String, dynamic>{}.obs;

  final cartController = Get.put(AddToCartController());
  RxString orderId = ''.obs;

  Future<bool> checkoutCart() async {
  try {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final cart = cartController.getCart.value;
    if (cart == null) {
      Get.snackbar("Error", "Cart is empty");
      return false;
    }
    final List<Map<String, dynamic>> services = cart.services.map((item) => {
          "serviceId": item.serviceId.id,
          "price": item.price,
          "quantity": item.quantity,
          "total": item.price * item.quantity,
        }).toList();

    final response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}/api/v1/user/Cart/checkout"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "services": services,
        "totalAmount": cart.totalAmount,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["status"] == 200) {
      createdOrder.value = data["data"];
      savedOrderId = createdOrder['orderId'];
      Get.snackbar("Success", "Order created successfully",  backgroundColor: Colors.green,
  colorText: Colors.white,
  snackPosition: SnackPosition.TOP, // or BOTTOM if preferred
  duration: Duration(seconds: 3), // optional
  margin: EdgeInsets.all(10),     // optional
  borderRadius: 8,           );
      return true;
    } else {
      Get.snackbar("Error", data["message"] ?? "Checkout failed");
      return false;
    }
  } catch (e) {
    Get.snackbar("Error", "Unexpected error during checkout");
    return false;
  } finally {
    isLoading.value = false;
  }
}
 Future<bool> placeOrderAfterPayment() async {
  if (savedOrderId == null) {
    Get.snackbar("Error", "Order ID not found, please try again.");
    return false;
  }
  try {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final url = Uri.parse("${ApiConstant.baseUrl}/api/v1/user/Cart/placeOrder/$savedOrderId");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "paymentStatus": "Paid",
        "paymentMode": "Upi", // Or whatever mode you want to set
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["status"] == 200) {
      Get.snackbar("Success", "Payment success & order placed!",  backgroundColor: Colors.green,
  colorText: Colors.white,
  snackPosition: SnackPosition.TOP, // or BOTTOM if preferred
  duration: Duration(seconds: 3), // optional
  margin: EdgeInsets.all(10),     // optional
  borderRadius: 8,           );
      return true;
    } else {
      Get.snackbar("Error", data["message"] ?? "Failed to place order");
      return false;
    }
  } catch (e) {
    Get.snackbar("Error", "Unexpected error during order placement");
    return false;
  } finally {
    isLoading.value = false;
  }
}

}

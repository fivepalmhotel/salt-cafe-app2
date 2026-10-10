import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/add_item_model.dart';
import 'package:salt_cafe_app/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddToCartController extends GetxController {
  Rxn<ServiceData> getCart = Rxn<ServiceData>();
  Rxn<Data> addCart = Rxn<Data>();
  RxString serviceId = "".obs;
  RxInt quantity = 0.obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCartData();
  }

  Future<void> addToCart() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        Get.snackbar("Auth Error", "User not logged in.");
        isLoading.value = false;
        return;
      }

      if (serviceId.value == null || serviceId.value.toString().isEmpty) {
        Get.snackbar("Error", "Service ID is missing.");
        isLoading.value = false;
        return;
      }

      final requestBody = {
        "quantity": quantity.value,
        "serviceIds": [serviceId.value],
      };

      print("📦 Sending cart request with body: $requestBody");
      print("📥 Token: $token");

      final response = await http.post(
        Uri.parse(
          "${ApiConstant.baseUrl}/api/v1/user/Cart/addToCartSingleService",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      print("✅ Response status: ${response.statusCode}");
      print("✅ Response body: ${response.body}");

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData["data"] != null) {
        addCart.value = AddItem.fromJson(responseData).data;
        await getCartData();
        Get.snackbar(
          "Success",
          "Item added to cart.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
          margin: const EdgeInsets.all(12), // optional
          borderRadius: 8, // optional
        );
      } else {
        Get.snackbar(
          "Error",
          responseData["message"] ?? "Failed to add to cart.",
        );
      }
    } catch (e) {
      print("🚨 Exception in addToCart: $e");
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCartData() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    print("token: $token");

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/getCart"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        getCart.value = ServiceData.fromJson(jsonData['data']);
      } else {
        //Get.snackbar("Error", "Failed to Cart.");
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateQuantity() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    try {
      print("Sending serviceId: ${serviceId.value}");
      print("Sending quantity: ${quantity.value}");

      final response = await http.put(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/Cart/updateQuantity"),
        body: json.encode({
          "serviceId": serviceId.value, // ✅ Correct format
          "quantity": quantity.value,
        }),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        await getCartData();
        Get.snackbar(
          "Success",
          "Item updated in cart",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, // Optional: BOTTOM or TOP
          margin: EdgeInsets.all(10), // Optional: for spacing
          borderRadius: 8, // Optional: rounded corners
          duration: Duration(seconds: 2), // Optional: control how long it stays
        );
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Get.snackbar("Error", "Failed to update cart.");
      }
    } catch (error) {
      print("Error: $error");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(String serviceId) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    try {
      final response = await http.delete(
        Uri.parse(
          "${ApiConstant.baseUrl}/api/v1/user/Cart/removeFromCart/$serviceId",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        await getCartData(); // Refresh cart data
        Get.snackbar("Success", "Item removed from cart");
      } else {
        Get.snackbar("Error", "Failed to remove item from cart.");
      }
    } catch (error) {
      print("Error: $error");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }


 void clearCart() {
  getCart.value = null; // or empty your cart model accordingly
  update(); // if you're using GetBuilder
}

}

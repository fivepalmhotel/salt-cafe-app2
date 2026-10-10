import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/card_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardAddController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  var deletingCardId = ''.obs;


  RxList<Datum> cardDetails = <Datum>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController expaireDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  @override
  void onInit() {
    getCard();
    super.onInit();
  }

  Future<void> addCard() async {
    isLoading.value = true;
    errorMessage.value = "";
   

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      errorMessage.value = "Authentication token not found.";
      isLoading.value = false;
      return;
    }

    const url = "${ApiConstant.baseUrl}/api/v1/user/card-details/add";
    // print("Calling API: $url");
    // print("Token: $token");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },

        body: json.encode({
          "cardHolderName": nameController.text.trim(),
          "cardNumber": cardController.text.trim(),
          "expiryDate": expaireDateController.text.trim(),
          "cvv": cvcController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        await getCard();

        Get.snackbar(
          "Success",
          "Card added successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // print("Response Body: ${response.body}");
      } else {
        String reasonPhrase = response.reasonPhrase ?? "Unknown error";
        print("Failed response body: ${response.body}");
        errorMessage.value = "Error ${response.statusCode}: $reasonPhrase";
        Get.snackbar(
          "Error",
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on TimeoutException {
      errorMessage.value = "Connection timeout. Please try again.";
    } catch (error) {
      errorMessage.value = "Unexpected error: $error";
      print("Catch error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCard() async {
    isLoading.value = true;
    errorMessage.value = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      errorMessage.value = "Authentication token not found.";
      isLoading.value = false;
      return;
    }

    const url = "${ApiConstant.baseUrl}/api/v1/user/card-details";
    print("Calling API: $url");
    print("Token: $token");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        CardDetailModel cardDetailModel = CardDetailModel.fromJson(
          responseData,
        );
        cardDetails.value = cardDetailModel.data;

        // print("Response Body: ${response.body}");
      } else {
        String reasonPhrase = response.reasonPhrase ?? "Unknown error";
        print("Failed response body: ${response.body}");
        errorMessage.value = "Error ${response.statusCode}: $reasonPhrase";
        Get.snackbar(
          "Error",
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on TimeoutException {
      errorMessage.value = "Connection timeout. Please try again.";
    } catch (error) {
      errorMessage.value = "Unexpected error: $error";
      print("Catch error: $error");
    } finally {
      isLoading.value = false;
    }
  }

 Future<bool> deleteCard(String id) async {
  isLoading.value = true;
    deletingCardId.value = id; 
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? token = prefs.getString("token");

  if (token == null) {
    Get.snackbar("Unauthorized", "User not found. Please login again.");
    isLoading.value = false;
    return false; // return false if no token
  }

  try {
    final response = await http.delete(
      Uri.parse("${ApiConstant.baseUrl}/api/v1/user/card-details/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      await getCard(); // refresh list after successful delete
      Get.snackbar("Success", "Card deleted successfully.");
      return true; // ✅ success
    } else {
      Get.snackbar(
        "Error",
        "Failed to delete card: ${response.statusCode}",
      );
      return false; // ❌ failure
    }
  } catch (error) {
    print("Error deleting card: $error");
    Get.snackbar("Error", "An error occurred while deleting card.");
    return false; // ❌ error
  } finally {
     deletingCardId.value = '';
  }
}


  Future<void> updateCard(String id) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("Unauthorized", "User not found. Please login again.");
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.put(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/card-details/$id"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "cardHolderName": nameController.text.trim(),
          "cardNumber": cardController.text.trim(),
          "expiryDate": expaireDateController.text.trim(),
          "cvv": cvcController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        await getCard();
        Get.snackbar("Success", "Card updated successfully.");
      } else {
        Get.snackbar("Error", "Failed to updated Card: ${response.statusCode}");
      }
    } catch (error) {
      print("Error $error");
      Get.snackbar("Error", "An error occurred while updated Card");
    } finally {
      isLoading.value = false;
    }
  }
}

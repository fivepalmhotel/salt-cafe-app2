import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/category_model.dart';
import 'package:salt_cafe_app/models/food_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/models/food_sub_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFoodCategory extends GetxController {
  RxList<Datum> foodList = <Datum>[].obs;
  RxList<Data> foodSubList = <Data>[].obs;
  Rxn<OfferData> foodDetail = Rxn<OfferData>();
  RxInt cartQuantityName = 1.obs;
final RxString selectedSize = "S".obs; 
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFoodCategory();
  }

  Future<void> getFoodCategory() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          "${ApiConstant.baseUrl}/api/v1/admin/mainCategory/allCategory",
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        FoodCategory foodCategory = FoodCategory.fromJson(responseData);
        foodList.assignAll(foodCategory.data);
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch food categories.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (error) {
      print("Error: $error");
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> getsubCategory(String id) async {
    if (id.isEmpty) {
      Get.snackbar("Error", "Category ID cannot be empty.");
      return false;
    }

    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("Unauthorized", "Token not found. Please login again.");
      isLoading.value = false;
      return false;
    }

    try {
      final String url =
          "${ApiConstant.baseUrl}/api/v1/admin/Service/byMainCategory/$id";
      print("Request URL: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['data'] != null &&
            responseData['data'] is List &&
            responseData['data'].isNotEmpty) {
          FoodCategoryById subCategory = FoodCategoryById.fromJson(
            responseData,
          );
          foodSubList.assignAll(subCategory.data);
          return true;
        } else {
          foodSubList.clear();
          Get.snackbar("No Data", "No food items found for this category.");
          return false;
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch subcategories.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        return false;
      }
    } catch (error) {
      print("Error: $error");
      Get.snackbar('Error', 'Something went wrong. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFoodDetails(String foodId) async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("Unauthorized", "Token not found. Please login again.");
      isLoading.value = false;
    }

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/Service/by/$foodId"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        foodDetail.value =
            FoodCategoryDetails.fromJson(json.decode(response.body)).data;
      } else {
        Get.snackbar("Error", "Failed to load food details.");
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/all_city_model.dart';
import 'package:salt_cafe_app/models/city_by_hotel_model.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:salt_cafe_app/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCityController extends GetxController {
  RxList<Datum> cityList = <Datum>[].obs;
  RxBool isLoading = false.obs;

  RxList<Hotel> hotelList = <Hotel>[].obs;
  var selectedHotel = Rxn<Hotel>();

  RxMap<String, dynamic> cityById = <String, dynamic>{}.obs;

  @override
  void onInit() {
    getAllCity();
    //cityById();
    super.onInit();
  }

  Future<void> getAllCity() async {
    isLoading.value = true;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");

      // if (token == null || token.isEmpty) {
      //   Get.snackbar(
      //     "Unauthorized",
      //     "Token not found. Please login again.",
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      //   Get.offAll(() =>  LoginScreen()); // Navigate to login screen
      //   return;
      // }

      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/city/cities"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final cityModel = cityModelFromJson(response.body);

        if (cityModel.data.isNotEmpty) {
          cityList.value = cityModel.data;
        } else {
          Get.snackbar("No Cities Found", "City list is empty.",
          
          backgroundColor: Colors.red,
  colorText: Colors.white,
  snackPosition: SnackPosition.BOTTOM,
  margin: const EdgeInsets.all(10),
  borderRadius: 8,
  duration: const Duration(seconds: 2),
          );
        }
      } else {
        final errorMsg =
            json.decode(response.body)['message'] ?? 'Unknown error';
        Get.snackbar(
          "Error",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      print("Error fetching cities: $error");
      Get.snackbar(
        "Error",
        "Something went wrong: $error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCityById(String cityId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Unauthorized", "Token not found. Please login again.");
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/city/cities/$cityId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        cityById.value = Map<String, dynamic>.from(responseData["data"]);

        // Print after setting value
        print("✅ City Fetched: ${cityById['name']} - ID: ${cityById['_id']}");
        // Optional: print individual fields
        print("City ID: ${cityById['id']}");
        print("City Name: ${cityById['name']}");
        print("City Image: ${cityById['image']}");
      } else {
        print("Failed to load city. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching city data: $error");
    }
  }

  Future<void> getHotelByCity(String cityId) async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("Unauthorized", "Token not found. Please login again.");
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/hotel?city=$cityId"),

        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        hotelList.value = CityByHotels.fromJson(responseData).data;
      }
    } catch (error) {
      print("fetching hotels for city: $cityId failed with error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  RxList<Datum?> addressList = <Datum>[].obs;
  RxBool isLoading = false.obs;
  final selectedHouseType = ''.obs;

  TextEditingController address = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController apartment = TextEditingController();

  @override
  void onInit() {
    getAddress();
    super.onInit();
  }

  Future<void> getAddress() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar(
        "Unauthorized",
        "User not found. Please login again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
      isLoading.value = false;
      return;
    }

    try {
      final response = await http
          .get(
            Uri.parse("${ApiConstant.baseUrl}/api/v1/user/getAddress"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 30),
          ); // Set a timeout duration (e.g., 30 seconds)

      print("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        AddressModel addressModel = AddressModel.fromJson(responseData);
        addressList.value = addressModel.data!;
      } else {
        print("Error response: ${response.body}");
        Get.snackbar(
          "Error",
          "Failed to fetch Address: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (error) {
      print("Error $error");
      Get.snackbar("Error", "An error occurred while fetching Address");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAdress() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar(
        "Unauthorized",
        "User not found. Please login again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );

      isLoading.value = false;
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/address/new"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },

        body: json.encode({
          "street": street.text.trim(),
          "houseFlat": apartment.text.trim(),
          "city": postCode.text.trim(),
          "landMark": address.text.trim(),
          "houseType": selectedHouseType.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Address updated successfully.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        await getAddress();
      } else {
        Get.snackbar(
          "Error",
          "Failed to update profile: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (error) {
      print("Error $error");
      Get.snackbar(
        "Error",
        "Failed to update profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(String id) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar(
        "Unauthorized",
        "User not found. Please login again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/address/$id"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Address deleted successfully.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        await getAddress();
      } else {
        Get.snackbar(
          "Error",
          "Failed to deleted profile: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (error) {
      print("Error $error");
      Get.snackbar(
        "Error",
        "An error occurred while deleted Adress",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(String id) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar(
        "Unauthorized",
        "User not found. Please login again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.put(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/address/$id"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "street": street.text.trim(),
          "houseFlat": apartment.text.trim(),
          "city": postCode.text.trim(),
          "landMark": address.text.trim(),
          "houseType": selectedHouseType.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Address updated successfully.",

          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        await getAddress();
      } else {
        Get.snackbar(
          "Error",
          "Failed to updated profile: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (error) {
      print("Error $error");
      Get.snackbar(
        "Error",
        "An error occurred while updated Adress",

        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/recent_searches_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchesController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Recent> recentSearches = <Recent>[].obs;
  RxString errorMessage = "".obs;



 @override
 void onInit() {
    super.onInit();
    getRecentSearches();
  }
  

  Future<void> getRecentSearches() async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        //Get.snackbar("Error", errorMessage.value);
      }

      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/most-searched"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        recentSearches.value = RecentKeyword.fromJson(responseData).data;

        Get.snackbar("Success", "Recent Searches fetched successfully.",backgroundColor: Colors.green,
    colorText: Colors.white,);
      } else {
        //Get.snackbar("Error", errorMessage.value);
      }
    } catch (e) {
      print("Recenct Searches Error: $e");

      errorMessage.value = "An error occurred while fetching recent searches.";
    }finally{
      isLoading.value = false;
    }
  }
}

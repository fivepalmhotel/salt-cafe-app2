import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/search_items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ItemSearchController extends GetxController {
  RxList<Datum?> searchList = <Datum>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  var searchText = ''.obs;


   final TextEditingController searchController = TextEditingController();

  Future<void> getProductSearch(String query) async {
    isLoading.value = true;
    errorMessage.value = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    try {
      final response = await http.get(
        Uri.parse(
          "${ApiConstant.baseUrl}/api/v1/user/Category/search?search=$query",
        ),

        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData["data"] != null) {
          SearchItems searchItems = SearchItems.fromJson(responseData);
          searchList.value = searchItems.data;
        } else {
          searchList.clear();
          //errorMessage.value = "Search item not found";
        }
      } else {
        // errorMessage.value =
        //     "Error ${response.statusCode}: ${response.reasonPhrase}";
      }
    } catch (error) {
      //errorMessage.value = "Something went wrong. Please try again.";

      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

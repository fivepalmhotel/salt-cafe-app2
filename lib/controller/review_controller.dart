import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewController extends GetxController {
  RxList<Review> allReviewList = <Review>[].obs;
  RxList<Rating> flattenedRatings = <Rating>[].obs;

  final TextEditingController commentController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  var ratingValue = 1.obs;
  RxString hotelIds = "".obs;
  RxString images = "".obs;
  RxString comment = "".obs;
  RxString date = "".obs;
  RxString type = "".obs;

  @override
  void onInit() {
    super.onInit();
    getReview();
  }

  void flattenAllRatings() {
    flattenedRatings.clear();
    for (var review in allReviewList) {
      if (review.rating != null) {
        flattenedRatings.addAll(review.rating!);
      }
    }
    print("Total ratings count: ${flattenedRatings.length}");
  }

  Future<void> getReview() async {
    isLoading.value = true;
    errorMessage.value = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      errorMessage.value = "Authentication token not found.";
      isLoading.value = false;
      return;
    }

    const url = "${ApiConstant.baseUrl}/api/v1/user/getAllRatings?type=hotel";

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print("Reviews: $responseData");

        if (responseData["data"] != null) {
          allReviewList.value = AllRatings.fromJson(responseData).data;
          flattenAllRatings();
          flattenedRatings.value = flattenedRatings.reversed.toList();
        } else {
          errorMessage.value = "No reviews found.";
        }
      } else {
        errorMessage.value =
            "Failed to fetch reviews. Status code: ${response.statusCode}";
      }
    } on TimeoutException {
      errorMessage.value = "Connection timeout. Please try again.";
    } catch (error) {
      errorMessage.value = "Unexpected error: ${error.toString()}";
      print("Catch error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addReview() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/rating/ratings"),
        body: json.encode({
          "hotelId": hotelIds.value,
          "ratingValue": ratingValue.value,
          "image": images.value,
          "comment": comment.value,
          "date": date.value,
          "type": type.value,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Review submitted',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        await getReview();

        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to submit review',

          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        return false;
      }
    } catch (e) {
      print("Creation error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

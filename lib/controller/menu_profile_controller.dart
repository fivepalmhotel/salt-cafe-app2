import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/controller/upload_image_globle.dart';
import 'package:salt_cafe_app/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final UploadProfileController controller = Get.put(UploadProfileController());

  RxBool isLoading = false.obs;

  /// Observable to hold the profile data
  Rxn<UserProfile> userProfile = Rxn<UserProfile>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("Unauthorized", "Token not found. Please login again.");
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/getProfile"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        userProfile.value = UserProfile.fromJson(jsonResponse);

        print("Error response: ${response.body}");
        // Get.snackbar(
        //   "Error",
        //   "Failed to fetch profile: ${response.statusCode}",
        // );
      }
    } catch (error, stackTrace) {
      print("Error: $error");
      print("Error: $error");
      print("StackTrace: $stackTrace");
      Get.snackbar("Error", "An error occurred while fetching profile");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileWithImage(String token) async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/updateProfile"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields.addAll({
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),

        'bio': bioController.text.trim(),
      });

      // Add image if selected
      if (controller.profileImagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // key your backend expects for image
            controller.profileImagePath.value,
            filename: basename(controller.profileImagePath.value),
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        // You can parse responseJson and update local state here
        Get.snackbar(
          "Success",
          "Profile updated successfully.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP, // Optional: position (TOP/BOTTOM)
          margin: const EdgeInsets.all(10), // Optional: spacing
          borderRadius: 8, // Optional: rounded corners
          duration: const Duration(seconds: 2), // Optional: how long to show
        );

        controller.uploadedImageUrl.value = responseJson['data']['image'] ?? '';
        await getProfile(); // refresh profile after update
      } else {
        print(
          "Failed to update profile: ${response.statusCode} ${response.body}",
        );
        Get.snackbar(
          "Error",
          "Failed to update profile.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP, // Optional
          margin: const EdgeInsets.all(10), // Optional
          borderRadius: 8, // Optional
          duration: const Duration(seconds: 2), // Optional
        );
      }
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar(
        "Error",
        "An error occurred while updating profile.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP, // Optional
        margin: const EdgeInsets.all(10), // Optional
        borderRadius: 8, // Optional
        duration: const Duration(seconds: 2),
      ); // Optional);
    } finally {
      isLoading.value = false;
    }
  }
}

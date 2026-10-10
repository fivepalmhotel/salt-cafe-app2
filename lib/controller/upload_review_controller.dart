import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/upload_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadReviewController extends GetxController {
  var isLoading = false.obs;
  var profileImagePath = ''.obs;
  var uploadedImageUrl = ''.obs;

  final ImagePicker _picker = ImagePicker();

  /// Picks an image and uploads it
  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
        await uploadImage(
          File(pickedFile.path),
        ); // Ensure to await the uploadImage call
      } else {
        Get.snackbar(
          'No image selected',
          'Please choose an image to upload.',

          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Image picking error',
        e.toString(),

        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Uploads image to server
  Future<void> uploadImage(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token') ?? '';
    isLoading(true);
    try {
      final uri = Uri.parse(
        '${ApiConstant.baseUrl}/api/v1/user/upload-id-picture',
      );
      final request = http.MultipartRequest("PUT", uri);
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      } else {
        print("Token missing.");
        Get.snackbar(
          'Error',
          'User not authorized. Please login again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      // Add necessary headers and fields...

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      );

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseData.body);
        uploadedImageUrl.value = jsonResponse['data'][0]['img'];
        Get.snackbar(
          'Success',
          'Image uploaded successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Upload Failed',
          'Server responded: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Upload Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}

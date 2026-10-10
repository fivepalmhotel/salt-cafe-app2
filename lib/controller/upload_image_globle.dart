import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/upload_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProfileController extends GetxController {
 RxString profileImagePath = ''.obs;
  RxString uploadedImageUrl = ''.obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  Future<void> uploadImage(String token) async {
  try {
    if (profileImagePath.isEmpty) {
      Get.snackbar("Error", "No image selected.");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://salt-cafe-backend-project.vercel.app/api/v1/user/uploadImage"),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'image', // the backend expects this key
      profileImagePath.value,
      filename: basename(profileImagePath.value),
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      try {
        final responseJson = jsonDecode(response.body);
        if (responseJson != null && responseJson['data'] != null) {
          uploadedImageUrl.value = responseJson['data']['image'];
          profileImagePath.value = ''; // clear picked image
          Get.snackbar("Success", "Image uploaded.");
        }
      } catch (e) {
        Get.snackbar("Error", "Invalid JSON response");
      }
    } else {
      print("Image upload failed: ${response.body}");
      Get.snackbar("Error", "Image upload failed.");
    }
  } catch (e) {
    print("Upload error: $e");
    Get.snackbar("Error", "Image upload failed.");
  }
}
}

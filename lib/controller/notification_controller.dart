import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllNotificationController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Datum> getNotificationList = <Datum>[].obs;



@override
  void onInit() {
    super.onInit();
    getAllNotificationList();
  }


  Future<void> getAllNotificationList() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/notifications/user"),
        headers: {
          "Application-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        //print(responseData);

        // Use the model's fromJson factory method
        AllNotification notifications = AllNotification.fromJson(responseData);
        getNotificationList.value = notifications.data ?? [];
      } else {
        // Handle unexpected response status here (optional)
        print('Failed to load notifications: ${response.statusCode}');
      }
    } catch (error) {
      print("Notification error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

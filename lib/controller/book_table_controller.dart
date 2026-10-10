import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/history_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/table_booking_model.dart';

class BookTableController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController bookNumberTable = TextEditingController();
  TextEditingController dateController = TextEditingController();
  RxString bookingDate = ''.obs;
  RxString timeSlot = ''.obs;
  RxString specialRequest = ''.obs;
  RxString hotelId = ''.obs;
  RxList<History> orderHistory = <History>[].obs;

  var tabalBooking = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllBooking();
    getOrderHistory();
  }

  Future<void> getBookTable() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("No token found");
        return;
      }
      if (hotelId.value.isEmpty ||
          bookNumberTable.text.isEmpty ||
          bookingDate.value.isEmpty ||
          timeSlot.value.isEmpty) {
        print("Missing fields: can't submit");
        return;
      }
      final response = await http.post(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/table/booking"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "hotelId": hotelId.value,
          "numberOfGuests": int.tryParse(bookNumberTable.text) ?? 1,
          "bookingDate": bookingDate.value,
          "timeSlot": timeSlot.value,
          "specialRequest": specialRequest.value,
        }),
      );

      if (response.statusCode == 201) {
        await getAllBooking();
        print("Booking Success: ${response.body}");
      } else {
        print("Booking Failed: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllBooking() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("No token found");
        return;
      }

      final response = await http.get(
        Uri.parse(
          "${ApiConstant.baseUrl}/api/v1/user/table/booking/my-bookings",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Response Data: $responseData");

        tabalBooking.value = TableBookingModel.fromJson(responseData).data;

        print("Booking List: ${response.body}");
      } else {
        print("Failed to fetch booking list: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOrderHistory() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/getOngoingOrders"),

        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        orderHistory.value = HistoyOfOreder.fromJson(responseData).data;
      }
    } catch (e) {}
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/offer_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllOfferController extends GetxController {
  RxList<Service> offerList = <Service>[].obs;
  RxBool isLoading = false.obs;




  @override
  void onInit() {
   getAllOffer();
    super.onInit();
  }

  Future<void> getAllOffer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/admin/Offer/listOffer"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );//print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Assuming the offers are in responseData["data"]
        if (responseData["service"] != null) {
         offerList.value = List<Service>.from(
  responseData['service'].map((item) => Service.fromJson(item)),
);

        }

       // print("✅ Offers fetched: ${offerList.length}");
      } else {
        //print("❌ Failed to fetch offers. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("❌ Error: $error");
    }
  }
}

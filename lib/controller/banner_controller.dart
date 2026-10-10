import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/banner_offer_model.dart';

class BannerController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Banner> offerBanners = <Banner>[].obs;
  RxString errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    getBanners();
  }

  Future<void> getBanners() async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/admin/Banner/allBanner"),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        offerBanners.value = BannerOffer.fromJson(jsonResponse).data;
      } else {
        errorMessage.value =
            "Failed to fetch banners. Status code: ${response.statusCode}";
        print(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Error getting banners: $e";
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}

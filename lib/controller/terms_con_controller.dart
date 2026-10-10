import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/about_us_model.dart';
import 'package:salt_cafe_app/models/terms_conditation_model.dart';

class TermsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Terms> getTerms = <Terms>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTermsData();
  }

  Future<void> getTermsData() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/static/getTerms"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        TermsModel termsConditationModel = TermsModel.fromJson(data);

        getTerms.value = termsConditationModel.data;
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}

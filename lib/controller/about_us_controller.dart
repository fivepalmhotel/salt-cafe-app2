import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/models/about_us_model.dart';
import 'package:salt_cafe_app/models/faq_model.dart';

class AboutUsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<About> getAboutUs = <About>[].obs;
  RxList<Faq> getFaq = <Faq>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAboutUsData();
    getFaqData();
  }

  Future<void> getAboutUsData() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/static/getAboutUs"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        AboutUsModel aboutUsModel = AboutUsModel.fromJson(data);

        getAboutUs.value = aboutUsModel.data;
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

Future<void> getFaqData() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/static/faq/All"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        FaqModel faqModel = FaqModel.fromJson(data);

        getFaq.value = faqModel.data;
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }




}

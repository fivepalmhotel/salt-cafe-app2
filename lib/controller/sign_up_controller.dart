import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salt_cafe_app/api_constant.dart/api_base_url.dart';
import 'package:salt_cafe_app/restaurent/nav_baar.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController loginPhoneController = TextEditingController();

  RxString userData = "".obs;
  RxBool isLoginFlow = false.obs;
  RxInt secondsRemaining = 60.obs;
  final RxBool isResendLoading = false.obs;

  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  void startTimer() {
    secondsRemaining.value = 60;
    isResendEnabled.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendEnabled.value = true;
        _timer?.cancel();
      }
    });
  }

  //   Future<void> resendOtp() async {
  //   isResendLoading.value = true;
  //   await login(); // or await signUp();
  //   startTimer();
  //   isResendLoading.value = false;
  // }
  Future<void> resendOtp() async {
    await login(useResendLoading: true);
    startTimer();
  }

  // State variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString otpCode = ''.obs;
  final RxBool isOtpSent = false.obs;
  final RxString? userId = ''.obs;
  final int otpLength = 4; // Or however many digits your OTP has
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  // Constants

  @override
  void onInit() {
    otpControllers = List.generate(
      otpLength,
      (index) => TextEditingController(),
    );
    focusNodes = List.generate(otpLength, (index) => FocusNode());
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    // nameController.dispose();
    // phoneController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<bool> signUp() async {
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final fullName = nameController.text.trim();
      final phone = phoneController.text.trim();

      // Validation
      if (fullName.isEmpty || phone.isEmpty) {
        errorMessage.value = 'Please fill in all fields';
        return false;
      }

      if (phone.length < 10) {
        errorMessage.value = 'Phone number must be at least 10 digits';
        return false;
      }

      print('Sending fullName: $fullName');
      print('Sending phone: $phone');

      final response = await http.post(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/signupWithPhone"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"fullName": fullName, "phone": phone}),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        // If the phone number is not registered, create a new user
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userId", responseData['data']['id']);
        otpCode.value = responseData['data']['otp']?.toString() ?? '';
        isOtpSent.value = true;

        _showOtpSnackbar(otpCode.value);
        return true;
      } else if (responseData['error'] == "Phone number already registered") {
        // If the phone number is already registered, suggest login
        errorMessage.value =
            'Phone number already registered. Please login instead.';
        return false;
      } else {
        // Handle other errors from API
        _handleApiError(responseData, response.statusCode);
        return false;
      }
    } on SocketException {
      errorMessage.value = 'No internet connection';
      return false;
    } on TimeoutException {
      errorMessage.value = 'Request timed out';
      return false;
    } catch (e) {
      _handleNetworkError(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _showOtpSnackbar(String otp) {
    Get.snackbar(
      "OTP Received",
      "Your OTP is: $otp",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
    );
  }

  void _handleApiError(Map<String, dynamic> errorData, int statusCode) {
    errorMessage.value =
        errorData["message"] ??
        'Sign up failed (Status: $statusCode). Please try again.';

    if (statusCode == 400) {
      errorMessage.value = 'Invalid phone number format';
    } else if (statusCode == 409) {
      errorMessage.value = 'User already exists';
    }
  }

  void _handleNetworkError(Object e) {
    errorMessage.value = 'Network error occurred. Please try again.';
    debugPrint('SignUp Error: ${e.toString()}');
  }

  Future<bool> otpVerifye() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdStored = prefs.getString("userId");
    final String enteredOtp = otpControllers.map((c) => c.text).join();

    if (enteredOtp.length != otpLength) {
      Get.snackbar("Error", "Please enter a valid OTP");
      isLoading.value = false;
      return false;
    }

    try {
      http.Response response;
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "otp": enteredOtp,
        "deviceToken": "", // optional
      };

      if (isLoginFlow.value) {
        // LOGIN FLOW
        response = await http.post(
          Uri.parse("${ApiConstant.baseUrl}/api/v1/user/verifyLoginOtp"),
          headers: headers,
          body: json.encode({...body, "phone": phoneController.text.trim()}),
        );
      } else {
        // SIGN-UP FLOW
        if (userIdStored == null || userIdStored.isEmpty) {
          // Get.snackbar(
          //   "Error",
          //   "User ID not found. Please register again.",
          //   backgroundColor: Colors.red,
          //   colorText: Colors.white,
          // );
          isLoading.value = false;
          return false;
        }

        response = await http.post(
          Uri.parse("${ApiConstant.baseUrl}/api/v1/user/$userIdStored"),
          headers: headers,
          body: json.encode(body),
        );
      }

      final responseData = json.decode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200 && responseData["data"] != null) {
        final String token = responseData["data"]["token"];
        final String responseUserId = responseData["data"]["userId"];

        await prefs.setString("token", token);
        await prefs.setString("userId", responseUserId);
        print("Saved token: $token");

        Get.offAll(() => BottomNavBar());
        Get.snackbar(
          "Success",
          responseData["message"] ?? "Logged in",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          responseData["message"] ?? "Invalid OTP",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("OTP verification error: $e");
      return false;
    }
  }

  Future<bool> login({bool useResendLoading = false}) async {
    if (useResendLoading) {
      isResendLoading.value = true;
    } else {
      isLoading.value = true;
    }
    // isLoading.value = true;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");
      print("token: $token");

      final response = await http.post(
        Uri.parse("${ApiConstant.baseUrl}/api/v1/user/loginWithPhone"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({"phone": loginPhoneController.text.trim()}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        userData.value = responseData["data"]["phone"];

        otpCode.value = responseData['data']['otp']?.toString() ?? '';
        await prefs.setString("userId", responseData['data']['id']);

        isOtpSent.value = true;
        _showOtpSnackbar(otpCode.value);
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        // Get.snackbar(
        //   "Error",
        //   errorResponse["message"] ?? "Something went wrong",
        // );
        return false;
      }
    } catch (e) {
      //Get.snackbar("Exception", e.toString());
      return false;
    } finally {
      if (useResendLoading) {
        isResendLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('userId');

      print("✅ Logout successful. Navigating to LoginScreen...");
      Get.snackbar(
        'Logout',
        'You have been logged out successfully.',

        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
        margin: const EdgeInsets.all(12), // optional
        borderRadius: 8, // optional
      );

      // Navigate to LoginScreen
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print("❌ Logout error: $e");
      Get.snackbar(
        'Error',
        'Logout failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
        margin: const EdgeInsets.all(12), // optional
        borderRadius: 8, // optional
      );
    }
  }
}

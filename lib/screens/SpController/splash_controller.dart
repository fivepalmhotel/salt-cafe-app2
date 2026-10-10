import 'package:get/get.dart';
import 'package:salt_cafe_app/controller/auth_check_controller.dart';
import 'package:salt_cafe_app/restaurent/nav_baar.dart';
import 'package:salt_cafe_app/screens/login_page.dart';
import 'package:salt_cafe_app/screens/reserve_your_table.dart';
import 'package:salt_cafe_app/screens/sign_in_screen.dart';

class SplashScreenController extends GetxController {
  final AuthCheckController _authController = Get.put(AuthCheckController());

  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

 void navigateToHome() async {
  await Future.delayed(const Duration(milliseconds: 500));

  await _authController.checkLoginStatus();

  if (_authController.isLoggedIn.value) {
    Get.offAll(() => ReserveYourTable()); // ✅ Send to home
  } else {
    Get.offAll(() => LoginScreen()); // ✅ Send to login
  }
}
}
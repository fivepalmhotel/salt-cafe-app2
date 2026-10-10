import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckController extends GetxController {
  final RxBool isLoggedIn = false.obs;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Stored token: ${prefs.getString('token')}');
    isLoggedIn.value = token != null && token.isNotEmpty;
  }
}
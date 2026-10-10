import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialController extends GetxController {
  /// Open Instagram profile in external browser/app
  Future<void> openInstagram(String profileUrl) async {
    final Uri uri = Uri.parse(profileUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open Instagram');
    }
  }

  // You can extend this for other platforms too
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not launch link');
    }
  }



   Future<void> openWhatsApp(String phoneNumber, String message) async {
    final encodedMessage = Uri.encodeComponent(message);
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber?text=$encodedMessage");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open WhatsApp');
    }
  }



   Future<void> openFacebook(String pageUrl) async {
    final Uri uri = Uri.parse(pageUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open Facebook');
    }
  }
}

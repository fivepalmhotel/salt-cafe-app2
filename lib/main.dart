import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/controller/auth_check_controller.dart';
import 'package:salt_cafe_app/screens/SpController/splash_controller.dart';

import 'screens/SpController/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Get.put(CartController());
  // Disable verbose logging from Google Maps
  // AndroidGoogleMapsFlutter.useAndroidViewSurface = false;

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          initialBinding: BindingsBuilder(() {
            
             Get.put(AuthCheckController());
            Get.put(SplashScreenController());
          }),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          // home: const BookYourTable(),
        );
      },
    );
  }
}

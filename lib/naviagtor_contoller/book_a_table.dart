import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../restaurent/book_table.dart';
import '../restaurent/book_your_table.dart';



class BookYourTableNavigator extends StatelessWidget {
  const BookYourTableNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1), // Unique Key for Book Your Table
      initialRoute: '/book_table',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/book_table':
            return GetPageRoute(page: () => const BookYourTable());
          case '/book_table_details':
            return GetPageRoute(page: () => const BookTable());
          default:
            return GetPageRoute(page: () => const BookYourTable());
        }
      },
    );
  }
}

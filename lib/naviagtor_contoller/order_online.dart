import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../order_online/food_category.dart';
import '../order_online/order_online.dart';
import '../order_online/popular_pizza.dart';
import '../order_online/populor_burgers.dart';

class OrderOnlineNavigator extends StatelessWidget {
  const OrderOnlineNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(2), // Unique Key for Order Online
      initialRoute: '/order_online',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/order_online':
            return GetPageRoute(page: () => const OrderOnline());
          case '/food_category':
            return GetPageRoute(
                transitionDuration: const Duration(seconds: 3),
                transition: Transition.upToDown,
                page: () =>  FoodCategory());
          case '/popular_pizza':
            return GetPageRoute(
                transitionDuration: const Duration(seconds: 3),
                transition: Transition.upToDown,
                page: () => const PopularPizza());
          // case '/popular_burger':
          //   return GetPageRoute(
          //       transitionDuration: const Duration(seconds: 3),
          //       transition: Transition.upToDown,
          //       page: () => const PopularBurgers());
          default:
            return GetPageRoute(page: () => const OrderOnline(),);
        }
      },
    );
  }
}

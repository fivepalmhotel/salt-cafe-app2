import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:salt_cafe_app/controller/cart_controller.dart';
import 'package:salt_cafe_app/controller/payment_gatway_controller.dart';
import 'package:salt_cafe_app/order_online/my_cart.dart';
import 'package:salt_cafe_app/restaurent/nav_baar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final AddToCartController cartController = Get.find<AddToCartController>();
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay()
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handleError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Wait for first frame and then open Razorpay
    Future.delayed(Duration.zero, () {
      final getData = cartController.getCart.value;
      final paymentData = paymentController.createdOrder;

      if (getData == null || getData.services.isEmpty || paymentData.isEmpty) {
        Get.snackbar("Error", "Cart or payment data is missing");
        return;
      }

      final totalPrice = getData.totalAmount ?? 0;
      if (totalPrice <= 0) {
        Get.snackbar("Error", "Cart total must be greater than ₹0");
        return;
      }

      final service = getData.services[0].serviceId;
      final description = service.description ?? "Service Payment";
      final title = service.title ?? "Salt Café Service";
      final orderId = paymentData["orderId"];

      var options = {
        'key': 'rzp_test_YqrqeMwiEuLkKZ', // Replace with your live Razorpay key in production
        'amount': (totalPrice * 100).toInt(), // Razorpay accepts amount in paise
        'name': title,
        'description': description,
        'orderId': orderId,
        'prefill': {
          'contact': '9123456789',
          'email': 'test@example.com',
        },
        'currency': 'INR',
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint("Razorpay open error: $e");
      }
    });
  }

 void _handleSuccess(PaymentSuccessResponse response) async {
  bool orderPlaced = await paymentController.placeOrderAfterPayment();
  if (orderPlaced) {
    cartController.clearCart(); // ✅ Manually clear cart data
    Get.to(() => const BottomNavBar(initialIndex: 1));
  } else {
    Get.snackbar("Error", "Payment succeeded but order placement failed.");
  }
}


  
  void _handleError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "Try again");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //appBar: AppBar(title: const Text("Processing Payment...")),
      body:  Center(
        child: CircularProgressIndicator(), // Optional loading spinner
      ),
    );
  }
}

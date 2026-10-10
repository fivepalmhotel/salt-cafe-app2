import 'package:get/get.dart';
import '../models/card_model.dart';

class AddCardViewModel extends GetxController {
  var cardHolderName = ''.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cvc = ''.obs;

  void addCard() {
    final card = CardModel(
      cardHolderName: cardHolderName.value,
      cardNumber: cardNumber.value,
      expiryDate: expiryDate.value,
      cvc: cvc.value,
    );
    print('Card Added: ${card.cardHolderName}');
  }
}

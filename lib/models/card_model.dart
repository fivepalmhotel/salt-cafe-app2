class CardModel {
  String cardHolderName;
  String cardNumber;
  String expiryDate;
  String cvc;

  CardModel({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
  });
}
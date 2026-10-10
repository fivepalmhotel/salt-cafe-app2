// To parse this JSON data, do
//
//     final cardDetailModel = cardDetailModelFromJson(jsonString);

import 'dart:convert';

CardDetailModel cardDetailModelFromJson(String str) => CardDetailModel.fromJson(json.decode(str));

String cardDetailModelToJson(CardDetailModel data) => json.encode(data.toJson());

class CardDetailModel {
    int status;
    List<Datum> data;

    CardDetailModel({
        required this.status,
        required this.data,
    });

    factory CardDetailModel.fromJson(Map<String, dynamic> json) => CardDetailModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String user;
    String cardNumber;
    String cardHolderName;
    String expiryDate;
    String cvv;
    bool isDefault;
    bool isCarSaved;
    int v;

    Datum({
        required this.id,
        required this.user,
        required this.cardNumber,
        required this.cardHolderName,
        required this.expiryDate,
        required this.cvv,
        required this.isDefault,
        required this.isCarSaved,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        user: json["user"],
        cardNumber: json["cardNumber"],
        cardHolderName: json["cardHolderName"],
        expiryDate: json["expiryDate"],
        cvv: json["cvv"],
        isDefault: json["isDefault"],
        isCarSaved: json["isCarSaved"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "cardNumber": cardNumber,
        "cardHolderName": cardHolderName,
        "expiryDate": expiryDate,
        "cvv": cvv,
        "isDefault": isDefault,
        "isCarSaved": isCarSaved,
        "__v": v,
    };
}

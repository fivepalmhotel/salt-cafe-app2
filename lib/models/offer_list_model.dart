// To parse this JSON data, do
//
//     final listOfferModel = listOfferModelFromJson(jsonString);

import 'dart:convert';

ListOfferModel listOfferModelFromJson(String str) => ListOfferModel.fromJson(json.decode(str));

String listOfferModelToJson(ListOfferModel data) => json.encode(data.toJson());

class ListOfferModel {
    int status;
    String message;
    List<Service> service;

    ListOfferModel({
        required this.status,
        required this.message,
        required this.service,
    });

    factory ListOfferModel.fromJson(Map<String, dynamic> json) => ListOfferModel(
        status: json["status"],
        message: json["message"],
        service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "service": List<dynamic>.from(service.map((x) => x.toJson())),
    };
}

class Service {
    String id;
    dynamic userId;
    List<dynamic> user;
    String couponCode;
    String title;
    String description;
    int amount;
    DateTime expirationDate;
    DateTime activationDate;
    String image;
    bool status;
    int v;

    Service({
        required this.id,
        required this.userId,
        required this.user,
        required this.couponCode,
        required this.title,
        required this.description,
        required this.amount,
        required this.expirationDate,
        required this.activationDate,
        required this.image,
        required this.status,
        required this.v,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        userId: json["userId"],
        user: List<dynamic>.from(json["user"].map((x) => x)),
        couponCode: json["couponCode"],
        title: json["title"],
        description: json["description"],
        amount: json["amount"],
        expirationDate: DateTime.parse(json["expirationDate"]),
        activationDate: DateTime.parse(json["activationDate"]),
        image: json["image"],
        status: json["status"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "user": List<dynamic>.from(user.map((x) => x)),
        "couponCode": couponCode,
        "title": title,
        "description": description,
        "amount": amount,
        "expirationDate": expirationDate.toIso8601String(),
        "activationDate": activationDate.toIso8601String(),
        "image": image,
        "status": status,
        "__v": v,
    };
}

// To parse this JSON data, do
//
//     final addItem = addItemFromJson(jsonString);

import 'dart:convert';

AddItem addItemFromJson(String str) => AddItem.fromJson(json.decode(str));

String addItemToJson(AddItem data) => json.encode(data.toJson());

class AddItem {
    int status;
    String message;
    Data data;

    AddItem({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddItem.fromJson(Map<String, dynamic> json) => AddItem(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String userId;
    List<dynamic> charges;
    int tipProvided;
    bool tip;
    bool coupanUsed;
    bool offerUsed;
    bool walletUsed;
    int wallet;
    int offer;
    int coupan;
    List<Service> services;
    int totalAmount;
    int additionalFee;
    int paidAmount;
    int totalItem;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.id,
        required this.userId,
        required this.charges,
        required this.tipProvided,
        required this.tip,
        required this.coupanUsed,
        required this.offerUsed,
        required this.walletUsed,
        required this.wallet,
        required this.offer,
        required this.coupan,
        required this.services,
        required this.totalAmount,
        required this.additionalFee,
        required this.paidAmount,
        required this.totalItem,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        charges: List<dynamic>.from(json["Charges"].map((x) => x)),
        tipProvided: json["tipProvided"],
        tip: json["tip"],
        coupanUsed: json["coupanUsed"],
        offerUsed: json["offerUsed"],
        walletUsed: json["walletUsed"],
        wallet: json["wallet"],
        offer: json["offer"],
        coupan: json["coupan"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        totalAmount: json["totalAmount"],
        additionalFee: json["additionalFee"],
        paidAmount: json["paidAmount"],
        totalItem: json["totalItem"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "Charges": List<dynamic>.from(charges.map((x) => x)),
        "tipProvided": tipProvided,
        "tip": tip,
        "coupanUsed": coupanUsed,
        "offerUsed": offerUsed,
        "walletUsed": walletUsed,
        "wallet": wallet,
        "offer": offer,
        "coupan": coupan,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "additionalFee": additionalFee,
        "paidAmount": paidAmount,
        "totalItem": totalItem,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Service {
    String serviceId;
    int price;
    int quantity;
    int total;
    String id;

    Service({
        required this.serviceId,
        required this.price,
        required this.quantity,
        required this.total,
        required this.id,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["serviceId"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "price": price,
        "quantity": quantity,
        "total": total,
        "_id": id,
    };
}

// To parse this JSON data, do
//
//     final placeOrder = placeOrderFromJson(jsonString);

import 'dart:convert';

PlaceOrder placeOrderFromJson(String str) => PlaceOrder.fromJson(json.decode(str));

String placeOrderToJson(PlaceOrder data) => json.encode(data.toJson());

class PlaceOrder {
    String message;
    int status;
    Data data;

    PlaceOrder({
        required this.message,
        required this.status,
        required this.data,
    });

    factory PlaceOrder.fromJson(Map<String, dynamic> json) => PlaceOrder(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    PartnerLocation partnerLocation;
    String id;
    String orderId;
    String userId;
    List<dynamic> freeService;
    List<dynamic> charges;
    int tipProvided;
    bool tip;
    bool freeServiceUsed;
    bool coupanUsed;
    bool offerUsed;
    bool walletUsed;
    int wallet;
    int coupan;
    int offer;
    int freeServiceCount;
    List<Service> services;
    int totalAmount;
    int additionalFee;
    int paidAmount;
    int totalItem;
    String orderStatus;
    String serviceStatus;
    String status;
    String paymentStatus;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String transctionId;

    Data({
        required this.partnerLocation,
        required this.id,
        required this.orderId,
        required this.userId,
        required this.freeService,
        required this.charges,
        required this.tipProvided,
        required this.tip,
        required this.freeServiceUsed,
        required this.coupanUsed,
        required this.offerUsed,
        required this.walletUsed,
        required this.wallet,
        required this.coupan,
        required this.offer,
        required this.freeServiceCount,
        required this.services,
        required this.totalAmount,
        required this.additionalFee,
        required this.paidAmount,
        required this.totalItem,
        required this.orderStatus,
        required this.serviceStatus,
        required this.status,
        required this.paymentStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.transctionId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        partnerLocation: PartnerLocation.fromJson(json["partnerLocation"]),
        id: json["_id"],
        orderId: json["orderId"],
        userId: json["userId"],
        freeService: List<dynamic>.from(json["freeService"].map((x) => x)),
        charges: List<dynamic>.from(json["Charges"].map((x) => x)),
        tipProvided: json["tipProvided"],
        tip: json["tip"],
        freeServiceUsed: json["freeServiceUsed"],
        coupanUsed: json["coupanUsed"],
        offerUsed: json["offerUsed"],
        walletUsed: json["walletUsed"],
        wallet: json["wallet"],
        coupan: json["coupan"],
        offer: json["offer"],
        freeServiceCount: json["freeServiceCount"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        totalAmount: json["totalAmount"],
        additionalFee: json["additionalFee"],
        paidAmount: json["paidAmount"],
        totalItem: json["totalItem"],
        orderStatus: json["orderStatus"],
        serviceStatus: json["serviceStatus"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        transctionId: json["transctionId"],
    );

    Map<String, dynamic> toJson() => {
        "partnerLocation": partnerLocation.toJson(),
        "_id": id,
        "orderId": orderId,
        "userId": userId,
        "freeService": List<dynamic>.from(freeService.map((x) => x)),
        "Charges": List<dynamic>.from(charges.map((x) => x)),
        "tipProvided": tipProvided,
        "tip": tip,
        "freeServiceUsed": freeServiceUsed,
        "coupanUsed": coupanUsed,
        "offerUsed": offerUsed,
        "walletUsed": walletUsed,
        "wallet": wallet,
        "coupan": coupan,
        "offer": offer,
        "freeServiceCount": freeServiceCount,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "additionalFee": additionalFee,
        "paidAmount": paidAmount,
        "totalItem": totalItem,
        "orderStatus": orderStatus,
        "serviceStatus": serviceStatus,
        "status": status,
        "paymentStatus": paymentStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "transctionId": transctionId,
    };
}

class PartnerLocation {
    String type;
    List<int> coordinates;

    PartnerLocation({
        required this.type,
        required this.coordinates,
    });

    factory PartnerLocation.fromJson(Map<String, dynamic> json) => PartnerLocation(
        type: json["type"],
        coordinates: List<int>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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

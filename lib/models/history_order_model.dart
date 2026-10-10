// To parse this JSON data, do
//
//     final histoyOfOreder = histoyOfOrederFromJson(jsonString);

import 'dart:convert';

HistoyOfOreder histoyOfOrederFromJson(String str) => HistoyOfOreder.fromJson(json.decode(str));

String histoyOfOrederToJson(HistoyOfOreder data) => json.encode(data.toJson());

class HistoyOfOreder {
    String message;
    List<History> data;

    HistoyOfOreder({
        required this.message,
        required this.data,
    });

    factory HistoyOfOreder.fromJson(Map<String, dynamic> json) => HistoyOfOreder(
        message: json["message"],
        data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class History {
    Location partnerLocation;
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

    History({
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

    factory History.fromJson(Map<String, dynamic> json) => History(
        partnerLocation: Location.fromJson(json["partnerLocation"]),
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

class Location {
    String type;
    List<double> coordinates;

    Location({
        required this.type,
        required this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Service {
    ServiceId serviceId;
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
        serviceId: ServiceId.fromJson(json["serviceId"]),
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "serviceId": serviceId.toJson(),
        "price": price,
        "quantity": quantity,
        "total": total,
        "_id": id,
    };
}

class ServiceId {
    Location currentLocation;
    String size;
    String id;
    String mainCategoryId;
    String city;
    String title;
    String description;
    int timeInMin;
    String totalTime;
    List<Image> images;
    int originalPrice;
    bool discountActive;
    int discount;
    int discountPrice;
    int rating;
    int sellCount;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    ServiceId({
        required this.currentLocation,
        required this.size,
        required this.id,
        required this.mainCategoryId,
        required this.city,
        required this.title,
        required this.description,
        required this.timeInMin,
        required this.totalTime,
        required this.images,
        required this.originalPrice,
        required this.discountActive,
        required this.discount,
        required this.discountPrice,
        required this.rating,
        required this.sellCount,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
        currentLocation: Location.fromJson(json["currentLocation"]),
        size: json["size"],
        id: json["_id"],
        mainCategoryId: json["mainCategoryId"],
        city: json["city"],
        title: json["title"],
        description: json["description"],
        timeInMin: json["timeInMin"],
        totalTime: json["totalTime"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        originalPrice: json["originalPrice"],
        discountActive: json["discountActive"],
        discount: json["discount"],
        discountPrice: json["discountPrice"],
        rating: json["rating"],
        sellCount: json["sellCount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "currentLocation": currentLocation.toJson(),
        "size": size,
        "_id": id,
        "mainCategoryId": mainCategoryId,
        "city": city,
        "title": title,
        "description": description,
        "timeInMin": timeInMin,
        "totalTime": totalTime,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "originalPrice": originalPrice,
        "discountActive": discountActive,
        "discount": discount,
        "discountPrice": discountPrice,
        "rating": rating,
        "sellCount": sellCount,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Image {
    String img;
    String id;

    Image({
        required this.img,
        required this.id,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        img: json["img"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
    };
}

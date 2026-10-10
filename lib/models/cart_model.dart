// To parse this JSON data, do
//
//     final addToCart = addToCartFromJson(jsonString);

import 'dart:convert';

GetToCart addToCartFromJson(String str) => GetToCart.fromJson(json.decode(str));

String addToCartToJson(GetToCart data) => json.encode(data.toJson());

class GetToCart {
    String message;
    int status;
    ServiceData data;

    GetToCart({
        required this.message,
        required this.status,
        required this.data,
    });

    factory GetToCart.fromJson(Map<String, dynamic> json) => GetToCart(
        message: json["message"],
        status: json["status"],
        data: ServiceData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}

class ServiceData {
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
    int totalOriginalPrice;
    int totalDiscountPrice;

    ServiceData({
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
        required this.totalOriginalPrice,
        required this.totalDiscountPrice,
    });

    factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
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
        totalOriginalPrice: json["totalOriginalPrice"],
        totalDiscountPrice: json["totalDiscountPrice"],
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
        "totalOriginalPrice": totalOriginalPrice,
        "totalDiscountPrice": totalDiscountPrice,
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
    CurrentLocation currentLocation;
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
        currentLocation: CurrentLocation.fromJson(json["currentLocation"]),
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

class CurrentLocation {
    String type;
    List<double> coordinates;

    CurrentLocation({
        required this.type,
        required this.coordinates,
    });

    factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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

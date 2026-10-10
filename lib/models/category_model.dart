// To parse this JSON data, do
//
//     final foodCategoryDetails = foodCategoryDetailsFromJson(jsonString);

import 'dart:convert';

FoodCategoryDetails foodCategoryDetailsFromJson(String str) => FoodCategoryDetails.fromJson(json.decode(str));

String foodCategoryDetailsToJson(FoodCategoryDetails data) => json.encode(data.toJson());

class FoodCategoryDetails {
    String message;
    int status;
    OfferData data;

    FoodCategoryDetails({
        required this.message,
        required this.status,
        required this.data,
    });

    factory FoodCategoryDetails.fromJson(Map<String, dynamic> json) => FoodCategoryDetails(
        message: json["message"],
        status: json["status"],
        data: OfferData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}

class OfferData {
    CurrentLocation currentLocation;
    String size;
    String id;
    City mainCategoryId;
    City city;
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
    bool isInCart;
    int cartQuantity;

    OfferData({
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
        required this.isInCart,
        required this.cartQuantity,
    });

    factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
        currentLocation: CurrentLocation.fromJson(json["currentLocation"]),
        size: json["size"],
        id: json["_id"],
        mainCategoryId: City.fromJson(json["mainCategoryId"]),
        city: City.fromJson(json["city"]),
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
        isInCart: json["isInCart"],
        cartQuantity: json["cartQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "currentLocation": currentLocation.toJson(),
        "size": size,
        "_id": id,
        "mainCategoryId": mainCategoryId.toJson(),
        "city": city.toJson(),
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
        "isInCart": isInCart,
        "cartQuantity": cartQuantity,
    };
}

class City {
    String id;
    String name;
    String image;

    City({
        required this.id,
        required this.name,
        required this.image,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
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

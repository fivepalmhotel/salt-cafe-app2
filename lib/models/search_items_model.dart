// To parse this JSON data, do
//
//     final searchItems = searchItemsFromJson(jsonString);

import 'dart:convert';

SearchItems searchItemsFromJson(String str) => SearchItems.fromJson(json.decode(str));

String searchItemsToJson(SearchItems data) => json.encode(data.toJson());

class SearchItems {
    int status;
    String message;
    int count;
    List<Datum?> data;

    SearchItems({
        required this.status,
        required this.message,
        required this.count,
        required this.data,
    });

    factory SearchItems.fromJson(Map<String, dynamic> json) => SearchItems(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x!.toJson())),
    };
}

class Datum {
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
    CurrentLocation currentLocation;
    MainCategory mainCategory;

    Datum({
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
        required this.currentLocation,
        required this.mainCategory,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        currentLocation: CurrentLocation.fromJson(json["currentLocation"]),
        mainCategory: MainCategory.fromJson(json["mainCategory"]),
    );

    Map<String, dynamic> toJson() => {
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
        "currentLocation": currentLocation.toJson(),
        "mainCategory": mainCategory.toJson(),
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

class MainCategory {
    String id;
    String name;
    String image;
    int averageRating;
    int totalRating;
    bool status;
    bool isPromote;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    MainCategory({
        required this.id,
        required this.name,
        required this.image,
        required this.averageRating,
        required this.totalRating,
        required this.status,
        required this.isPromote,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        averageRating: json["averageRating"],
        totalRating: json["totalRating"],
        status: json["status"],
        isPromote: json["isPromote"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "averageRating": averageRating,
        "totalRating": totalRating,
        "status": status,
        "isPromote": isPromote,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

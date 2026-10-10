// To parse this JSON data, do
//
//     final foodCategory = foodCategoryFromJson(jsonString);

import 'dart:convert';

FoodCategory foodCategoryFromJson(String str) => FoodCategory.fromJson(json.decode(str));

String foodCategoryToJson(FoodCategory data) => json.encode(data.toJson());

class FoodCategory {
    String message;
    int status;
    List<Datum> data;

    FoodCategory({
        required this.message,
        required this.status,
        required this.data,
    });

    factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        message: json["message"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
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

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

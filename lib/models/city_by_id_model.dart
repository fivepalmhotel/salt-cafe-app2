// To parse this JSON data, do
//
//     final cityModelById = cityModelByIdFromJson(jsonString);

import 'dart:convert';

CityModelById cityModelByIdFromJson(String str) => CityModelById.fromJson(json.decode(str));

String cityModelByIdToJson(CityModelById data) => json.encode(data.toJson());

class CityModelById {
    int status;
    String message;
    Data data;

    CityModelById({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CityModelById.fromJson(Map<String, dynamic> json) => CityModelById(
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
    String name;
    String image;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.id,
        required this.name,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

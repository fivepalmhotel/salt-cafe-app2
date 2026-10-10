// To parse this JSON data, do
//
//     final uploadImage = uploadImageFromJson(jsonString);

import 'dart:convert';

UploadResponse uploadImageFromJson(String str) => UploadResponse.fromJson(json.decode(str));

String uploadImageToJson(UploadResponse data) => json.encode(data.toJson());

class UploadResponse {
    int status;
    String message;
    List<Datum> data;

    UploadResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String img;
    String id;

    Datum({
        required this.img,
        required this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        img: json["img"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
    };
}

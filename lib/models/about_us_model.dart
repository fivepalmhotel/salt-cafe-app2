// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
    int status;
    String message;
    List<About> data;

    AboutUsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        status: json["status"],
        message: json["message"],
        data: List<About>.from(json["data"].map((x) => About.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class About {
    String id;
    String title;
    String desc;
    String type;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    About({
        required this.id,
        required this.title,
        required this.desc,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory About.fromJson(Map<String, dynamic> json) => About(
        id: json["_id"],
        title: json["title"],
        desc: json["desc"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "desc": desc,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

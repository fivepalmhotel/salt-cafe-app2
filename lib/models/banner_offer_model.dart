// To parse this JSON data, do
//
//     final bannerOffer = bannerOfferFromJson(jsonString);

import 'dart:convert';

BannerOffer bannerOfferFromJson(String str) => BannerOffer.fromJson(json.decode(str));

String bannerOfferToJson(BannerOffer data) => json.encode(data.toJson());

class BannerOffer {
    int status;
    String message;
    List<Banner> data;

    BannerOffer({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BannerOffer.fromJson(Map<String, dynamic> json) => BannerOffer(
        status: json["status"],
        message: json["message"],
        data: List<Banner>.from(json["data"].map((x) => Banner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Banner {
    String id;
    String title;
    String image;
    bool isVideo;
    String position;
    String type;
    String desc;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Banner({
        required this.id,
        required this.title,
        required this.image,
        required this.isVideo,
        required this.position,
        required this.type,
        required this.desc,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        isVideo: json["isVideo"],
        position: json["position"],
        type: json["type"],
        desc: json["desc"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "isVideo": isVideo,
        "position": position,
        "type": type,
        "desc": desc,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

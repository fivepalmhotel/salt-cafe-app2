// To parse this JSON data, do
//
//     final allNotification = allNotificationFromJson(jsonString);

import 'dart:convert';

AllNotification allNotificationFromJson(String str) => AllNotification.fromJson(json.decode(str));

String allNotificationToJson(AllNotification data) => json.encode(data.toJson());

class AllNotification {
    int status;
    String message;
    List<Datum> data;

    AllNotification({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AllNotification.fromJson(Map<String, dynamic> json) => AllNotification(
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
    String id;
    String recipient;
    String title;
    String content;
    String sendVia;
    String status;
    DateTime expireIn;
    DateTime createdAt;
    int v;

    Datum({
        required this.id,
        required this.recipient,
        required this.title,
        required this.content,
        required this.sendVia,
        required this.status,
        required this.expireIn,
        required this.createdAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        recipient: json["recipient"],
        title: json["title"],
        content: json["content"],
        sendVia: json["sendVia"],
        status: json["status"],
        expireIn: DateTime.parse(json["expireIn"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "recipient": recipient,
        "title": title,
        "content": content,
        "sendVia": sendVia,
        "status": status,
        "expireIn": expireIn.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}

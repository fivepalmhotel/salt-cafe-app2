// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
    int status;
    String message;
    List<Faq> data;

    FaqModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        status: json["status"],
        message: json["message"],
        data: List<Faq>.from(json["data"].map((x) => Faq.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Faq {
    String id;
    String question;
    String answer;
    String type;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Faq({
        required this.id,
        required this.question,
        required this.answer,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["_id"],
        question: json["question"],
        answer: json["answer"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';

TermsModel termsModelFromJson(String str) => TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel {
    int status;
    String message;
    List<Terms> data;

    TermsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
        status: json["status"],
        message: json["message"],
        data: List<Terms>.from(json["data"].map((x) => Terms.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Terms {
    String id;
    String terms;
    String type;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Terms({
        required this.id,
        required this.terms,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        id: json["_id"],
        terms: json["terms"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "terms": terms,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

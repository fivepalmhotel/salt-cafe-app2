// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    int? status;
    String? message;
    Data? data;

    SignUpModel({
         this.status,
         this.message,
         this.data,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    String id;
    String otp;

    Data({
        required this.id,
        required this.otp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "otp": otp,
    };
}

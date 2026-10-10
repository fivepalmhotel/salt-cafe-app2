import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final String message;
  final List<Datum>? data;

  AddressModel({
    required this.message,
    required this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        message: json["message"] as String? ?? "No message", // Fallback value
        data: json["data"] != null 
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : <Datum>[], // Fallback to empty list
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String user;
  final String houseFlat;
  final String street;
  final String appartment;
  final String city;
  final String pincode;
  final String landMark;
  final String houseType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Datum({
    required this.id,
    required this.user,
    required this.houseFlat,
    required this.street,
    required this.appartment,
    required this.city,
    required this.pincode,
    required this.landMark,
    required this.houseType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] as String? ?? "", // Fallback empty string
        user: json["user"] as String? ?? "",
        houseFlat: json["houseFlat"] as String? ?? "",
        street: json["street"] as String? ?? "",
        appartment: json["appartment"] as String? ?? "",
        city: json["city"] as String? ?? "",
        pincode: json["pincode"] as String? ?? "",
        landMark: json["landMark"] as String? ?? "",
        houseType: json["houseType"] as String? ?? "",
        createdAt: json["createdAt"] != null 
            ? DateTime.parse(json["createdAt"] as String) 
            : DateTime.now(), // Fallback to current time
        updatedAt: json["updatedAt"] != null 
            ? DateTime.parse(json["updatedAt"] as String) 
            : DateTime.now(),
        v: json["__v"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "houseFlat": houseFlat,
        "street": street,
        "appartment": appartment,
        "city": city,
        "pincode": pincode,
        "landMark": landMark,
        "houseType": houseType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
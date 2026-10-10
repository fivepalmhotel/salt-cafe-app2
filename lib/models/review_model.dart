// To parse this JSON data, do
//
//     final allRatings = allRatingsFromJson(jsonString);

import 'dart:convert';

AllRatings allRatingsFromJson(String str) =>
    AllRatings.fromJson(json.decode(str));

String allRatingsToJson(AllRatings data) => json.encode(data.toJson());

class AllRatings {
  final String message;
  final int status;
  final List<Review> data;

  AllRatings({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AllRatings.fromJson(Map<String, dynamic> json) => AllRatings(
        message: json["message"] ?? "",
        status: (json["status"] as num?)?.toInt() ?? 0,
        data: json["data"] != null
            ? List<Review>.from(json["data"].map((x) => Review.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}


class Review {
  final String id;
  final UserId userId;
  final dynamic partnerId;
  final dynamic orderId;
  final dynamic mainCategory;
  final dynamic serviceId;
  final String hotelId;
  final List<Rating> rating;
  final double rating1;
  final double rating2;
  final double rating3;
  final double rating4;
  final double rating5;
  final double averageRating;
  final double totalRating;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Review({
    required this.id,
    required this.userId,
    required this.partnerId,
    required this.orderId,
    required this.mainCategory,
    required this.serviceId,
    required this.hotelId,
    required this.rating,
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
    required this.rating5,
    required this.averageRating,
    required this.totalRating,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ratingsList = json["rating"] ?? [];

    double getRating(int index) {
      if (ratingsList.length > index) {
        final val = ratingsList[index]["rating"];
        return val is num ? val.toDouble() : 0.0;
      }
      return 0.0;
    }

    return Review(
      id: json["_id"] ?? "",
      userId: UserId.fromJson(json["userId"] ?? {}),
      partnerId: json["partnerId"],
      orderId: json["orderId"],
      mainCategory: json["mainCategory"],
      serviceId: json["serviceId"],
      hotelId: json["hotelId"] ?? "",
      rating: ratingsList.map((x) => Rating.fromJson(x)).toList(),
      rating1: getRating(0),
      rating2: getRating(1),
      rating3: getRating(2),
      rating4: getRating(3),
      rating5: getRating(4),
      averageRating:
          (json["averageRating"] as num?)?.toDouble() ?? 0.0,
      totalRating: (json["totalRating"] as num?)?.toDouble() ?? 0.0,
      type: json["type"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      v: (json["__v"] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "partnerId": partnerId,
        "orderId": orderId,
        "mainCategory": mainCategory,
        "serviceId": serviceId,
        "hotelId": hotelId,
        "rating": rating.map((x) => x.toJson()).toList(),
        "rating1": rating1,
        "rating2": rating2,
        "rating3": rating3,
        "rating4": rating4,
        "rating5": rating5,
        "averageRating": averageRating,
        "totalRating": totalRating,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}


class Rating {
  final UserId userId;
  final double rating;
  final String image;
  final String comment;
  final DateTime date;
  final String id;
  final List<dynamic> reply;

  Rating({
    required this.userId,
    required this.rating,
    required this.image,
    required this.comment,
    required this.date,
    required this.id,
    required this.reply,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        userId: UserId.fromJson(json["userId"] ?? {}),
        rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
        image: json["image"]?.toString() ?? "",
        comment: json["comment"]?.toString() ?? "",
        date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
        id: json["_id"] ?? "",
        reply: json["reply"] != null
            ? List<dynamic>.from(json["reply"])
            : [],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId.toJson(),
        "rating": rating,
        "image": image,
        "comment": comment,
        "date": date.toIso8601String(),
        "_id": id,
        "reply": List<dynamic>.from(reply.map((x) => x)),
      };
}


class UserId {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String fullName;

  UserId({
    required this.id,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"] ?? "",
        image: json["image"]?.toString() ?? "", // handles null and non-String types
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        fullName: json["fullName"]?.toString()?? "", // handles null and non-String types
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
      };
}

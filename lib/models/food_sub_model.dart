// Updated model with null-safety handling and defaults

import 'dart:convert';

FoodCategoryById foodCategoryByIdFromJson(String str) => FoodCategoryById.fromJson(json.decode(str));

String foodCategoryByIdToJson(FoodCategoryById data) => json.encode(data.toJson());

class FoodCategoryById {
  String message;
  int status;
  List<Data> data;

  FoodCategoryById({
    required this.message,
    required this.status,
    required this.data,
  });

  factory FoodCategoryById.fromJson(Map<String, dynamic> json) => FoodCategoryById(
    message: json["message"] ?? '',
    status: json["status"] ?? 0,
    data: json["data"] != null
        ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  CurrentLocation currentLocation;
  String id;
  MainCategoryId mainCategoryId;
  String city;
  String title;
  String description;
  int timeInMin;
  String totalTime;
  List<dynamic> images;
  int originalPrice;
  bool discountActive;
  int discount;
  int discountPrice;
  String size;
  int rating;
  int sellCount;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.currentLocation,
    required this.id,
    required this.mainCategoryId,
    required this.city,
    required this.title,
    required this.description,
    required this.timeInMin,
    required this.totalTime,
    required this.images,
    required this.originalPrice,
    required this.discountActive,
    required this.discount,
    required this.discountPrice,
    required this.size,
    required this.rating,
    required this.sellCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentLocation: json["currentLocation"] != null
        ? CurrentLocation.fromJson(json["currentLocation"])
        : CurrentLocation(type: '', coordinates: []),
    id: json["_id"] ?? '',
    mainCategoryId: json["mainCategoryId"] != null
        ? MainCategoryId.fromJson(json["mainCategoryId"])
        : MainCategoryId(
            id: '',
            name: '',
            image: '',
            averageRating: 0,
            totalRating: 0,
            status: false,
            isPromote: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 0,
          ),
    city: json["city"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    timeInMin: json["timeInMin"] ?? 0,
    totalTime: json["totalTime"] ?? '',
    images: json["images"] != null ? List<dynamic>.from(json["images"]) : [],
    originalPrice: json["originalPrice"] ?? 0,
    discountActive: json["discountActive"] ?? false,
    discount: json["discount"] ?? 0,
    discountPrice: json["discountPrice"] ?? 0,
    size: json["size"] ?? '',
    rating: json["rating"] ?? 0,
    sellCount: json["sellCount"] ?? 0,
    status: json["status"] ?? false,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "currentLocation": currentLocation.toJson(),
    "_id": id,
    "mainCategoryId": mainCategoryId.toJson(),
    "city": city,
    "title": title,
    "description": description,
    "timeInMin": timeInMin,
    "totalTime": totalTime,
    "images": List<dynamic>.from(images.map((x) => x)),
    "originalPrice": originalPrice,
    "discountActive": discountActive,
    "discount": discount,
    "discountPrice": discountPrice,
    "size": size,
    "rating": rating,
    "sellCount": sellCount,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class CurrentLocation {
  String type;
  List<double> coordinates;

  CurrentLocation({
    required this.type,
    required this.coordinates,
  });

  factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
    type: json["type"] ?? '',
    coordinates: json["coordinates"] != null
        ? List<double>.from(json["coordinates"].map((x) => x?.toDouble() ?? 0.0))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

class MainCategoryId {
  String id;
  String name;
  String image;
  int averageRating;
  int totalRating;
  bool status;
  bool isPromote;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MainCategoryId({
    required this.id,
    required this.name,
    required this.image,
    required this.averageRating,
    required this.totalRating,
    required this.status,
    required this.isPromote,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MainCategoryId.fromJson(Map<String, dynamic> json) => MainCategoryId(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    averageRating: json["averageRating"] ?? 0,
    totalRating: json["totalRating"] ?? 0,
    status: json["status"] ?? false,
    isPromote: json["isPromote"] ?? false,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "averageRating": averageRating,
    "totalRating": totalRating,
    "status": status,
    "isPromote": isPromote,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

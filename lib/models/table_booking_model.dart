// To parse this JSON data, do
//
//     final orderBooking = orderBookingFromJson(jsonString);

import 'dart:convert';

TableBookingModel orderBookingFromJson(String str) => TableBookingModel.fromJson(json.decode(str));

String orderBookingToJson(TableBookingModel data) => json.encode(data.toJson());

class TableBookingModel {
    int status;
    String message;
    List<Datum> data;

    TableBookingModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TableBookingModel.fromJson(Map<String, dynamic> json) => TableBookingModel(
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
    String userId;
    HotelId hotelId;
    int numberOfGuests;
    DateTime bookingDate;
    String timeSlot;
    String status;
    String specialRequest;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.userId,
        required this.hotelId,
        required this.numberOfGuests,
        required this.bookingDate,
        required this.timeSlot,
        required this.status,
        required this.specialRequest,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["userId"],
        hotelId: HotelId.fromJson(json["hotelId"]),
        numberOfGuests: (json["numberOfGuests"] as num).toInt(),
        bookingDate: DateTime.parse(json["bookingDate"]),
        timeSlot: json["timeSlot"],
        status: json["status"],
        specialRequest: json["specialRequest"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: (json["__v"] as num).toInt(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "hotelId": hotelId.toJson(),
        "numberOfGuests": numberOfGuests,
        "bookingDate": bookingDate.toIso8601String(),
        "timeSlot": timeSlot,
        "status": status,
        "specialRequest": specialRequest,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class HotelId {
    Location location;
    ContactInfo contactInfo;
    OperatingHours operatingHours;
    String id;
    String name;
    String description;
    String city;
    List<String> images;
    List<String> amenities;
    List<Menu> menu;
    int ratings;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    HotelId({
        required this.location,
        required this.contactInfo,
        required this.operatingHours,
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.images,
        required this.amenities,
        required this.menu,
        required this.ratings,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory HotelId.fromJson(Map<String, dynamic> json) => HotelId(
        location: Location.fromJson(json["location"]),
        contactInfo: ContactInfo.fromJson(json["contactInfo"]),
        operatingHours: OperatingHours.fromJson(json["operatingHours"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        images: List<String>.from(json["images"].map((x) => x)),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        ratings: (json["ratings"] as num).toInt(),
      
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "contactInfo": contactInfo.toJson(),
        "operatingHours": operatingHours.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "city": city,
        "images": List<dynamic>.from(images.map((x) => x)),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "ratings": ratings,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ContactInfo {
    String phone;
    String email;
    String website;

    ContactInfo({
        required this.phone,
        required this.email,
        required this.website,
    });

    factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "website": website,
    };
}

class Location {
    String address;
    String city;
    String state;
    String country;
    String zipCode;
    List<double> coordinates;
    String type;

    Location({
        required this.address,
        required this.city,
        required this.state,
        required this.country,
        required this.zipCode,
        required this.coordinates,
        required this.type,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zipCode"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zipCode": zipCode,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Menu {
    String type;
    List<String> image;
    String id;

    Menu({
        required this.type,
        required this.image,
        required this.id,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        type: json["type"],
        image: List<String>.from(json["image"].map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "image": List<dynamic>.from(image.map((x) => x)),
        "_id": id,
    };
}

class OperatingHours {
    String checkIn;
    String checkOut;

    OperatingHours({
        required this.checkIn,
        required this.checkOut,
    });

    factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
    );

    Map<String, dynamic> toJson() => {
        "checkIn": checkIn,
        "checkOut": checkOut,
    };
}

// To parse this JSON data, do
//
//     final cityByHotels = cityByHotelsFromJson(jsonString);

import 'dart:convert';

CityByHotels cityByHotelsFromJson(String str) => CityByHotels.fromJson(json.decode(str));

String cityByHotelsToJson(CityByHotels data) => json.encode(data.toJson());

class CityByHotels {
    String message;
    int status;
    List<Hotel> data;

    CityByHotels({
        required this.message,
        required this.status,
        required this.data,
    });

    factory CityByHotels.fromJson(Map<String, dynamic> json) => CityByHotels(
        message: json["message"],
        status: json["status"],
        data: List<Hotel>.from(json["data"].map((x) => Hotel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Hotel {
    Location location;
    ContactInfo contactInfo;
    OperatingHours operatingHours;
    String id;
    String name;
    String description;
    City city;
    List<String> images;
    List<String> amenities;
    List<Menu> menu;
    double ratings;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<String> hotelImages;

    Hotel({
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
        required this.hotelImages,
    });

    factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        location: Location.fromJson(json["location"]),
        contactInfo: ContactInfo.fromJson(json["contactInfo"]),
        operatingHours: OperatingHours.fromJson(json["operatingHours"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        city: City.fromJson(json["city"]),
        images: List<String>.from(json["images"].map((x) => x)),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        ratings: json["ratings"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        hotelImages: List<String>.from(json["hotelImages"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "contactInfo": contactInfo.toJson(),
        "operatingHours": operatingHours.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "city": city.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "ratings": ratings,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "hotelImages": List<dynamic>.from(hotelImages.map((x) => x)),
    };
}

class City {
    String id;
    String name;
    String image;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    City({
        required this.id,
        required this.name,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
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

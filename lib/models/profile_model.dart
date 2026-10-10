import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  int status;
  String message;
  Data data;

  UserProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Location currentLocation;
  Location storeLocation;
  String id;
  String userId;
  List<dynamic> joinUser;
  String? fullName;
  String? image;
  String? phone;
  dynamic password;
  bool documentVerification;
  String isCity;
  int km;
  String otp;
  String otpExpiration;
  bool accountVerification;
  bool completeProfile;
  String userType;
  String status;
  int averageRating;
  String openClose;
  int wallet;
  List<dynamic> permissions;
  List<DummyImage> dummyImage;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? address1;
  String? address2;
  String? dob;
  String? email;
  String? gender;
  dynamic aadharCard;
  String? bio;
  dynamic drivingLicense;
  String? firstName;
  String? lastName;
  dynamic otherDocument;
  dynamic panCard;
  dynamic passport;
  String? referralCode;

  Data({
    required this.currentLocation,
    required this.storeLocation,
    required this.id,
    required this.userId,
    required this.joinUser,
    this.fullName,
    this.image,
    this.phone,
    this.password,
    required this.documentVerification,
    required this.isCity,
    required this.km,
    required this.otp,
    required this.otpExpiration,
    required this.accountVerification,
    required this.completeProfile,
    required this.userType,
    required this.status,
    required this.averageRating,
    required this.openClose,
    required this.wallet,
    required this.permissions,
    required this.dummyImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.address1,
    this.address2,
    this.dob,
    this.email,
    this.gender,
    this.aadharCard,
    this.bio,
    this.drivingLicense,
    this.firstName,
    this.lastName,
    this.otherDocument,
    this.panCard,
    this.passport,
    this.referralCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentLocation: Location.fromJson(json["currentLocation"]),
        storeLocation: Location.fromJson(json["storeLocation"]),
        id: json["_id"],
        userId: json["userId"],
        joinUser: List<dynamic>.from(json["joinUser"] ?? []),
        fullName: json["fullName"],
        image: json["image"],
        phone: json["phone"],
        password: json["password"],
        documentVerification: json["documentVerification"],
        isCity: json["isCity"],
        km: json["km"],
        otp: json["otp"],
        otpExpiration: json["otpExpiration"],
        accountVerification: json["accountVerification"],
        completeProfile: json["completeProfile"],
        userType: json["userType"],
        status: json["status"],
        averageRating: json["averageRating"],
        openClose: json["openClose"],
        wallet: json["wallet"],
        permissions: List<dynamic>.from(json["permissions"] ?? []),
        dummyImage: json["dummyImage"] != null
            ? List<DummyImage>.from(
                json["dummyImage"].map((x) => DummyImage.fromJson(x)))
            : [],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        address1: json["address1"],
        address2: json["address2"],
        dob: json["dob"],
        email: json["email"],
        gender: json["gender"],
        aadharCard: json["aadharCard"],
        bio: json["bio"],
        drivingLicense: json["drivingLicense"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        otherDocument: json["otherDocument"],
        panCard: json["panCard"],
        passport: json["passport"],
        referralCode: json["referralCode"], // ✅ fixed spelling
      );

  Map<String, dynamic> toJson() => {
        "currentLocation": currentLocation.toJson(),
        "storeLocation": storeLocation.toJson(),
        "_id": id,
        "userId": userId,
        "joinUser": List<dynamic>.from(joinUser),
        "fullName": fullName,
        "image": image,
        "phone": phone,
        "password": password,
        "documentVerification": documentVerification,
        "isCity": isCity,
        "km": km,
        "otp": otp,
        "otpExpiration": otpExpiration,
        "accountVerification": accountVerification,
        "completeProfile": completeProfile,
        "userType": userType,
        "status": status,
        "averageRating": averageRating,
        "openClose": openClose,
        "wallet": wallet,
        "permissions": List<dynamic>.from(permissions),
        "dummyImage":
            List<dynamic>.from(dummyImage.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "address1": address1,
        "address2": address2,
        "dob": dob,
        "email": email,
        "gender": gender,
        "aadharCard": aadharCard,
        "bio": bio,
        "drivingLicense": drivingLicense,
        "firstName": firstName,
        "lastName": lastName,
        "otherDocument": otherDocument,
        "panCard": panCard,
        "passport": passport,
        "referralCode": referralCode, // ✅ fixed spelling
      };
}

class Location {
  String type;
  List<int> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<int>.from(json["coordinates"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates),
      };
}

class DummyImage {
  String img;
  String id;

  DummyImage({
    required this.img,
    required this.id,
  });

  factory DummyImage.fromJson(Map<String, dynamic> json) => DummyImage(
        img: json["img"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
      };
}

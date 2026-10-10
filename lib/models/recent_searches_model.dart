// To parse this JSON data, do
//
//     final recentKeyword = recentKeywordFromJson(jsonString);

import 'dart:convert';

RecentKeyword recentKeywordFromJson(String str) => RecentKeyword.fromJson(json.decode(str));

String recentKeywordToJson(RecentKeyword data) => json.encode(data.toJson());

class RecentKeyword {
    int status;
    String message;
    List<Recent> data;

    RecentKeyword({
        required this.status,
        required this.message,
        required this.data,
    });

    factory RecentKeyword.fromJson(Map<String, dynamic> json) => RecentKeyword(
        status: json["status"],
        message: json["message"],
        data: List<Recent>.from(json["data"].map((x) => Recent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Recent {
    String searchQuery;
    int searchCount;

    Recent({
        required this.searchQuery,
        required this.searchCount,
    });

    factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        searchQuery: json["searchQuery"],
        searchCount: json["searchCount"],
    );

    Map<String, dynamic> toJson() => {
        "searchQuery": searchQuery,
        "searchCount": searchCount,
    };
}

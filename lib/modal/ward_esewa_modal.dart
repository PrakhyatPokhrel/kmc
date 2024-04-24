import 'dart:convert';

List<WardEsewaModel> wardEsewaModelFromJson(String str) =>
    List<WardEsewaModel>.from(
        json.decode(str).map((x) => WardEsewaModel.fromJson(x)));

String wardEsewaModelToJson(List<WardEsewaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WardEsewaModel {
  WardEsewaModel({
    required this.ward,
    required this.clientId,
    required this.clientSecret,
  });

  final String ward;
  final String clientId;
  final String clientSecret;

  factory WardEsewaModel.fromJson(Map<String, dynamic> json) => WardEsewaModel(
        ward: json["ward "],
        clientId: json["ClientID"],
        clientSecret: json["ClientSecret"],
      );

  Map<String, dynamic> toJson() => {
        "ward ": ward,
        "ClientID": clientId,
        "ClientSecret": clientSecret,
      };
}

// // To parse this JSON data, do
// //
// //     final wardEsewaModel = wardEsewaModelFromJson(jsonString);

// import 'dart:convert';

// List<WardEsewaModel> wardEsewaModelFromJson(String str) =>
//     List<WardEsewaModel>.from(
//         json.decode(str).map((x) => WardEsewaModel.fromJson(x)));

// String wardEsewaModelToJson(List<WardEsewaModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class WardEsewaModel {
//   WardEsewaModel({
//     required this.ward,
//     required this.detail,
//   });

//   final int ward;
//   final Detail detail;

//   factory WardEsewaModel.fromJson(Map<String, dynamic> json) => WardEsewaModel(
//         ward: json["ward"],
//         detail: Detail.fromJson(json["detail"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "ward": ward,
//         "detail": detail.toJson(),
//       };
// }

// class Detail {
//   Detail({
//     required this.clientId,
//     required this.secretKey,
//   });

//   final String clientId;
//   final String secretKey;

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         clientId: json["client_id"],
//         secretKey: json["secret_key"],
//       );

//   Map<String, dynamic> toJson() => {
//         "client_id": clientId,
//         "secret_key": secretKey,
//       };
// }

// To parse this JSON data, do
//
//     final wardEsewaModel = wardEsewaModelFromJson(jsonString);


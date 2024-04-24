import 'dart:convert';

List<WardKhaltiModel> wardEsewaModelFromJson(String str) =>
    List<WardKhaltiModel>.from(
        json.decode(str).map((x) => WardKhaltiModel.fromJson(x)));

String wardEsewaModelToJson(List<WardKhaltiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WardKhaltiModel {
  WardKhaltiModel({
    required this.ward,
    required this.clientPublic,
  });

  final String ward;
  final String clientPublic;

  factory WardKhaltiModel.fromJson(Map<String, dynamic> json) => WardKhaltiModel(
        ward: json["ward "],
        clientPublic: json["ClientPublic"],
      );

  Map<String, dynamic> toJson() => {
        "ward ": ward,
        "ClientPublic": clientPublic,
      };
}
// To parse this JSON data, do
//
//     final toiletSingleBranchModel = toiletSingleBranchModelFromJson(jsonString);

import 'dart:convert';

ToiletSingleBranchModel toiletSingleBranchModelFromJson(dynamic str) =>
    ToiletSingleBranchModel.fromJson(str);

String toiletSingleBranchModelToJson(ToiletSingleBranchModel data) =>
    json.encode(data.toJson());

class ToiletSingleBranchModel {
  final bool status;
  final Data data;
  final String message;

  ToiletSingleBranchModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ToiletSingleBranchModel.fromJson(Map<String, dynamic> json) =>
      ToiletSingleBranchModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  final Branches branches;
  // final int rating;

  Data({
    required this.branches,
    // required this.rating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        branches: Branches.fromJson(json),
        // rating: json['rating'],
      );

  Map<String, dynamic> toJson() => {
        "0": branches.toJson(),
        // "rating": rating,
      };
}

class Branches {
  final int id;
  final String focalPerson;
  final String focalPersonContact;
  final String organizationName;
  final String organizationType;
  final String organizationImage;
  final String organizationDescription;
  final String organizationEmail;
  final String organizationWebsiteUrl;
  final String location;
  final String serviceType;
  final String toiletType;
  final bool disabledStatus;
  final String category;
  final String status;
  final String? branchQr;
  final double averageRating;
  final List<dynamic> branchImages;
  final GeoLocation geoLocation;
  // final List<dynamic> review;

  Branches({
    required this.id,
    required this.averageRating,
    required this.focalPerson,
    required this.focalPersonContact,
    required this.organizationName,
    required this.organizationType,
    required this.organizationImage,
    required this.organizationDescription,
    required this.organizationEmail,
    required this.organizationWebsiteUrl,
    required this.location,
    required this.serviceType,
    required this.toiletType,
    required this.disabledStatus,
    required this.category,
    required this.status,
    required this.branchImages,
    required this.geoLocation,
    // required this.review,
    required this.branchQr,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
      averageRating: json['average_rating'] != null
          ? json['average_rating'].toDouble()
          : 0.0,
      id: json["id"],
      organizationName: json["organization_name"] ?? "N/A",
      organizationType: json["organization_type"] ?? "N/A",
      organizationImage: json["organization_image"] ?? "N/A",
      organizationDescription: json["organization_description"] ?? "N/A",
      organizationEmail: json["organization_email"] ?? "N/A",
      organizationWebsiteUrl: json["organization_website_url"] ?? "N/A",
      location: json["location"] ?? "N/A",
      serviceType: json["service_type"] ?? "N/A",
      toiletType: json["toilet_type"] ?? "N/A",
      disabledStatus: json["disabled_status"] ?? false,
      category: json["category"] ?? "N/A",
      status: json["status"] ?? "N/A",
      branchImages: json["branch_images"] != null
          ? List<dynamic>.from(json["branch_images"].map((x) => x))
          : [],
      geoLocation: json["geo_location"] != null
          ? GeoLocation.fromJson(json["geo_location"])
          : GeoLocation(
              id: 0,
              latitude: "27.69087137611893",
              longitude: "85.32033016763434"),
      // review: List<dynamic>.from(json["review"].map((x) => x)),
      branchQr: json['branch_QR_code'],
      focalPerson: json['focal_person'] ?? "N/A",
      focalPersonContact: json['focal_person_contact'] ?? "N/A");

  Map<String, dynamic> toJson() => {
        "id": id,
        "organization_name": organizationName,
        "organization_type": organizationType,
        "organization_image": organizationImage,
        "organization_description": organizationDescription,
        "organization_email": organizationEmail,
        "organization_website_url": organizationWebsiteUrl,
        "location": location,
        "service_type": serviceType,
        "toilet_type": toiletType,
        "disabled_status": disabledStatus,
        "category": category,
        "status": status,
        "branch_images": List<dynamic>.from(branchImages.map((x) => x)),
        "geo_location": geoLocation.toJson(),
        // "review": List<dynamic>.from(review.map((x) => x)),
      };
}

class GeoLocation {
  final int id;
  final String latitude;
  final String longitude;

  GeoLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
      };
}

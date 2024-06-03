// To parse this JSON data, do
//
//     final toiletSingleBranchModel = toiletSingleBranchModelFromJson(jsonString);

import 'dart:convert';

ToiletSingleBranchModel toiletSingleBranchModelFromJson(dynamic str) => ToiletSingleBranchModel.fromJson(str);

String toiletSingleBranchModelToJson(ToiletSingleBranchModel data) => json.encode(data.toJson());

class ToiletSingleBranchModel {
    final bool status;
    final Data data;
    final String message;

    ToiletSingleBranchModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory ToiletSingleBranchModel.fromJson(Map<String, dynamic> json) => ToiletSingleBranchModel(
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
    final int rating;

    Data({
        required this.branches,
        required this.rating,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        branches: Branches.fromJson(json["0"]),
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "0": branches.toJson(),
        "rating": rating,
    };
}

class Branches {
    final int id;
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
    final List<dynamic> branchImages;
    final GeoLocation geoLocation;
    final List<dynamic> review;

    Branches( {
        required this.id,
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
        required this.review,
        required this.branchQr,
    });

    factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        id: json["id"],
        organizationName: json["organization_name"],
        organizationType: json["organization_type"],
        organizationImage: json["organization_image"],
        organizationDescription: json["organization_description"],
        organizationEmail: json["organization_email"],
        organizationWebsiteUrl: json["organization_website_url"],
        location: json["location"],
        serviceType: json["service_type"],
        toiletType: json["toilet_type"],
        disabledStatus: json["disabled_status"],
        category: json["category"],
        status: json["status"],
        branchImages: List<dynamic>.from(json["branch_images"].map((x) => x)),
        geoLocation: GeoLocation.fromJson(json["geo_location"]),
        review: List<dynamic>.from(json["review"].map((x) => x)),
        branchQr: json['branch_QR_code']
    );

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
        "review": List<dynamic>.from(review.map((x) => x)),
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

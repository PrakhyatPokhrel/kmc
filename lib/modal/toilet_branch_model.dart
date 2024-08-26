// To parse this JSON data, do
//
//     final toiletBranchModel = toiletBranchModelFromJson(jsonString);

import 'dart:convert';

ToiletBranchModel toiletBranchModelFromJson(dynamic str) =>
    ToiletBranchModel.fromJson(str);

String toiletBranchModelToJson(ToiletBranchModel data) =>
    json.encode(data.toJson());

class ToiletBranchModel {
  final bool status;
  final List<ToiletBranchModelData> data;
  // final Pagination pagination;
  // final Meta meta;
  final String message;

  ToiletBranchModel({
    required this.status,
    required this.data,
    // required this.pagination,
    // required this.meta,
    required this.message,
  });

  factory ToiletBranchModel.fromJson(Map<String, dynamic> json) =>
      ToiletBranchModel(
        status: json["status"],
        data: List<ToiletBranchModelData>.from(
            json["data"].map((x) => ToiletBranchModelData.fromJson(x))),
        // pagination: Pagination.fromJson(json["pagination"]),
        // meta: Meta.fromJson(json["meta"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "pagination": pagination.toJson(),
        // "meta": meta.toJson(),
        "message": message,
      };
}

class ToiletBranchModelData {
  final int id;
  final String serviceType;
  final String toiletType;
  final bool disabledStatus;
  final String category;
  final String status;
  final String location;
  final Organization organization;
  final GeoLocation geoLocation;
  final double averageRating;

  ToiletBranchModelData({
    required this.id,
    required this.averageRating,
    required this.serviceType,
    required this.toiletType,
    required this.disabledStatus,
    required this.category,
    required this.status,
    required this.location,
    required this.organization,
    required this.geoLocation,
  });

  factory ToiletBranchModelData.fromJson(Map<String, dynamic> json) =>
      ToiletBranchModelData(
        id: json["id"],
        serviceType: json["service_type"],
        toiletType: json["toilet_type"],
        disabledStatus: json["disabled_status"],
        category: json["category"],
        status: json["status"],
        location: json["location"],
        organization: Organization.fromJson(json["organization"]),
        geoLocation: json["geo_location"] != null
            ? GeoLocation.fromJson(json["geo_location"])
            : GeoLocation(id: 0, latitude: "0", longitude: "0"),
        averageRating: json["average_rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_type": serviceType,
        "toilet_type": toiletType,
        "disabled_status": disabledStatus,
        "category": category,
        "status": status,
        "location": location,
        "organization": organization.toJson(),
        "geo_location": geoLocation.toJson(),
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
        latitude: json["latitude"] == 'undefined' ? "0.0" : json["latitude"],
        longitude: json["longitude"] == 'undefined' ? "0.0" : json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Organization {
  final int id;
  final String organizationName;
  final String organizationDescription;
  final String organizationType;
  final String focalPerson;
  final String organizationAddress;
  final String organizationContact;
  final String organizationEmail;
  final String organizationWebsiteUrl;
  final String organizationLogo;

  Organization({
    required this.id,
    required this.organizationName,
    required this.organizationDescription,
    required this.organizationType,
    required this.focalPerson,
    required this.organizationAddress,
    required this.organizationContact,
    required this.organizationEmail,
    required this.organizationWebsiteUrl,
    required this.organizationLogo,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        id: json["id"],
        organizationName: json["organization_name"],
        organizationDescription: json["organization_description"],
        organizationType: json["organization_type"],
        focalPerson: json["focal_person"],
        organizationAddress: json["organization_address"],
        organizationContact: json["organization_contact"],
        organizationEmail: json["organization_email"],
        organizationWebsiteUrl: json["organization_website_url"],
        organizationLogo: json["organization_logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organization_name": organizationName,
        "organization_description": organizationDescription,
        "organization_type": organizationType,
        "focal_person": focalPerson,
        "organization_address": organizationAddress,
        "organization_contact": organizationContact,
        "organization_email": organizationEmail,
        "organization_website_url": organizationWebsiteUrl,
        "organization_logo": organizationLogo,
      };
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Pagination {
  final String first;
  final String last;
  final dynamic prev;
  final dynamic next;

  Pagination({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

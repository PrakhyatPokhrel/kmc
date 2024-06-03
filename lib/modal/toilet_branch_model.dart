// To parse this JSON data, do
//
//     final organizationModel = organizationModelFromJson(jsonString);

import 'dart:convert';

OrganizationModel organizationModelFromJson(dynamic str) => OrganizationModel.fromJson(str);

String organizationModelToJson(OrganizationModel data) => json.encode(data.toJson());

class OrganizationModel {
    final bool status;
    final List<OrganizationModelData> data;
    final Pagination pagination;
    final Meta meta;
    final String message;

    OrganizationModel({
        required this.status,
        required this.data,
        required this.pagination,
        required this.meta,
        required this.message,
    });

    factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
        status: json["status"],
        data: List<OrganizationModelData>.from(json["data"].map((x) => OrganizationModelData.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        meta: Meta.fromJson(json["meta"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "meta": meta.toJson(),
        "message": message,
    };
}

class OrganizationModelData {
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
    final List<dynamic> branches;

    OrganizationModelData({
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
        required this.branches,
    });

    factory OrganizationModelData.fromJson(Map<String, dynamic> json) => OrganizationModelData(
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
        branches: List<dynamic>.from(json["branches"].map((x) => x)),
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
        "branches": List<dynamic>.from(branches.map((x) => x)),
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

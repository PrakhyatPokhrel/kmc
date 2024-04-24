// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Publicplacess {
  int? sp_index;
  String? sp_pp_contact;
  String? sp_pp_contact2;
  String? sp_pp_email;
  String? sp_pp_img1;
  String? sp_pp_img2;
  String? sp_pp_img3;
  String? sp_pp_img4;
  String? sp_pp_img5;
  String? sp_pp_location_altitude;
  String? sp_pp_location_latitude;
  String? sp_pp_location_longitude;
  String? sp_pp_location_precision;
  String? sp_pp_name;
  String? sp_pp_person_contact;
  String? sp_pp_person_name;
  String? sp_pp_tol;
  String? sp_landmark;
  String? sp_pp_type;
  String? sp_pp_ward;
  Map<String,dynamic> public_place_type;
  Publicplacess({
    required this.sp_index,
    required this.sp_pp_contact,
    required this.sp_pp_contact2,
    required this.sp_pp_email,
    required this.sp_pp_img1,
    required this.sp_pp_img2,
    required this.sp_pp_img3,
    required this.sp_pp_img4,
    required this.sp_pp_img5,
    required this.sp_pp_location_altitude,
    required this.sp_pp_location_latitude,
    required this.sp_pp_location_longitude,
    required this.sp_pp_location_precision,
    required this.sp_pp_name,
    required this.sp_pp_person_contact,
    required this.sp_pp_person_name,
    required this.sp_pp_tol,
    required this.sp_landmark,
    required this.sp_pp_type,
    required this.sp_pp_ward,
    required this.public_place_type,
  });

  factory Publicplacess.fromJson(Map<String, dynamic> map) {
    return Publicplacess(
      sp_index: map['sp_index'],
      sp_pp_contact: map['sp_pp_contact'],
      sp_pp_contact2: map['sp_pp_contact2'],
      sp_pp_email: map['sp_pp_email'],
      sp_pp_img1: map['sp_pp_img1'],
      sp_pp_img2: map['sp_pp_img2'],
      sp_pp_img3: map['sp_pp_img3'],
      sp_pp_img4: map['sp_pp_img4'],
      sp_pp_img5: map['sp_pp_img5'],
      sp_pp_location_altitude: map['sp_pp_location_altitude'],
      sp_pp_location_latitude: map['sp_pp_location_latitude'],
      sp_pp_location_longitude: map['sp_pp_location_longitude'],
      sp_pp_location_precision: map['sp_pp_location_precision'],
      sp_pp_name: map['sp_pp_name'],
      sp_pp_person_contact: map['sp_pp_person_contact'],
      sp_pp_person_name: map['sp_pp_person_name'],
      sp_pp_tol: map['sp_pp_tol'],
      sp_landmark: map['sp_landmark']==null?"":map['sp_landmark'],
      sp_pp_type: map['sp_pp_type'],
      sp_pp_ward: map['sp_pp_ward'],
      public_place_type: map['public_place_type']
    );
  }
}

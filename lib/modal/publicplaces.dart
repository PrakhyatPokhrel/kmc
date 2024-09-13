
class Publicplaces {
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
  String? sp_pp_type;
  String? sp_pp_ward;
  Publicplaces({
    this.sp_index,
    this.sp_pp_contact,
    this.sp_pp_contact2,
    this.sp_pp_email,
    this.sp_pp_img1,
    this.sp_pp_img2,
    this.sp_pp_img3,
    this.sp_pp_img4,
    this.sp_pp_img5,
    this.sp_pp_location_altitude,
    this.sp_pp_location_latitude,
    this.sp_pp_location_longitude,
    this.sp_pp_location_precision,
    this.sp_pp_name,
    this.sp_pp_person_contact,
    this.sp_pp_person_name,
    this.sp_pp_tol,
    this.sp_pp_type,
    this.sp_pp_ward,
  });

  factory Publicplaces.fromJson(Map<String, dynamic> map) {
    return Publicplaces(
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
      sp_pp_type: map['sp_pp_type'],
      sp_pp_ward: map['sp_pp_ward'],
    );
  }
}

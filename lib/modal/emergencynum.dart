
class Emergencydata {
  String? type;
  List<Informationemergency>? data;
  Emergencydata({
    this.type,
    this.data,
  });

  factory Emergencydata.fromJson(Map<String, dynamic> map) {
    // if (map != null) {
    List<dynamic> datas = map['data'];
    var lists = datas.map((e) => Informationemergency.fromJson(e)).toList();
    return Emergencydata(type: map['type'], data: lists);
    // }
  }
}

class Informationemergency {
  int? hosp_id;
  dynamic name;
  dynamic contact_person;
  dynamic representative;
  dynamic contact1;
  dynamic contact2;
  dynamic contact3;
  dynamic location_name;
  dynamic location_lati;
  dynamic location_long;
  dynamic images;
  dynamic woda_id;
  dynamic hospi_type_id;
  dynamic feature_img;
  Informationemergency({
    this.hosp_id,
    this.name,
    this.contact_person,
    this.representative,
    this.contact1,
    this.contact2,
    this.contact3,
    this.location_name,
    this.location_lati,
    this.location_long,
    this.images,
    this.woda_id,
    this.hospi_type_id,
    this.feature_img,
  });

  factory Informationemergency.fromJson(Map<String, dynamic> map) {
    return Informationemergency(
      hosp_id: map['hosp_id'],
      name: map['name'],
      contact_person: map['contact_person'],
      representative: map['representative'],
      contact1: map['contact1'],
      contact2: map['contact2'],
      contact3: map['contact3'],
      location_name: map['location_name'],
      location_lati: map['location_lati'],
      location_long: map['location_long'],
      images: map['images'],
      woda_id: map['woda_id'],
      hospi_type_id: map['hospi_type_id'],
      feature_img: map['feature_img'],
    );
  }
}

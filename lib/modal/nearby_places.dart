class NearbyPlaces {
  late bool status;
  late List<Data> data;
  late String message;

  NearbyPlaces({required this.status,required this.data,required this.message});

  NearbyPlaces.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? latitude;
  String? longitude;
  Null altitude;
  dynamic precision;
  String? name;
  String? ward;
  String? tole;
  String? image;
  String? landmark;

  Data(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitude,
      this.precision,
      this.name,
      this.ward,
      this.tole,
      this.image,
      this.landmark});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    precision = json['precision'];
    name = json['name'];
    ward = json['ward'];
    tole = json['tole'];
    image = json['image'];
    landmark = json['landmark'] == null?"":json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['precision'] = this.precision;
    data['name'] = this.name;
    data['ward'] = this.ward;
    data['tole'] = this.tole;
    data['image'] = this.image;
    data['landmark'] = this.landmark;
    return data;
  }
}
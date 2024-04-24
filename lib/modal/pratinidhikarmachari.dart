class Pratinidhikarmacharidata {
  final String? head;
  final List<Information>? headdata;

  Pratinidhikarmacharidata({this.head, this.headdata});

  factory Pratinidhikarmacharidata.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['data'];
    var lists = datas.map((e) => Information.fromJson(e)).toList();
    return Pratinidhikarmacharidata(
        head: json['data_type'].toString(), headdata: lists);
  }
}

class Information {
  dynamic? id;
  dynamic? name;
  dynamic? email;
  dynamic? address;
  dynamic? mobile;
  dynamic? gender;
  dynamic? icon;
  dynamic? ward;
  dynamic? nagar;
  dynamic? kd_id;
  dynamic? dismissed;
  dynamic? pd_id;
  dynamic? user_id;
  dynamic? created_at;
  dynamic? updated_at;
  dynamic? designation;

  Information(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.mobile,
      this.gender,
      this.icon,
      this.ward,
      this.nagar,
      this.kd_id,
      this.dismissed,
      this.pd_id,
      this.user_id,
      this.updated_at,
      this.created_at,
      this.designation});

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        mobile: json['mobile'],
        gender: json['gender'],
        icon: json['image_url'],
        ward: json['ward'],
        nagar: json['nagar'],
        kd_id: json['kd_id'],
        user_id: json['user_id'],
        updated_at: json['updated_at'],
        designation: json['designation']);
  }
}

class Wodapratinidhi {
  final String? wardname;
  int? id;
  String? wodanumber;
  final List<WardInformation>? wodapratinidhi;

  Wodapratinidhi(
      {this.wardname, this.wodanumber, this.id, this.wodapratinidhi});

  factory Wodapratinidhi.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['users'];
    var lists = datas.map((e) => WardInformation.fromJson(e)).toList();
    return Wodapratinidhi(
        wardname: json['woda_name'].toString(),
        id: json['woda_id'],
        wodanumber: json['woda_number'].toString(),
        wodapratinidhi: lists);
  }
}

class WardInformation {
  int? id;
  String? name;
  String? email;
  String? address;
  String? mobile;
  String? gender;
  String? image;
  int? ward;
  int? nagar;
  int? kd_id;
  String? dismissed;
  int? pd_id;
  int? user_id;
  String? created_at;
  String? updated_at;
  String? designation;

  WardInformation(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.mobile,
      this.gender,
      this.image,
      this.ward,
      this.nagar,
      this.kd_id,
      this.dismissed,
      this.pd_id,
      this.user_id,
      this.updated_at,
      this.created_at,
      this.designation});

  factory WardInformation.fromJson(Map<dynamic, dynamic> json) {
    return WardInformation(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        mobile: json['mobile'],
        gender: json['gender'],
        image: json['image'],
        ward: json['ward'],
        nagar: json['nagar'],
        kd_id: json['kd_id'],
        user_id: json['user_id'],
        updated_at: json['updated_at'],
        designation: json['designation']);
  }
}

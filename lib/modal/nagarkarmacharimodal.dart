class Nagarkarmacharidata {
  final String? head;
  final List<Information>? headdata;

  Nagarkarmacharidata({this.head, this.headdata});

  factory Nagarkarmacharidata.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['data'];
    var lists = datas.map((e) => Information.fromJson(e)).toList();
    return Nagarkarmacharidata(
        head: json['data_type'].toString(), headdata: lists);
  }
}

class Information {
  int? id;
  String? name;
  String? email;
  String? address;
  String? mobile;
  String? gender;
  String? icon;

  String? designation;

  Information(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.mobile,
      this.gender,
      this.icon,
      this.designation});

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        mobile: json['mobile'],
        gender: json['gender'],
        icon: json['image'],
        // ward: json['ward'],
        designation: json['designation']);
  }
}

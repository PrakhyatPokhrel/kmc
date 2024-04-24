class WodaJanakaridata {
  dynamic wodaid;
  String? wodaname;
  String? wodanumber;
  String? wodalong;
  String? wodalati;
  String? address;
  final Stats? stats;
  final List<KaryapalikaData>? pratinidhi;
  final List<KaryapalikaData>? karmachari;
  final List<KaryapalikaData>? users;

  WodaJanakaridata(
      {this.wodaid,
      this.wodaname,
      this.wodanumber,
      this.wodalati,
      this.wodalong,
      this.address,
      this.karmachari,
      this.pratinidhi,
      this.stats,
      this.users});

  factory WodaJanakaridata.fromJson(Map<String, dynamic> json) {
    List<dynamic> pratinidhi = json['pratinidhi'];
    var pratinidhilists =
        pratinidhi.map((e) => KaryapalikaData.fromJson(e)).toList();

    List<dynamic> karmachari = json['karmachari'];
    var karmacharilists =
        karmachari.map((e) => KaryapalikaData.fromJson(e)).toList();

    List<dynamic> karyapalika = json['karyapalika'];
    var karyapalikalist =
        karyapalika.map((e) => KaryapalikaData.fromJson(e)).toList();
    return WodaJanakaridata(
        wodaid: json['woda_id'],
        wodaname: json['woda_name'],
        wodanumber: json['woda_number'],
        address: json['address'],
        wodalong: json['woda_long'],
        wodalati: json['woda_lati'],
        karmachari: karmacharilists,
        pratinidhi: pratinidhilists,
        stats: Stats.fromJson(json['stats']),
        users: karyapalikalist);
  }
}

class KaryapalikaData {
  int? id;
  String? name;
  String? email;
  String? aaddress;
  String? mobile;
  String? gender;
  String? user_img;
  String? user_img_url;
  dynamic woda_id;
  String? designation;
  KaryapalikaData({
    this.id,
    this.name,
    this.email,
    this.aaddress,
    this.mobile,
    this.gender,
    this.user_img,
    this.user_img_url,
    this.woda_id,
    this.designation,
  });

  factory KaryapalikaData.fromJson(Map<String, dynamic> map) {
    return KaryapalikaData(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      aaddress: map['aaddress'],
      mobile: map['mobile'],
      gender: map['gender'],
      user_img: map['user_img'],
      user_img_url: map['user_img_url'],
      woda_id: map['woda_id'],
      designation: map['designation'],
    );
  }
}

class Stats {
  dynamic literacy;
  dynamic total_house;
  dynamic family_total;
  dynamic household_total;
  dynamic total_population;
  dynamic no_lalpurja;
  Stats({
    this.literacy,
    this.total_house,
    this.family_total,
    this.household_total,
    this.total_population,
    this.no_lalpurja,
  });

  factory Stats.fromJson(Map<String, dynamic> map) {
    return Stats(
      literacy: map['literacy'],
      total_house: map['total_house'],
      family_total: map['family_total'],
      household_total: map['household_total'],
      total_population: map['total_population'],
      no_lalpurja: map['no_lalpurja'],
    );
  }
}

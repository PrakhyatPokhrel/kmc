
// import 'package:kmc/components/my_flutter_app_icons.dart';

class WodaPatraData {
  String? title;

  final List<WodaPatrainfo>? wodapatradata;

  WodaPatraData({this.title, this.wodapatradata});

  factory WodaPatraData.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['value'];
    var lists = datas.map((e) => WodaPatrainfo.fromJson(e)).toList();

    return WodaPatraData(title: json['key'], wodapatradata: lists);
  }
}

/*  */
class WodaPatrainfo {
  int? id;
  String? title;
  String? cost;
  String? time;
  String? sewa_person;
  String? gunaswo_person;
  String? description;

  WodaPatrainfo(
      {this.id,
      this.title,
      this.cost,
      this.time,
      this.sewa_person,
      this.gunaswo_person,
      this.description});

  factory WodaPatrainfo.fromJson(Map<String, dynamic> map) {
    return WodaPatrainfo(
      id: map['id'],
      title: map['title'],
      cost: map['cost'],
      time: map['time'],
      sewa_person: map['sewa_person'],
      gunaswo_person: map['gunaswo_person'],
      description: map['description'],
    );
  }
}

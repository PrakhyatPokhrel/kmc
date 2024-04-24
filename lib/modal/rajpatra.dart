import 'package:flutter/cupertino.dart';

class RajpatraData {
  final String? year;
  final List<Rajpatrainfo>? datas;

  // int rajpatra_id;
  // String title;
  // String rajpatra_date;
  // String rajpatra_date_nep;
  // String rajpatra_type;
  // int rajpatra_order;
  // String feature_img;
  // String pdf_name;
  // String detail;
  // int approved1;
  // int approved2;
  // int approved3;
  // int notif_status;
  // String created_at;
  // String updated_at;

  RajpatraData({this.year, this.datas});

  factory RajpatraData.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['value'];
    var lists = datas.map((e) => Rajpatrainfo.fromJson(e)).toList();
    return RajpatraData(year: json['key'], datas: lists);
  }
}

class Rajpatrainfo {
  String? title;
  String? pdf_name;

  Rajpatrainfo({
    this.title,
    this.pdf_name,
  });

  factory Rajpatrainfo.fromJson(Map<String, dynamic> map) {
    return Rajpatrainfo(
      title: map['title'],
      pdf_name: map['pdf_name'],
    );
  }
}

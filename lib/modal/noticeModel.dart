import 'dart:convert';

class NoticeModal {
  dynamic notice_id;
  dynamic title;
  dynamic notice_date;
  List<FeatureImage>? feature_img;
  dynamic detail;
  dynamic created_at;
  List<NoticeFile>? pdf_files;
  NoticeModal({
    this.notice_id,
    this.title,
    this.notice_date,
    this.feature_img,
    this.detail,
    this.created_at,
    this.pdf_files,
  });

  factory NoticeModal.fromJson(Map<String, dynamic> map) {
    List<dynamic>? pdf = map['pdf_files'];
    var pdf_files = pdf?.map((e) => NoticeFile.fromJson(e)).toList();

    List<dynamic> feature = map['feature_img'];
    var feature_image = feature.map((e) => FeatureImage.fromJson(e)).toList();
    return NoticeModal(
        notice_id: map['notice_id'],
        title: map['title'],
        notice_date: map['notice_date'],
        feature_img: feature_image,
        detail: map['detail'],
        created_at: map['created_at'],
        pdf_files: pdf_files);
  }
}

class NoticeFile {
  String? name;
  String? value;
  NoticeFile({this.name, this.value});

  factory NoticeFile.fromJson(Map<String, dynamic> map) {
    return NoticeFile(
      name: map['name'],
      value: map['value'],
    );
  }
}

class FeatureImage {
  String? name;
  String? value;
  FeatureImage({this.name, this.value});

  factory FeatureImage.fromJson(Map<String, dynamic> map) {
    return FeatureImage(
      name: map['name'],
      value: map['value'],
    );
  }
}


class PalikaIntroData {
  String? title;
  dynamic data;

  PalikaIntroData({this.title, this.data});

  factory PalikaIntroData.fromJson(Map<String, dynamic> json) {
    return PalikaIntroData(
      title: json['title'],
      data: json['data'],
    );
  }
}

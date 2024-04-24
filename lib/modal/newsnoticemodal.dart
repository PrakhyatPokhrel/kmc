class NewsNoticeModal {
  int? news_id;
  String? title;
  String? news_date;
  List? feature_img;
  String? link;
  String? detail;
  List<NewsFile>? news_file;
  String? created_at;
  NewsNoticeModal({
    this.news_id,
    this.title,
    this.news_date,
    this.feature_img,
    this.link,
    this.detail,
    this.created_at,
    this.news_file,
  });

  factory NewsNoticeModal.fromJson(Map<String, dynamic> map) {
    List<dynamic>? news = map['news_img'];
    var news_file;
    if (news != null) {
      news_file = news.map((e) => NewsFile.fromJson(e)).toList();
    }

    List<dynamic> feature = map['feature_img'];
    List<dynamic> feature_image =
        feature.map((e) => FeatureImage.fromJson(e)).toList();
    return NewsNoticeModal(
      news_id: map['news_id'],
      title: map['title'],
      news_date: map['news_date'],
      feature_img: feature_image,
      link: map['link'],
      detail: map['detail'],
      created_at: map['created_at'],
      news_file: news_file,
    );
  }
}

class NewsFile {
  String? name;
  String? value;
  NewsFile({this.name, this.value});

  factory NewsFile.fromJson(Map<String, dynamic> map) {
    return NewsFile(
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

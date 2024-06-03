
class TenderNotice {
  dynamic tender_id;
  dynamic title;
  dynamic last_date;
  dynamic detail;
  dynamic feature_img;
  dynamic created_at;
  dynamic updated_at;
  dynamic notice_file;
  TenderNotice({
    this.tender_id,
    this.title,
    this.last_date,
    this.detail,
    this.feature_img,
    this.created_at,
    this.updated_at,
    this.notice_file,
  });

  factory TenderNotice.fromJson(Map<String, dynamic> map) {
    return TenderNotice(
      tender_id: map['tender_id'],
      title: map['title'],
      last_date: map['last_date'],
      detail: map['detail'],
      feature_img: map['feature_img'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      notice_file: map['notice_file'],
    );
  }
}

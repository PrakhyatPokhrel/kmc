
class Usernotificationmodal {
  dynamic created_at;
  dynamic message;
  dynamic id;
  dynamic notifiable_id;
  dynamic notifiable_type;
  dynamic read_at;
  dynamic type;
  dynamic title;
  dynamic updated_at;
  dynamic headline;
  Usernotificationmodal(
      {this.created_at,
      this.message,
      this.id,
      this.notifiable_id,
      this.notifiable_type,
      this.read_at,
      this.type,
      this.updated_at,
      this.headline,
      this.title});

  factory Usernotificationmodal.fromJson(Map<String, dynamic> map) {
    return Usernotificationmodal(
        created_at: map['created_at'],
        message: map['message'],
        id: map['id'],
        notifiable_id: map['notifiable_id'],
        notifiable_type: map['notifiable_type'],
        read_at: map['read_at'],
        type: map['type'],
        updated_at: map['date'],
        title: map['title'],
        headline: map['headline']);
  }
}

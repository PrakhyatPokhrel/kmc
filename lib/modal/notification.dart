import 'dart:convert';

class NotificationModal {
  dynamic notif_id;
  dynamic title;
  dynamic style;
  dynamic message;
  dynamic flag;
  dynamic headline;
  dynamic content;
  dynamic img;
  dynamic picture;
  dynamic status;
  dynamic category;
  dynamic date;
  dynamic priority;
  dynamic vibrate;
  dynamic sound;
  dynamic forceShow;
  dynamic notif_category;
  dynamic created_at;
  dynamic updated_at;
  NotificationModal({
    this.notif_id,
    this.title,
    this.style,
    this.message,
    this.flag,
    this.headline,
    this.content,
    this.img,
    this.picture,
    this.status,
    this.category,
    this.date,
    this.priority,
    this.vibrate,
    this.sound,
    this.forceShow,
    this.notif_category,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'notif_id': notif_id,
      'title': title,
      'style': style,
      'message': message,
      'flag': flag,
      'headline': headline,
      'content': content,
      'img': img,
      'picture': picture,
      'status': status,
      'category': category,
      'date': date,
      'priority': priority,
      'vibrate': vibrate,
      'sound': sound,
      'forceShow': forceShow,
      'notif_category': notif_category,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory NotificationModal.fromJson(Map<String, dynamic> map) {
    return NotificationModal(
      notif_id: map['notif_id'],
      title: map['title'],
      style: map['style'],
      message: map['message'],
      flag: map['flag'],
      headline: map['headline'],
      content: map['content'],
      img: map['img'],
      picture: map['picture'],
      status: map['status'],
      category: map['category'],
      date: map['date'],
      priority: map['priority'],
      vibrate: map['vibrate'],
      sound: map['sound'],
      forceShow: map['forceShow'],
      notif_category: map['notif_category'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }
}

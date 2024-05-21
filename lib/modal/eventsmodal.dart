class Eventsapi {
  List<Gallery>? image_gallery;
  int? event_id;
  dynamic title;
  dynamic location;
  dynamic date;
  dynamic time;
  dynamic date_nep;
  dynamic time_nep;
  dynamic organizer;
  dynamic mobile;
  dynamic status;
  dynamic detail;
  dynamic approved1;
  dynamic approved2;
  dynamic approved3;
  dynamic notif_status;
  dynamic image_url;
  dynamic image_bodySmall;
  Eventsapi({
    this.image_gallery,
    this.event_id,
    this.title,
    this.location,
    this.date,
    this.time,
    this.date_nep,
    this.time_nep,
    this.organizer,
    this.mobile,
    this.status,
    this.detail,
    this.approved1,
    this.approved2,
    this.approved3,
    this.notif_status,
    this.image_url,
    this.image_bodySmall,
  });

  factory Eventsapi.fromJson(Map<String, dynamic> map) {
    List<dynamic> datas = map['event']['eventimages'];
    var lists =
        datas == null ? null : datas.map((e) => Gallery.fromJson(e)).toList();
    return Eventsapi(
      image_gallery: lists,
      event_id: map['event']['event_id'],
      title: map['event']['title'],
      location: map['event']['location'],
      date: map['event']['date'],
      time: map['event']['time'],
      date_nep: map['event']['date_nep'],
      time_nep: map['event']['time_nep'],
      organizer: map['event']['organizer'],
      mobile: map['event']['mobile'],
      status: map['event']['status'],
      detail: map['event']['detail'],
      approved1: map['event']['approved1'],
      approved2: map['event']['approved2'],
      approved3: map['event']['approved3'],
      notif_status: map['event']['notif_status'],
      image_url:
          map['title_image'] == null ? null : map['title_image']['image_url'],
      image_bodySmall: map['title_image'] == null
          ? null
          : map['title_image']['image_bodySmall'],
    );
  }
}

class Gallery {
  dynamic eventimage_id;
  dynamic image_url;
  dynamic image_bodySmall;
  Gallery({
    this.eventimage_id,
    this.image_url,
    this.image_bodySmall,
  });

  factory Gallery.fromJson(Map<String, dynamic> map) {
    return Gallery(
      eventimage_id: map['eventimage_id'],
      image_url: map['image_url'],
      image_bodySmall: map['image_bodySmall'],
    );
  }
}

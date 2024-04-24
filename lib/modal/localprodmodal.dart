import 'dart:convert';

class Localapi {
  int? prod_id;
  dynamic name;
  dynamic prod_type;
  dynamic detail;
  dynamic approved1;
  dynamic approved2;
  dynamic approved3;
  dynamic notif_status;
  dynamic created_at;
  dynamic updated_at;

  Localapi({
    this.prod_id,
    this.name,
    this.prod_type,
    this.detail,
    this.approved1,
    this.approved2,
    this.approved3,
    this.notif_status,
    this.created_at,
    this.updated_at,
  });

  factory Localapi.fromJson(Map<String, dynamic> map) {
    return Localapi(
      prod_id: map['prod_id'],
      name: map['name'],
      prod_type: map['prod_type'],
      detail: map['detail'],
      approved1: map['approved1'],
      approved2: map['approved2'],
      approved3: map['approved3'],
      notif_status: map['notif_status'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }
}

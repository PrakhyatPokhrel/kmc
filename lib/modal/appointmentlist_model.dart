class AppointmentList {
  late bool status;
  late List<Data> data;
  late String message;

  AppointmentList({required this.status,required this.data,required this.message});

  AppointmentList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data.map((v) => v.toJson()).toList();
      data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? isKtm;
  String? mobile;
  String? province;
  String? district;
  String? lg;
  String? ward;
  String? tole;
  String? requestTo;
  String? requestDate;
  String? requestDateEng;
  String? appointmentPurpose;
  Null appointmentPurposeOther;
  String? organization;
  String? designation;
  String? message;
  String? type;
  String? status;
  String? priority;
  String? rescheduledDate;
  Null rescheduledTime;
  String? rescheduledPerson;
  String? remarks;
  String? rescheduledDateEng;
  String? userStatus;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.isKtm,
      this.mobile,
      this.province,
      this.district,
      this.lg,
      this.ward,
      this.tole,
      this.requestTo,
      this.requestDate,
      this.requestDateEng,
      this.appointmentPurpose,
      this.appointmentPurposeOther,
      this.organization,
      this.designation,
      this.message,
      this.type,
      this.status,
      this.priority,
      this.rescheduledDate,
      this.rescheduledTime,
      this.rescheduledPerson,
      this.remarks,
      this.rescheduledDateEng,
      this.userStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    isKtm = json['is_ktm'];
    mobile = json['mobile'];
    province = json['province'];
    district = json['district'];
    lg = json['lg'];
    ward = json['ward'];
    tole = json['tole'];
    requestTo = json['request_to'];
    requestDate = json['request_date'];
    requestDateEng = json['request_date_eng'];
    appointmentPurpose = json['appointment_purpose'];
    appointmentPurposeOther = json['appointment_purpose_other'];
    organization = json['organization'];
    designation = json['designation'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    priority = json['priority'];
    rescheduledDate = json['rescheduled_date'];
    rescheduledTime = json['rescheduled_time'];
    rescheduledPerson = json['rescheduled_person'];
    remarks = json['remarks'];
    rescheduledDateEng = json['rescheduled_date_eng'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['is_ktm'] = this.isKtm;
    data['mobile'] = this.mobile;
    data['province'] = this.province;
    data['district'] = this.district;
    data['lg'] = this.lg;
    data['ward'] = this.ward;
    data['tole'] = this.tole;
    data['request_to'] = this.requestTo;
    data['request_date'] = this.requestDate;
    data['request_date_eng'] = this.requestDateEng;
    data['appointment_purpose'] = this.appointmentPurpose;
    data['appointment_purpose_other'] = this.appointmentPurposeOther;
    data['organization'] = this.organization;
    data['designation'] = this.designation;
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['rescheduled_date'] = this.rescheduledDate;
    data['rescheduled_time'] = this.rescheduledTime;
    data['rescheduled_person'] = this.rescheduledPerson;
    data['remarks'] = this.remarks;
    data['rescheduled_date_eng'] = this.rescheduledDateEng;
    data['user_status'] = this.userStatus;
    return data;
  }
}

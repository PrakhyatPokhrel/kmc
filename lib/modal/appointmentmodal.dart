// ignore_for_file: public_member_api_docs, sort_constructors_first

class AppointmentModal {
  final String name;
  final int requestTo;
  final String appointmentPurpose;
  final String appointmentPurposeOther;
  final String? organization;
  final String? designation;
  final String message;
  final String mobile;
  static const String type = "online";
  static const String status = "pending";
  final String priority;
  final String province;
  final String district;
  final String lg;
  final String ward;
  final String date;
  final String tole;
  final String is_ktm;

  const AppointmentModal({
    required this.priority,
    required this.is_ktm,
    required this.date,
    required this.name,
    required this.requestTo,
    required this.appointmentPurpose,
    required this.appointmentPurposeOther,
    this.organization,
    this.designation,
    required this.message,
    required this.mobile,
    required this.province,
    required this.district,
    required this.lg,
    required this.ward,
    required this.tole,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'request_to': requestTo,
      'appointment_purpose': appointmentPurpose,
      'appointment_purpose_other': appointmentPurposeOther,
      'organization': organization,
      'designation': designation,
      'type': type,
      'message': message,
      'mobile': mobile,
      'status': status,
      'province': province,
      'district': district,
      'lg': lg,
      'ward': ward,
      'tole': tole,
      'is_ktm': is_ktm,
      'priority': priority,
      'request_date': date,
    };
  }
}

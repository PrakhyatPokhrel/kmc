import 'dart:convert';

class LoginModal {
  dynamic status;
  dynamic message;
  dynamic token;
  dynamic role_desig;
  dynamic data;
  dynamic role;
  LoginModal({
    this.status,
    this.message,
    this.token,
    this.role_desig,
    this.data,
    this.role,
  });

  factory LoginModal.fromJson(Map<String, dynamic> map) {
    return LoginModal(
      status: map['status'],
      message: map['message'],
      token: map['token'],
      role_desig: map['role_desig'],
      data: map['data'],
      role: map['role'],
    );
  }
}

class Data {
  dynamic address;
  dynamic designation;
  dynamic education;
  dynamic email;
  dynamic emergency;
  dynamic gender;
  dynamic household_head;
  dynamic household_token;
  dynamic id;
  dynamic karmachari;
  dynamic karyapalika_sadasya;
  dynamic kd_id;
  dynamic landline;
  dynamic mobile;
  dynamic name;
  dynamic oc_where;
  dynamic occupation;
  dynamic otp_code;
  dynamic otp_expiry;
  dynamic pd_id;
  dynamic respondent_id;
  dynamic user_img;
  dynamic woda_id;
}

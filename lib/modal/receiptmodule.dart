class Receiptmodal {
  String? sp_pay_code;
  dynamic receipt;

  Receiptmodal({this.sp_pay_code, this.receipt});

  factory Receiptmodal.fromJson(Map<String, dynamic> json) {
    return Receiptmodal(
      sp_pay_code: json['sp_pay_code'],
      receipt: json['user_invoice'],
    );
  }
}

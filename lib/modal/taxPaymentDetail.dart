
class TaxPaymentDetail {
  bool? status;
  Data? data;
  String? message;

  TaxPaymentDetail({this.status, this.data, this.message});

  TaxPaymentDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  List<Calculation>? calculation;
  String? spPaymentCode;
  String? securePaymentCode;
  Bill? bill;

  Data(
      {this.calculation,
      this.spPaymentCode,
      this.securePaymentCode,
      this.bill});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['calculation'] != null) {
      calculation = <Calculation>[];
      json['calculation'].forEach((v) {
        calculation!.add(new Calculation.fromJson(v));
      });
    }
    spPaymentCode = json['sp_payment_code'];
    securePaymentCode = json['secure_payment_code'];
    bill = json['bill'] != null ? new Bill.fromJson(json['bill']) : null;
  }
}

class Calculation {
  int? year;
  List<House>? house;
  List<Land>? land;
  int? totalHouse;
  int? totalLand;
  int? totalPenalty;

  Calculation(
      {this.year,
      this.house,
      this.land,
      this.totalHouse,
      this.totalLand,
      this.totalPenalty});

  Calculation.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['house'] != null) {
      house = <House>[];
      json['house'].forEach((v) {
        house!.add(new House.fromJson(v));
      });
    }
    if (json['land'] != null) {
      land = <Land>[];
      json['land'].forEach((v) {
        land!.add(new Land.fromJson(v));
      });
    }
    totalHouse = json['total_house'];
    totalLand = json['total_land'];
    totalPenalty = json['total_penalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    if (this.house != null) {
      data['house'] = this.house!.map((v) => v.toJson()).toList();
    }
    if (this.land != null) {
      data['land'] = this.land!.map((v) => v.toJson()).toList();
    }
    data['total_house'] = this.totalHouse;
    data['total_land'] = this.totalLand;
    data['total_penalty'] = this.totalPenalty;
    return data;
  }
}

class House {
  int? year;
  String? banot;
  String? type;
  int? tax;
  int? depreciation;

  House({this.year, this.banot, this.type, this.tax, this.depreciation});

  House.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    banot = json['banot'];
    type = json['type'];
    tax = json['tax'];
    depreciation = json['depreciation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['banot'] = this.banot;
    data['type'] = this.type;
    data['tax'] = this.tax;
    data['depreciation'] = this.depreciation;
    return data;
  }
}

class Land {
  int? year;
  String? kittaNumber;
  int? amount;
  int? penalty;

  Land({this.year, this.kittaNumber, this.amount, this.penalty});

  Land.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    kittaNumber = json['kitta_number'];
    amount = json['amount'];
    penalty = json['penalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['kitta_number'] = this.kittaNumber;
    data['amount'] = this.amount;
    data['penalty'] = this.penalty;
    return data;
  }
}

class Bill {
  int? id;
  String? billid;
  String? taxPayerId;
  String? citizenshipNumber;
  dynamic province;
  dynamic district;
  dynamic municipality;
  String? totalHouse;
  String? totalLand;
  String? totalPenalty;
  String? totalAmount;
  dynamic lastPaidYear;
  String? otpCode;
  String? otpExpiry;
  int? isVerified;
  int? ownerId;
  int? payId;
  dynamic nhcPayId;
  String? createdAt;
  String? updatedAt;

  Bill(
      {this.id,
      this.billid,
      this.taxPayerId,
      this.citizenshipNumber,
      this.province,
      this.district,
      this.municipality,
      this.totalHouse,
      this.totalLand,
      this.totalPenalty,
      this.totalAmount,
      this.lastPaidYear,
      this.otpCode,
      this.otpExpiry,
      this.isVerified,
      this.ownerId,
      this.payId,
      this.nhcPayId,
      this.createdAt,
      this.updatedAt});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billid = json['billid'];
    taxPayerId = json['tax_payer_id'];
    citizenshipNumber = json['citizenship_number'];
    province = json['province'];
    district = json['district'];
    municipality = json['municipality'];
    totalHouse = json['total_house'];
    totalLand = json['total_land'];
    totalPenalty = json['total_penalty'];
    totalAmount = json['total_amount'];
    lastPaidYear = json['last_paid_year'];
    otpCode = json['otp_code'];
    otpExpiry = json['otp_expiry'];
    isVerified = json['is_verified'];
    ownerId = json['owner_id'];
    payId = json['pay_id'];
    nhcPayId = json['nhc_pay_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['billid'] = this.billid;
    data['tax_payer_id'] = this.taxPayerId;
    data['citizenship_number'] = this.citizenshipNumber;
    data['province'] = this.province;
    data['district'] = this.district;
    data['municipality'] = this.municipality;
    data['total_house'] = this.totalHouse;
    data['total_land'] = this.totalLand;
    data['total_penalty'] = this.totalPenalty;
    data['total_amount'] = this.totalAmount;
    data['last_paid_year'] = this.lastPaidYear;
    data['otp_code'] = this.otpCode;
    data['otp_expiry'] = this.otpExpiry;
    data['is_verified'] = this.isVerified;
    data['owner_id'] = this.ownerId;
    data['pay_id'] = this.payId;
    data['nhc_pay_id'] = this.nhcPayId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class TaxPaymentDetail {
//   bool? status;
//   Data? data;
//   String? message;
//   TaxPaymentDetail({
//     this.status,
//     this.data,
//     this.message,
//   });

//   factory TaxPaymentDetail.fromMap(Map<String, dynamic> map) {
//     return TaxPaymentDetail(
//       status: map['status'],
//       data: map['data'] != null ? Data.fromMap(map['data']) : null,
//       message: map['message'],
//     );
//   }
// }

// class Data {
//   List<Calculation>? calculation;
//   String? spPaymentCode;
//   String? securePaymentCode;
//   Bill? bill;
//   Data({
//     this.calculation,
//     this.spPaymentCode,
//     this.securePaymentCode,
//     this.bill,
//   });

//   factory Data.fromMap(Map<String, dynamic> map) {
//     List<dynamic> calculation = map['calculation'];
//     var calculationdetail =
//         calculation.map((e) => Calculation.fromMap(e)).toList();
//     return Data(
//       calculation: calculationdetail,
//       spPaymentCode: map['spPaymentCode'],
//       securePaymentCode: map['securePaymentCode'],
//       bill: Bill.fromMap(map['bill']),
//     );
//   }
// }

// class Bill {
//   dynamic? id;
//   String? billid;
//   String? taxPayerId;
//   String? citizenshipNumber;

//   String? totalHouse;
//   String? totalLand;
//   String? totalPenalty;
//   String? totalAmount;

//   String? otpCode;
//   String? otpExpiry;
//   dynamic? isVerified;
//   dynamic? ownerId;
//   dynamic? payId;
//   String? createdAt;
//   String? updatedAt;
//   Bill({
//     this.id,
//     this.billid,
//     this.taxPayerId,
//     this.citizenshipNumber,
//     this.totalHouse,
//     this.totalLand,
//     this.totalPenalty,
//     this.totalAmount,
//     this.otpCode,
//     this.otpExpiry,
//     this.isVerified,
//     this.ownerId,
//     this.payId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Bill.fromMap(Map<String, dynamic> map) {
//     return Bill(
//       id: map['id'],
//       billid: map['billid'],
//       taxPayerId: map['taxPayerId'],
//       citizenshipNumber: map['citizenshipNumber'],
//       totalHouse: map['totalHouse'],
//       totalLand: map['totalLand'],
//       totalPenalty: map['totalPenalty'],
//       totalAmount: map['totalAmount'],
//       otpCode: map['otpCode'],
//       otpExpiry: map['otpExpiry'],
//       isVerified: map['isVerified'],
//       ownerId: map['ownerId'],
//       payId: map['payId'],
//       createdAt: map['createdAt'],
//       updatedAt: map['updatedAt'],
//     );
//   }
// }

// class Calculation {
//   dynamic? year;
//   List<House>? house;
//   List<Land>? land;
//   dynamic? totalHouse;
//   dynamic? totalLand;
//   dynamic? totalPenalty;

//   Calculation({
//     this.house,
//     this.land,
//     this.totalHouse,
//     this.totalLand,
//     this.totalPenalty,
//     this.year,
//   });

//   factory Calculation.fromMap(Map<String, dynamic> map) {
//     List<dynamic> house = map['house'];
//     var housedetail = house.map((e) => House.fromMap(e)).toList();
//     var land = map['land'];
//     var landdetail = land.map((e) => Land.fromMap(e)).toList();
//     return Calculation(
//       house: housedetail,
//       land: landdetail,
//       totalHouse: map['totalHouse'],
//       totalLand: map['totalLand'],
//       totalPenalty: map['totalPenalty'],
//       year: map['year'],
//     );
//   }
// }

// class Land {
//   dynamic? year;
//   String? kittaNumber;
//   dynamic? amount;
//   dynamic? penalty;
//   Land({
//     this.year,
//     this.kittaNumber,
//     this.amount,
//     this.penalty,
//   });

//   factory Land.fromMap(Map<String, dynamic> map) {
//     return Land(
//       year: map['year'],
//       kittaNumber: map['kittaNumber'],
//       amount: map['amount'],
//       penalty: map['penalty'],
//     );
//   }
// }

// class House {
//   dynamic? year;
//   String? banot;
//   String? type;
//   dynamic? tax;
//   dynamic? depreciation;
//   House({
//     this.year,
//     this.banot,
//     this.type,
//     this.tax,
//     this.depreciation,
//   });

//   factory House.fromMap(Map<String, dynamic> map) {
//     return House(
//       year: map['year'],
//       banot: map['banot'],
//       type: map['type'],
//       tax: map['tax'],
//       depreciation: map['depreciation'],
//     );
//   }
// }

class TaxPayerDetailModel {
  final bool? status;
  final Data? data;
  final String? message;

  TaxPayerDetailModel({
    this.status,
    this.data,
    this.message,
  });

  TaxPayerDetailModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() =>
      {'status': status, 'data': data?.toJson(), 'message': message};
}

class Data {
  final bool? status;
  final TaxData? taxdata;

  Data({
    this.status,
    this.taxdata,
  });

  Data.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        taxdata = (json['data'] as Map<String, dynamic>?) != null
            ? TaxData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'status': status, 'data': taxdata?.toJson()};
}

class TaxData {
  final int? ownerId;
  final String? taxPayerId;
  final String? ownerName;
  final String? fatherName;
  final String? motherName;
  final dynamic husbandName;
  final String? grandfatherName;
  final dynamic fatherNameInlaw;
  final String? citizenshipNumber;
  final String? occupation;
  final String? ownerDistrict;
  final String? ownerProvince;
  final String? ownerLocal;
  final String? ownerWard;
  final String? ownerTole;
  final String? ownerHouseNumber;
  final String? ownerMobile;
  final String? ownerEmail;
  final String? gender;
  final String? maritialStatus;
  final List<TaxFamily>? taxFamily;
  final List<HouseDetail>? houseDetail;
  final List<LandDetail>? landDetail;
  final String? citizenshipFront;
  final String? citizenshipBack;
  final String? fathercitizenshipFront;
  final String? fathercitizenshipBack;
  final String? fathercitizenshipFrontInlaw;
  final String? fathercitizenshipBackInlaw;
  final String? passportPhoto;
  final String? malpotRashid;
  final String? manjurinamaDocument;
  final List<dynamic>? missingDocuments;

  TaxData({
    this.ownerId,
    this.taxPayerId,
    this.ownerName,
    this.fatherName,
    this.motherName,
    this.husbandName,
    this.grandfatherName,
    this.fatherNameInlaw,
    this.citizenshipNumber,
    this.occupation,
    this.ownerDistrict,
    this.ownerProvince,
    this.ownerLocal,
    this.ownerWard,
    this.ownerTole,
    this.ownerHouseNumber,
    this.ownerMobile,
    this.ownerEmail,
    this.gender,
    this.maritialStatus,
    this.taxFamily,
    this.houseDetail,
    this.landDetail,
    this.citizenshipFront,
    this.citizenshipBack,
    this.fathercitizenshipFront,
    this.fathercitizenshipBack,
    this.fathercitizenshipFrontInlaw,
    this.fathercitizenshipBackInlaw,
    this.passportPhoto,
    this.malpotRashid,
    this.manjurinamaDocument,
    this.missingDocuments,
  });

  TaxData.fromJson(Map<String, dynamic> json)
      : ownerId = json['owner_id'] as int?,
        taxPayerId = json['tax_payer_id'] as String?,
        ownerName = json['owner_name'] as String?,
        fatherName = json['father_name'] as String?,
        motherName = json['mother_name'] as String?,
        husbandName = json['husband_name'],
        grandfatherName = json['grandfather_name'] as String?,
        fatherNameInlaw = json['father_name_inlaw'],
        citizenshipNumber = json['citizenship_number'] as String?,
        occupation = json['occupation'] as String?,
        ownerDistrict = json['owner_district'] as String?,
        ownerProvince = json['owner_province'] as String?,
        ownerLocal = json['owner_local'] as String?,
        ownerWard = json['owner_ward'] as String?,
        ownerTole = json['owner_tole'] as String?,
        ownerHouseNumber = json['owner_house_number'] as String?,
        ownerMobile = json['owner_mobile'] as String?,
        ownerEmail = json['owner_email'] as String?,
        gender = json['gender'] as String?,
        maritialStatus = json['maritial_status'] as String?,
        taxFamily = (json['tax_family'] as List?)
            ?.map((dynamic e) => TaxFamily.fromJson(e as Map<String, dynamic>))
            .toList(),
        houseDetail = (json['house_detail'] as List?)
            ?.map(
                (dynamic e) => HouseDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        landDetail = (json['land_detail'] as List?)
            ?.map((dynamic e) => LandDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        citizenshipFront = json['citizenship_front'] as String?,
        citizenshipBack = json['citizenship_back'] as String?,
        fathercitizenshipFront = json['fathercitizenship_front'] as String?,
        fathercitizenshipBack = json['fathercitizenship_back'] as String?,
        fathercitizenshipFrontInlaw =
            json['fathercitizenship_front_inlaw'] as String?,
        fathercitizenshipBackInlaw =
            json['fathercitizenship_back_inlaw'] as String?,
        passportPhoto = json['passport_photo'] as String?,
        malpotRashid = json['malpot_rashid'] as String?,
        manjurinamaDocument = json['manjurinama_document'] as String?,
        missingDocuments = json['missing_documents'] as List?;

  Map<String, dynamic> toJson() => {
        'owner_id': ownerId,
        'tax_payer_id': taxPayerId,
        'owner_name': ownerName,
        'father_name': fatherName,
        'mother_name': motherName,
        'husband_name': husbandName,
        'grandfather_name': grandfatherName,
        'father_name_inlaw': fatherNameInlaw,
        'citizenship_number': citizenshipNumber,
        'occupation': occupation,
        'owner_district': ownerDistrict,
        'owner_province': ownerProvince,
        'owner_local': ownerLocal,
        'owner_ward': ownerWard,
        'owner_tole': ownerTole,
        'owner_house_number': ownerHouseNumber,
        'owner_mobile': ownerMobile,
        'owner_email': ownerEmail,
        'gender': gender,
        'maritial_status': maritialStatus,
        'tax_family': taxFamily?.map((e) => e.toJson()).toList(),
        'house_detail': houseDetail?.map((e) => e.toJson()).toList(),
        'land_detail': landDetail?.map((e) => e.toJson()).toList(),
        'citizenship_front': citizenshipFront,
        'citizenship_back': citizenshipBack,
        'fathercitizenship_front': fathercitizenshipFront,
        'fathercitizenship_back': fathercitizenshipBack,
        'fathercitizenship_front_inlaw': fathercitizenshipFrontInlaw,
        'fathercitizenship_back_inlaw': fathercitizenshipBackInlaw,
        'passport_photo': passportPhoto,
        'malpot_rashid': malpotRashid,
        'manjurinama_document': manjurinamaDocument,
        'missing_documents': missingDocuments
      };
}

class TaxFamily {
  final int? id;
  final String? familyName;
  final String? relation;
  final int? ownerId;
  final String? taxPayerId;
  final String? createdAt;
  final String? updatedAt;

  TaxFamily({
    this.id,
    this.familyName,
    this.relation,
    this.ownerId,
    this.taxPayerId,
    this.createdAt,
    this.updatedAt,
  });

  TaxFamily.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        familyName = json['family_name'] as String?,
        relation = json['relation'] as String?,
        ownerId = json['owner_id'] as int?,
        taxPayerId = json['tax_payer_id'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'family_name': familyName,
        'relation': relation,
        'owner_id': ownerId,
        'tax_payer_id': taxPayerId,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class HouseDetail {
  final int? id;
  final int? ownerId;
  final String? type;
  final int? talla;
  final int? houseLength;
  final int? width;
  final int? landArea;
  final int? totalLandArea;
  final String? constructionDate;
  final String? gharBanot;
  final String? gharUsage;
  final String? prayokarta;
  final int? talshineJagga;
  final int? disputedLand;
  final int? otherLand;
  final String? createdAt;
  final String? updatedAt;
  final String? nirmanPermission;
  final String? karyaSampannaDoc;

  HouseDetail({
    this.id,
    this.ownerId,
    this.type,
    this.talla,
    this.houseLength,
    this.width,
    this.landArea,
    this.totalLandArea,
    this.constructionDate,
    this.gharBanot,
    this.gharUsage,
    this.prayokarta,
    this.talshineJagga,
    this.disputedLand,
    this.otherLand,
    this.createdAt,
    this.updatedAt,
    this.nirmanPermission,
    this.karyaSampannaDoc,
  });

  HouseDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        ownerId = json['owner_id'] as int?,
        type = json['type'] as String?,
        talla = json['talla'] as int?,
        houseLength = json['house_length'] as int?,
        width = json['width'] as int?,
        landArea = json['land_area'] as int?,
        totalLandArea = json['total_land_area'] as int?,
        constructionDate = json['construction_date'] as String?,
        gharBanot = json['ghar_banot'] as String?,
        gharUsage = json['ghar_usage'] as String?,
        prayokarta = json['prayokarta'] as String?,
        talshineJagga = json['talshine_jagga'] as int?,
        disputedLand = json['disputed_land'] as int?,
        otherLand = json['other_land'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        nirmanPermission = json['nirman_permission'] as String?,
        karyaSampannaDoc = json['karya_sampanna_doc'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner_id': ownerId,
        'type': type,
        'talla': talla,
        'house_length': houseLength,
        'width': width,
        'land_area': landArea,
        'total_land_area': totalLandArea,
        'construction_date': constructionDate,
        'ghar_banot': gharBanot,
        'ghar_usage': gharUsage,
        'prayokarta': prayokarta,
        'talshine_jagga': talshineJagga,
        'disputed_land': disputedLand,
        'other_land': otherLand,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'nirman_permission': nirmanPermission,
        'karya_sampanna_doc': karyaSampannaDoc
      };
}

class LandDetail {
  final int? id;
  final String? kitta;
  final dynamic houseDetailId;
  final dynamic sabikGabisa;
  final dynamic sabikWoda;
  final int? wodaId;
  final dynamic province;
  final dynamic district;
  final dynamic localLevel;
  final String? landUnit;
  final int? areaRopani;
  final int? areaAana;
  final int? areaPaisa;
  final int? areaDaam;
  final dynamic areaBigha;
  final dynamic areaKatha;
  final dynamic areaDhur;
  final String? jaggaTole;
  final String? sadakName;
  final String? sadakType;
  final String? mulyankan;
  final dynamic remarks;
  final String? anyaJankari;
  final int? ownerId;
  final String? lalpurja;
  final int? isVerified;
  final dynamic otpExpiry;
  final dynamic otpCode;
  final String? createdAt;
  final String? updatedAt;

  LandDetail({
    this.id,
    this.kitta,
    this.houseDetailId,
    this.sabikGabisa,
    this.sabikWoda,
    this.wodaId,
    this.province,
    this.district,
    this.localLevel,
    this.landUnit,
    this.areaRopani,
    this.areaAana,
    this.areaPaisa,
    this.areaDaam,
    this.areaBigha,
    this.areaKatha,
    this.areaDhur,
    this.jaggaTole,
    this.sadakName,
    this.sadakType,
    this.mulyankan,
    this.remarks,
    this.anyaJankari,
    this.ownerId,
    this.lalpurja,
    this.isVerified,
    this.otpExpiry,
    this.otpCode,
    this.createdAt,
    this.updatedAt,
  });

  LandDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        kitta = json['kitta'] as String?,
        houseDetailId = json['house_detail_id'],
        sabikGabisa = json['sabik_gabisa'],
        sabikWoda = json['sabik_woda'],
        wodaId = json['woda_id'] as int?,
        province = json['province'],
        district = json['district'],
        localLevel = json['local_level'],
        landUnit = json['land_unit'] as String?,
        areaRopani = json['area_ropani'] as int?,
        areaAana = json['area_aana'] as int?,
        areaPaisa = json['area_paisa'] as int?,
        areaDaam = json['area_daam'] as int?,
        areaBigha = json['area_bigha'],
        areaKatha = json['area_katha'],
        areaDhur = json['area_dhur'],
        jaggaTole = json['jagga_tole'] as String?,
        sadakName = json['sadak_name'] as String?,
        sadakType = json['sadak_type'] as String?,
        mulyankan = json['mulyankan'] as String?,
        remarks = json['remarks'],
        anyaJankari = json['anya_jankari'] as String?,
        ownerId = json['owner_id'] as int?,
        lalpurja = json['lalpurja'] as String?,
        isVerified = json['is_verified'] as int?,
        otpExpiry = json['otp_expiry'],
        otpCode = json['otp_code'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'kitta': kitta,
        'house_detail_id': houseDetailId,
        'sabik_gabisa': sabikGabisa,
        'sabik_woda': sabikWoda,
        'woda_id': wodaId,
        'province': province,
        'district': district,
        'local_level': localLevel,
        'land_unit': landUnit,
        'area_ropani': areaRopani,
        'area_aana': areaAana,
        'area_paisa': areaPaisa,
        'area_daam': areaDaam,
        'area_bigha': areaBigha,
        'area_katha': areaKatha,
        'area_dhur': areaDhur,
        'jagga_tole': jaggaTole,
        'sadak_name': sadakName,
        'sadak_type': sadakType,
        'mulyankan': mulyankan,
        'remarks': remarks,
        'anya_jankari': anyaJankari,
        'owner_id': ownerId,
        'lalpurja': lalpurja,
        'is_verified': isVerified,
        'otp_expiry': otpExpiry,
        'otp_code': otpCode,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

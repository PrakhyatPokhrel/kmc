class AddressModal {
  final List<Province> province;
  final List<Zone> zone;
  final List<District> district;
  final List<LocalLevel> localLevel;
  const AddressModal({
    required this.province,
    required this.zone,
    required this.district,
    required this.localLevel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'province': province.map((x) => x.toMap()).toList(),
      'zone': zone.map((x) => x.toMap()).toList(),
      'district': district.map((x) => x.toMap()).toList(),
      'localLevel': localLevel.map((x) => x.toMap()).toList(),
    };
  }

  factory AddressModal.fromMap(Map<String, dynamic> map) {
    return AddressModal(
      province: List<Province>.from(
        (map['province']).map<Province>(
          (x) => Province.fromMap(x as Map<String, dynamic>),
        ),
      ),
      zone: List<Zone>.from(
        (map['zone']).map<Zone>(
          (x) => Zone.fromMap(x as Map<String, dynamic>),
        ),
      ),
      district: List<District>.from(
        (map['district']).map<District>(
          (x) => District.fromMap(x as Map<String, dynamic>),
        ),
      ),
      localLevel: List<LocalLevel>.from(
        (map['localLevel']).map<LocalLevel>(
          (x) => LocalLevel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Province {
  final int id;
  final String textEN;
  final String textNP;
  const Province({
    required this.id,
    required this.textEN,
    required this.textNP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': textEN,
      'textNP': textNP,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: (map['id'].toInt() ?? 0) as int,
      textEN: (map['text'] ?? '') as String,
      textNP: (map['textNP'] ?? '') as String,
    );
  }
}

class Zone {
  final int id;
  final String textEN;
  final String textNP;
  const Zone({
    required this.id,
    required this.textEN,
    required this.textNP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': textEN,
      'textNP': textNP,
    };
  }

  factory Zone.fromMap(Map<String, dynamic> map) {
    return Zone(
      id: (map['id'].toInt() ?? 0) as int,
      textEN: (map['text'] ?? '') as String,
      textNP: (map['textNP'] ?? '') as String,
    );
  }
}

class District {
  final int id;
  final int zoneid;
  final int stateid;
  final String textEN;
  final String textNP;
  const District({
    required this.id,
    required this.zoneid,
    required this.stateid,
    required this.textEN,
    required this.textNP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zoneid': zoneid,
      'stateid': stateid,
      'text': textEN,
      'textNP': textNP,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: (map['id'].toInt() ?? 0) as int,
      zoneid: (map['zoneid'].toInt() ?? 0) as int,
      stateid: (map['stateid'].toInt() ?? 0) as int,
      textEN: (map['text'] ?? '') as String,
      textNP: (map['textNP'] ?? '') as String,
    );
  }
}

class LocalLevel {
  final int id;
  final int districtid;
  final String textEN;
  final String textNP;
  const LocalLevel({
    required this.id,
    required this.districtid,
    required this.textEN,
    required this.textNP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'districtid': districtid,
      'text': textEN,
      'textNP': textNP,
    };
  }

  factory LocalLevel.fromMap(Map<String, dynamic> map) {
    return LocalLevel(
      id: (map['id'].toInt() ?? 0) as int,
      districtid: (map['districtid'].toInt() ?? 0) as int,
      textEN: (map['text'] ?? '') as String,
      textNP: (map['textNP'] ?? '') as String,
    );
  }
}

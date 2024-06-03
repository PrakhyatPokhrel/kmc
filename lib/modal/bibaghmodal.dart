
class Bibagh {
  int bibhag_id;
  String name;
  String title;
  String short_description;
  String full_description;
  String nepali_name;
  String address;
  String capacity;
  String icon;
  String status;
  String banner_text;
  String created_at;
  dynamic updated_at;

  final HeadClass head;
  final List<SubHeading> subhead;
  final List<Sub_Heading> subheading;
  Bibagh({
    required this.bibhag_id,
    required this.name,
    required this.title,
    required this.short_description,
    required this.full_description,
    required this.nepali_name,
    required this.address,
    required this.capacity,
    required this.icon,
    required this.status,
    required this.banner_text,
    required this.created_at,
    required this.updated_at,
    required this.head,
    required this.subhead,
    required this.subheading,
  });

  factory Bibagh.fromjson(Map<String, dynamic> map) {
    dynamic data1 = map['head'];
    HeadClass headdata = HeadClass.fromJson(data1);
    List<dynamic> data2 = map['subheading'];
    var subheading1 = data2.map((e) => SubHeading.fromJson(e)).toList();
    List<dynamic> data3 = map['sub_heading'];
    var subheading2 = data3.map((e) => Sub_Heading.fromJson(e)).toList();

    return Bibagh(
        bibhag_id: map['bibhag_id'],
        name: map['name'],
        title: map['title'],
        short_description: map['short_description'],
        full_description: map['full_description'],
        nepali_name: map['nepali_name'],
        address: map['address'],
        capacity: map['capacity'],
        icon: map['icon'],
        status: map['status'],
        banner_text: map['banner_text'],
        created_at: map['created_at'],
        updated_at: map['updated_at'],
        head: headdata,
        subhead: subheading1,
        subheading: subheading2);
  }
}

class HeadClass {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic address;
  dynamic mobile;
  dynamic gender;
  dynamic user_img;
  dynamic education;
  dynamic occupation;
  dynamic oc_where;
  dynamic woda_id;
  dynamic kd_id;
  dynamic pd_id;
  dynamic karyapalika_sadasya;
  dynamic designation;
  dynamic platform;
  dynamic mobile_info;
  dynamic detail;
  dynamic detail1;
  dynamic pass_reset;
  dynamic karmachari;
  HeadClass({
    this.id,
    this.name,
    this.email,
    this.address,
    this.mobile,
    this.gender,
    this.user_img,
    this.education,
    this.occupation,
    this.oc_where,
    this.woda_id,
    this.kd_id,
    this.pd_id,
    this.karyapalika_sadasya,
    this.designation,
    this.platform,
    this.mobile_info,
    this.detail,
    this.detail1,
    this.pass_reset,
    this.karmachari,
  });

  factory HeadClass.fromJson(Map<String, dynamic> map) {
    return HeadClass(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      mobile: map['mobile'],
      gender: map['gender'],
      user_img: map['user_img'],
      education: map['education'],
      occupation: map['occupation'],
      oc_where: map['oc_where'],
      woda_id: map['woda_id'],
      kd_id: map['kd_id'],
      pd_id: map['pd_id'],
      karyapalika_sadasya: map['karyapalika_sadasya'],
      designation: map['designation'],
      platform: map['platform'],
      mobile_info: map['mobile_info'],
      detail: map['detail'],
      detail1: map['detail1'],
      pass_reset: map['pass_reset'],
      karmachari: map['karmachari'],
    );
  }
}

class SubHeading {
  dynamic sh_id;
  dynamic title;
  dynamic url;
  dynamic body;
  dynamic icon;
  dynamic type;
  dynamic include_name;
  dynamic bibhag_id;
  dynamic created_at;
  dynamic updated_at;
  dynamic label;
  dynamic content;
  dynamic contents;
  SubHeading({
    this.sh_id,
    this.title,
    this.url,
    this.body,
    this.icon,
    this.type,
    this.include_name,
    this.bibhag_id,
    this.created_at,
    this.updated_at,
    this.label,
    this.content,
    this.contents,
  });

  factory SubHeading.fromJson(Map<String, dynamic> map) {
    return SubHeading(
      sh_id: map['sh_id'],
      title: map['title'],
      url: map['url'],
      body: map['body'],
      icon: map['icon'],
      type: map['type'],
      include_name: map['include_name'],
      bibhag_id: map['bibhag_id'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      label: map['label'],
      content: map['content'],
      contents: map['contents'],
    );
  }
}

class Sub_Heading {
  dynamic bibhag_id;
  dynamic name;
  dynamic title;
  dynamic short_description;
  dynamic full_description;
  dynamic nepali_name;
  dynamic address;
  dynamic capacity;
  dynamic icon;
  dynamic status;
  dynamic banner_text;
  dynamic created_at;
  dynamic updated_at;
  Sub_Heading({
    this.bibhag_id,
    this.name,
    this.title,
    this.short_description,
    this.full_description,
    this.nepali_name,
    this.address,
    this.capacity,
    this.icon,
    this.status,
    this.banner_text,
    this.created_at,
    this.updated_at,
  });
  // final List<Sub_HeadingHead> subheadinghead;

  factory Sub_Heading.fromJson(Map<String, dynamic> map) {
    return Sub_Heading(
      bibhag_id: map['bibhag_id'],
      name: map['name'],
      title: map['title'],
      short_description: map['short_description'],
      full_description: map['full_description'],
      nepali_name: map['nepali_name'],
      address: map['address'],
      capacity: map['capacity'],
      icon: map['icon'],
      status: map['status'],
      banner_text: map['banner_text'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }
}

class Sub_HeadingHead {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic address;
  dynamic mobile;
  dynamic gender;
  dynamic user_img;
  dynamic education;
  dynamic occupation;
  dynamic oc_where;
  dynamic woda_id;
  dynamic kd_id;
  dynamic pd_id;
  dynamic karyapalika_sadasya;
  dynamic designation;
  dynamic platform;
  dynamic mobile_info;
  dynamic detail;
  dynamic detail1;
  dynamic pass_reset;
  dynamic karmachari;
  Sub_HeadingHead({
    this.id,
    this.name,
    this.email,
    this.address,
    this.mobile,
    this.gender,
    this.user_img,
    this.education,
    this.occupation,
    this.oc_where,
    this.woda_id,
    this.kd_id,
    this.pd_id,
    this.karyapalika_sadasya,
    this.designation,
    this.platform,
    this.mobile_info,
    this.detail,
    this.detail1,
    this.pass_reset,
    this.karmachari,
  });

  factory Sub_HeadingHead.fromJson(Map<String, dynamic> map) {
    return Sub_HeadingHead(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      mobile: map['mobile'],
      gender: map['gender'],
      user_img: map['user_img'],
      education: map['education'],
      occupation: map['occupation'],
      oc_where: map['oc_where'],
      woda_id: map['woda_id'],
      kd_id: map['kd_id'],
      pd_id: map['pd_id'],
      karyapalika_sadasya: map['karyapalika_sadasya'],
      designation: map['designation'],
      platform: map['platform'],
      mobile_info: map['mobile_info'],
      detail: map['detail'],
      detail1: map['detail1'],
      pass_reset: map['pass_reset'],
      karmachari: map['karmachari'],
    );
  }
}

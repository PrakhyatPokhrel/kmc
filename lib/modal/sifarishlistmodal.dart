
class SifarishModal {
  dynamic cate_name;
  List<FormList>? formdata;
  SifarishModal({
    this.cate_name,
    this.formdata,
  });

  factory SifarishModal.fromJson(Map<String, dynamic> json) {
    List<dynamic> datas = json['forms'];
    var lists = datas.map((e) => FormList.fromJson(e)).toList();
    return SifarishModal(cate_name: json['cate_name'], formdata: lists);
  }
}

class FormList {
  dynamic form_id;
  dynamic form_name;
  FormList({
    this.form_id,
    this.form_name,
  });

  factory FormList.fromJson(Map<String, dynamic> map) {
    return FormList(
      form_id: map['form_id'],
      form_name: map['form_name'],
    );
  }
}

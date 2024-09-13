
class BasicformModal {
  dynamic childlabel;
  dynamic form_child;
  List<Fieldslist>? fields;
  BasicformModal({
    this.childlabel,
    this.form_child,
    this.fields,
  });

  factory BasicformModal.fromJson(Map<String, dynamic> map) {
    List<dynamic> datas = map['data']['fields'];
    var lists = datas.map((e) => Fieldslist.fromJson(e)).toList();
    return BasicformModal(
        childlabel: map['data']['child_label'],
        form_child: map['data']['form_child'],
        fields: lists);
  }
}

class Fieldslist {
  dynamic db_field;
  dynamic name;
  dynamic type;
  List? value;
  Fieldslist({
    this.db_field,
    this.name,
    this.type,
    this.value,
  });

  factory Fieldslist.fromJson(Map<String, dynamic> map) {
    var values = map['values'];
    var filedvalue = values;
    //  != null
    //     ? values.map((e) => Selectvalue.fromJson(e)).toList()
    //     : null;
    return Fieldslist(
        db_field: map['db_field'],
        name: map['name'],
        type: map['type'],
        value: filedvalue!);
  }
}

// class Selectvalue {
//   dynamic name;
//   dynamic value;
//   Selectvalue({
//     this.name,
//     this.value,
//   });

//   factory Selectvalue.fromJson(Map<String, dynamic> map) {
//     return Selectvalue(name: map['name'], value: map['value']);
//   }
// }

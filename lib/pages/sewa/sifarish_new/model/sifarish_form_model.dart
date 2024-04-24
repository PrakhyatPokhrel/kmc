import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_dropdown.dart';
import 'package:nepali_utils/nepali_utils.dart';

class SifarishFormModel extends Equatable {
  final int formDetailId;
  final bool isEnglish;
  final String formId;
  final String formName;
  final String? cost;
  final int? shangrillaRateId;
  final String? childLabel;
  final int formChild;
  final int active;
  final String? remark;
  final String required;
  final int cateId;
  final UnmodifiableListView<SifarishFieldModel> fields;
  final List<SifarishFieldModel> documents;
  final List<SifarishFieldModel> childFields;
  final List<SifarishFieldModel> childDocuments;

  const SifarishFormModel({
    required this.formDetailId,
    required this.formId,
    required this.formName,
    this.cost,
    this.shangrillaRateId,
    this.childLabel,
    required this.formChild,
    required this.active,
    this.remark,
    required this.required,
    required this.cateId,
    required this.fields,
    required this.documents,
    required this.childFields,
    required this.childDocuments,
    required this.isEnglish,
  });

  factory SifarishFormModel.fromMap(Map<String, dynamic> map) {
    return SifarishFormModel(
      formDetailId: map["form_detail_id"].toInt() as int,
      formId: map["form_id"] as String,
      isEnglish: map["is_english"] == 1 ? true : false,
      formName: map["form_name"] as String,
      cost: map["cost"] as String?,
      shangrillaRateId: map["shangrilla_rate_id"],
      childLabel: map["child_label"] == "null" ? null : map["child_label"],
      formChild: map["form_child"].toInt() as int,
      active: map["active"].toInt() as int,
      remark: map["remark"] as String?,
      required: map["required"] as String,
      cateId: map["cate_id"].toInt() as int,
      fields: getSifarishListFromJson(
        map,
        fieldGenericName: 'field',
        fieldTypeGenericName: 'field_type',
        isDocType: false,
        isChildField: false,
        isEnglish: map["is_english"] == 1 ? true : false,
      ),
      documents: getSifarishDocFromJson(
        map,
        fieldGenericName: 'doc',
        isEnglish: map["is_english"] == 1 ? true : false,
      ),
      childFields: getSifarishListFromJson(map,
          fieldGenericName: 'child_field',
          fieldTypeGenericName: 'c_fieldtype',
          isChildField: true,
          isEnglish: map["is_english"] == 1 ? true : false,
          isDocType: false),
      childDocuments: getSifarishDocFromJson(
        map,
        fieldGenericName: 'child_doc',
        isEnglish: map["is_english"] == 1 ? true : false,
      ),
    );
  }

  static UnmodifiableListView<SifarishFieldModel> getSifarishDocFromJson(
    Map<String, dynamic> map, {
    required String fieldGenericName, // like 'field', 'child_field'
    required bool isEnglish,
  }) {
    List<SifarishFieldModel> tempfields = [];
    for (int i = 1; i <= 50; i++) {
      if (map['$fieldGenericName$i'] != null) {
        tempfields.add(
          SifarishFieldModel(
            isEnglish: isEnglish,
            fieldName: '$fieldGenericName$i',
            label: map['$fieldGenericName$i'],
            fieldTypeEnum: SifarishFieldTypeEnum.photo,
          ),
        );
        continue;
      }
      break;
    }
    return UnmodifiableListView(tempfields);
  }

  static UnmodifiableListView<SifarishFieldModel> getSifarishListFromJson(
    Map<String, dynamic> map, {
    required String fieldGenericName, // like 'field', 'child_field'
    required String fieldTypeGenericName, // like 'field_type', 'c_fieldtype'
    required bool isDocType,
    required bool isChildField,
    required bool isEnglish,
  }) {
    List<SifarishFieldModel> tempfields = [];
    for (int i = 1; i <= 50; i++) {
      if (map['$fieldGenericName$i'] == null) {
        // If there is child sifarish, add count as dropdown field
        if (map["form_child"] == 1 && !isChildField) {
          tempfields.add(
            SifarishFieldModel(
              isEnglish: isEnglish,
              fieldName: "count",
              label: map["child_label"],
              fieldTypeEnum: SifarishFieldTypeEnum.select,
              textInputType: TextInputType.number,
              selectFieldValues: List.generate(
                8,
                (index) => CustomDropdownType(
                  displayName: isEnglish
                      ? (index + 1).toString()
                      : NepaliUnicode.convert((index + 1).toString()),
                  value: index + 1,
                ),
              ),
            ),
          );
        }
        break;
      }
      tempfields.add(
        SifarishFieldModel.fromValues(
          isEnglish: isEnglish,
          fieldNameIndex: i,
          fieldName: '$fieldGenericName$i',
          label: map['$fieldGenericName$i'],
          fieldType: isDocType
              ? SifarishFieldTypeEnum.photo
              : map['$fieldTypeGenericName${i}'],
          selectFieldValuesString: map['$fieldTypeGenericName${i}'] == "select"
              ? map['field_value']
              : null,
        ),
      );
    }
    return UnmodifiableListView(tempfields);
  }

  @override
  List<Object> get props => [
        formDetailId,
        formId,
        formName,
        formChild,
        active,
        required,
        cateId,
        fields,
        documents,
        childFields,
        childDocuments
      ];
}

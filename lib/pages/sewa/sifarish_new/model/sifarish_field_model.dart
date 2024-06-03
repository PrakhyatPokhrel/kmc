import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/replaceable.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_dropdown.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

// <option value="0">विवरणको प्रकार</option>
// <option value="text">text</option>
// <option value="radio">Radio</option>
// <option value="select">Select</option>
// <option value="date">Date</option>
// <option value="province">Province</option>
// <option value="district">District</option>
// <option value="local_level">Local Level</option>
// <option value="number">Number</option>
// <option value="float">Float</option>
// <option value="photo">Passport Size Photo</option>
// <option value="finger_print">Finger Print</option>

enum  SifarishFieldTypeEnum {
  text,
  radio,
  select,
  date,
  province,
  district,
  localLevel,
  number,
  float,
  photo,
  fingerPrint,
}

class SifarishFieldModel {
  final String fieldName;
  final String label;
  final SifarishFieldTypeEnum fieldTypeEnum;
  final bool? isEnglish;
  final TextInputType? textInputType;
  final String? dummyValue;
  final TextInputFormatter? inputFormatter;
  final List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>?
      validators;
  final List<CustomDropdownType>? selectFieldValues;
  XFile? file;
  SifarishFieldModel({
    required this.fieldName,
    required this.label,
    required this.fieldTypeEnum,
    this.isEnglish,
    this.validators,
    this.textInputType,
    this.inputFormatter,
    this.selectFieldValues,
    this.file,
    this.dummyValue,
  });

  factory SifarishFieldModel.fromValues({
    required String fieldName,
    required String label,
    required String fieldType,
    required bool isEnglish,
    int? fieldNameIndex,
    String? selectFieldValuesString,
  }) {
    List<String>? tempSelectFieldValues;

    if (selectFieldValuesString != null) {
      Map<String, dynamic> selectFieldValueMap =
          jsonDecode(selectFieldValuesString);
      print(selectFieldValueMap);
      if (fieldNameIndex == null) {
        throw Exception("Not implemented");
      }
      String escapeQuotefieldType = """'field_type$fieldNameIndex'""";
      if (selectFieldValueMap[escapeQuotefieldType] != null) {
        tempSelectFieldValues = List<String>.from(
            selectFieldValueMap[escapeQuotefieldType]!.map((x) => x));
      }
    }
    return SifarishFieldModel(
      fieldName: fieldName,
      label: label,
      isEnglish: isEnglish,
      dummyValue: Config.fillDummySifarishValue
          ? getDummyValue(getFieldTypeEnumByString(fieldType), isEnglish)
          : null,
      fieldTypeEnum: getFieldTypeEnumByString(fieldType),
      selectFieldValues: tempSelectFieldValues
              ?.map((x) => CustomDropdownType(displayName: x, value: x))
              .toList() ??
          [],
    );
  }

  static SifarishFieldTypeEnum getFieldTypeEnumByString(String fieldType) {
    switch (fieldType) {
      case "text":
        return SifarishFieldTypeEnum.text;
      case "radio":
        return SifarishFieldTypeEnum.radio;
      case "select":
        return SifarishFieldTypeEnum.select;
      case "date":
        return SifarishFieldTypeEnum.date;
      case "province":
        return SifarishFieldTypeEnum.province;
      case "district":
        return SifarishFieldTypeEnum.district;
      case "local_level":
        return SifarishFieldTypeEnum.localLevel;
      case "number":
        return SifarishFieldTypeEnum.number;
      case "float":
        return SifarishFieldTypeEnum.float;
      case "photo":
        return SifarishFieldTypeEnum.photo;
      case "finger_print":
        return SifarishFieldTypeEnum.fingerPrint;
      default:
        //TODO: Use SifarishFieldTypeEnum.text as default
        throw Exception("Not Implemented");
      // return SifarishFieldTypeEnum.text;
    }
  }

  // TODO: Remove this on Production
  static String? getDummyValue(SifarishFieldTypeEnum type, bool isEnglish) {
    switch (type) {
      case SifarishFieldTypeEnum.text:
        return isEnglish
            ? "Test ${Random().nextInt(1000).toString()}"
            : "टेस्ट ${NepaliUnicode.convert(Random().nextInt(1000).toString())}";
      case SifarishFieldTypeEnum.date:
        return isEnglish
            ? "${NepaliDateTime.now().year}/${NepaliDateTime.now().month}/${NepaliDateTime.now().day}"
            : "${NepaliUnicode.convert('${NepaliDateTime.now().year}')}/${NepaliUnicode.convert('${NepaliDateTime.now().month}')}/${NepaliUnicode.convert('${NepaliDateTime.now().day}')}";
      case SifarishFieldTypeEnum.number:
        return Random().nextInt(1000).toString();
      default:
        return "";
    }
  }
}

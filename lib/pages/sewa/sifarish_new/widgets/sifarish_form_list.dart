import 'package:flutter/material.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_photo_field.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_dropdown.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_text_field.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class SifarishFormList extends StatelessWidget {
  const SifarishFormList({
    Key? key,
    required this.formGroup,
    required this.sifarishFields,
    this.isCropperRequired = false,
  }) : super(key: key);
  final bool isCropperRequired;

  final FormGroup formGroup;
  final List<SifarishFieldModel> sifarishFields;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sifarishFields.length,
        itemBuilder: ((context, index) {
          var field = sifarishFields[index];
          switch (field.fieldTypeEnum) {
            case SifarishFieldTypeEnum.text:
              return CustomReactiveTextField(
                field: field,
                formControl: formGroup.controls[field.fieldName],
              );
            case SifarishFieldTypeEnum.number:
              return CustomReactiveTextField(
                field: field,
                formControl: formGroup.controls[field.fieldName],
              );
            case SifarishFieldTypeEnum.date:
              return CustomReactiveTextField(
                field: field,
                formControl: formGroup.controls[field.fieldName],
                readOnly: true,
                onTap: () async {
                  try {
                    NepaliDateTime? value = await picker.showAdaptiveDatePicker(
                        context: context,
                        initialDate: picker.NepaliDateTime.now(),
                        firstDate: picker.NepaliDateTime(1976),
                        language: NepaliUtils().language,
                        lastDate: picker.NepaliDateTime.now());
                    if (value != null) {
                      var day;
                      var month;
                      if (value.day < 10) {
                        day = "0${value.day}";
                      } else {
                        day = "${value.day}";
                      }
                      if (value.month < 10) {
                        month = "0${value.month}";
                      } else {
                        month = "${value.month}";
                      }
                      formGroup.control(field.fieldName).value =
                          "${NepaliUnicode.convert("${value.year}")}/${NepaliUnicode.convert("$month")}/${NepaliUnicode.convert("$day")}";
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              );
            case SifarishFieldTypeEnum.select:
              return CustomReactiveDropdown<CustomDropdownType>(field: field);
            case SifarishFieldTypeEnum.fingerPrint:
            case SifarishFieldTypeEnum.photo:
              return CustomPhotoField(
                field: field,
                formGroup: formGroup,
                showPdfChooserIcon: field.fieldName.contains("doc"),
                isCropperRequired: (field.label == "Passport photo") ||
                    (field.label == "व्यक्तिको तस्बिर"),
                // onFilePickSuccess: (file) async {
                //   bool isSuccess =
                //       await BlocProvider.of<SifarishFormCubit>(context)
                //           .uploadFile(file, field, formGroup);
                //   if (isSuccess) {
                //     field.file = file;
                //     setState(() {});
                //   } else {
                //     EasyLoading.showError("file_upload_failed".tr);
                //   }
                // },
              );
            default:
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Not implemented"),
              );
          }
        }),
      ),
    );
  }
}

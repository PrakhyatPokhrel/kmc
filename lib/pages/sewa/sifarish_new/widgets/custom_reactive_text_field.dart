import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_form_cubit/sifarish_form_cubit.dart';
import 'package:kmc/pages/sewa/sifarish_new/static_data/custom_regex_pattern.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_sifarish_label_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:get/get.dart';

class CustomReactiveTextField extends StatelessWidget {
  const CustomReactiveTextField({
    Key? key,
    required this.field,
    required this.formControl,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final SifarishFieldModel field;
  final AbstractControl<Object?>? formControl;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSifarishLabelText(text: field.label),
          ReactiveTextField(
            formControlName: field.fieldName,
            onTap: onTap,
            key: UniqueKey(),
            readOnly: readOnly,
            inputFormatters: field.inputFormatter != null
                ? [
                    field.inputFormatter!,
                  ]
                : getInputFormatters(field.fieldTypeEnum, context),
            keyboardType:
                field.textInputType ?? getTextInputType(field.fieldTypeEnum),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            validationMessages: (control) => {
              'required': "validation_field".tr,
              'email': "email_validate".tr,
              'maxLength': "maxLength".tr,
              'minLength': "minLength".tr,
              'pattern': "pattern".tr,
            },
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }

  static List<TextInputFormatter>? getInputFormatters(
      SifarishFieldTypeEnum fieldTypeEnum, context) {
    switch (fieldTypeEnum) {
      case SifarishFieldTypeEnum.text:
        return [
          BlocProvider.of<SifarishFormCubit>(context)
                  .sifarishFormGlobal
                  .isEnglish
              ? FilteringTextInputFormatter.allow(
                  CustomRegexPattern.englishInput)
              : FilteringTextInputFormatter.allow(
                  CustomRegexPattern.nepaliInput),
        ];
      default:
        return null;
    }
  }

  static TextInputType getTextInputType(SifarishFieldTypeEnum fieldTypeEnum) {
    switch (fieldTypeEnum) {
      case SifarishFieldTypeEnum.text:
        return TextInputType.text;
      case SifarishFieldTypeEnum.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

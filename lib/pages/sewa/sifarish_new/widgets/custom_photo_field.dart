import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_form_cubit/sifarish_form_cubit.dart';
import 'package:kmc/utils/image_picker/image_picker_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:get/get.dart';

class CustomPhotoField extends StatefulWidget {
  const CustomPhotoField({
    Key? key,
    required this.field,
    // required this.onFilePickSuccess,
    required this.formGroup,
    this.showPdfChooserIcon = true,
    this.isCropperRequired = false,
  }) : super(key: key);
  final bool isCropperRequired;
  final SifarishFieldModel field;
  // final void Function(XFile?) onFilePickSuccess;
  final bool showPdfChooserIcon;
  final FormGroup formGroup;

  @override
  State<CustomPhotoField> createState() => _CustomPhotoFieldState();
}

class _CustomPhotoFieldState extends State<CustomPhotoField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              title: Text(
                widget.field.label,
                style: TextStyle(
                  fontSize: 16,
                  color: text,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      ImageHandler(
                          isCropperRequired: widget.isCropperRequired,
                          onFilePickSuccess: (file) async {
                            bool isSuccess =
                                await BlocProvider.of<SifarishFormCubit>(
                                        context)
                                    .uploadFile(
                                        file, widget.field, widget.formGroup);
                            if (isSuccess) {
                              widget.field.file = file;
                              setState(() {});
                            } else {
                              EasyLoading.showError("file_upload_failed".tr);
                            }
                          }).getImage(context);
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: primary,
                      size: 27,
                    ),
                  ),
                  if (widget.showPdfChooserIcon)
                    IconButton(
                      onPressed: () async {
                        FilePickerResult? filePickerResult =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                          allowMultiple: false,
                        );
                        if (filePickerResult != null) {
                          XFile? file =
                              XFile(filePickerResult.files.single.path!);
                          bool isSuccess =
                              await BlocProvider.of<SifarishFormCubit>(context)
                                  .uploadFile(
                                      file, widget.field, widget.formGroup);
                          if (isSuccess) {
                            widget.field.file = file;
                            setState(() {});
                          } else {
                            EasyLoading.showError("file_upload_failed".tr);
                          }
                          // widget.onFilePickSuccess(file);
                        }
                      },
                      icon: Icon(
                        Icons.attach_file,
                        color: primary,
                        size: 27,
                      ),
                    )
                ],
              ),
            ),
          ),
          if (widget.field.file != null &&
              widget.field.file?.path.split('.').last != "pdf")
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 8),
                height: 200,
                child: Image.file(
                  File(widget.field.file!.path),
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          if (widget.field.file != null &&
              widget.field.file?.path.split('.').last == "pdf")
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.picture_as_pdf_sharp,
                    color: text,
                    size: 27,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      widget.field.file!.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // FutureBuilder<Uint8List>(
          //     future: widget.field.file!.readAsBytes(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return Container(
          //           height: 200,
          //           padding: EdgeInsets.only(top: 8),
          //           child: SfPdfViewer.memory(
          //             snapshot.data!,
          //             canShowScrollStatus: true,
          //             enableDoubleTapZooming: false,
          //             enableDocumentLinkAnnotation: false,
          //           ),
          //         );
          //       } else {
          //         return SizedBox();
          //       }
          //     })
        ],
      ),
    );
  }
}

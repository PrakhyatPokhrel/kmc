import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/custom_button.dart';
import 'package:kmc/components/custom_dialog.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHandler {
  final void Function(XFile) onFilePickSuccess;
  final bool isCropperRequired;
  ImageHandler(
      {required this.onFilePickSuccess, this.isCropperRequired = false});
  getImage(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => ImagePickerDialog(
        onFilePickSuccess: onFilePickSuccess,
        isCropperRequired: isCropperRequired,
      ),
    );
  }
}

class ImagePickerDialog extends StatelessWidget {
  ImagePickerDialog(
      {required this.onFilePickSuccess, this.isCropperRequired = false});

  final Function onFilePickSuccess;
  final bool isCropperRequired;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(14.0),
            topRight: const Radius.circular(14.0),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  PermissionStatus storagePermission =
                      await Permission.storage.status;
                  if (!storagePermission.isGranted) {
                    PermissionStatus askedPermissionStatus =
                        await Permission.storage.request();
                    // if (!askedPermissionStatus.isGranted) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => CustomAlertDialog(
                    //       title: "permission_error".tr,
                    //       description: "enable_storage_permission".tr,
                    //       actions: [
                    //         CustomButton(
                    //             title: "SETTINGS".tr,
                    //             onPressed: () async {
                    //               await openAppSettings();
                    //               Navigator.pop(context);
                    //             })
                    //       ],
                    //     ),
                    //   );
                    //   return;
                    // }
                  }
                  XFile? file = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 25,
                  );
                  if (file != null) {
                    if (isCropperRequired) {
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                        sourcePath: file.path,
                        maxHeight: 250,
                        maxWidth: 250,
                        aspectRatioPresets: [
                          CropAspectRatioPreset.square,
                        ],
                        uiSettings: [
                          AndroidUiSettings(
                              toolbarTitle: 'Cropper',
                              toolbarColor: Colors.deepOrange,
                              toolbarWidgetColor: Colors.white,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false),
                          IOSUiSettings(
                            title: 'Cropper',
                          ),
                          // WebUiSettings(
                          //   context: context,
                          // ),
                        ],
                      );
                      if (croppedFile != null) {
                        onFilePickSuccess(XFile(croppedFile.path));
                      }
                      // onFilePickSuccess(file);
                      Navigator.pop(context);
                    } else {
                      onFilePickSuccess(file);
                      Navigator.pop(context);
                    }
                  }
                },
                child: new ListTile(
                  leading: new Icon(Icons.image, color: primary),
                  title: Text('load_gallery'.tr),
                ),
              ),
              new GestureDetector(
                onTap: () async {
                  PermissionStatus cameraStatus =
                      await Permission.camera.status;
                  if (!cameraStatus.isGranted) {
                    PermissionStatus askedPermissionStatus =
                        await Permission.camera.request();
                    if (!askedPermissionStatus.isGranted) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          title: "permission_error".tr,
                          description: "enable_storage_permission".tr,
                          actions: [
                            CustomButton(
                                title: "SETTINGS".tr,
                                onPressed: () async {
                                  await openAppSettings();
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      );
                      return;
                    }
                  }
                  try {
                    XFile? file = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 25,
                    );
                    if (file != null) {
                      if (isCropperRequired) {
                        CroppedFile? croppedFile =
                            await ImageCropper().cropImage(
                          sourcePath: file.path,
                          maxHeight: 250,
                          maxWidth: 250,
                          aspectRatioPresets: [
                            CropAspectRatioPreset.square,
                          ],
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            IOSUiSettings(
                              title: 'Cropper',
                            ),
                            // WebUiSettings(
                            //   context: context,
                            // ),
                          ],
                        );
                        if (croppedFile != null) {
                          onFilePickSuccess(XFile(croppedFile.path));
                        }
                        // onFilePickSuccess(file);
                        Navigator.pop(context);
                      } else {
                        onFilePickSuccess(file);
                        Navigator.pop(context);
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: new ListTile(
                  leading: new Icon(Icons.camera, color: primary),
                  title: Text('open_camera'.tr),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: new ListTile(
                  leading: new Icon(Icons.cancel_outlined, color: primary),
                  title: Text('cancel'.tr),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

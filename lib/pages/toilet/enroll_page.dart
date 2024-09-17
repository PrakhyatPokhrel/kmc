import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/toilet/image_picker_for_toilet.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

class EnrollPage extends StatefulWidget {
  const EnrollPage({Key? key}) : super(key: key);

  @override
  EnrollPageState createState() => EnrollPageState();
}

class EnrollPageState extends State<EnrollPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var _currentType;
  bool? checkboxValue = false;
  // List<ImageInputAdapter> _images;
  XFile? imagefile;
  XFile? applicationFile;
  String? imageUploadURL;
  var type = [
    {"name": "private", "value": "private"},
    {"name": "public", "value": "public"},
  ];
  reactive_forms.FormGroup formgroup = reactive_forms.FormGroup({});

  var name = TextEditingController();
  var focalPerson = TextEditingController();
  var set_password = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var address = TextEditingController();
  var re_password = TextEditingController();
  var description = TextEditingController();
  var websiteUrl = TextEditingController();
  // String? imagePath=null;
  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  int? userID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SIGNUP'.tr, style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text("enroll_desc".tr,
                    style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16)),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilder(
                key: _fbKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.location_city, color: primary),
                      title: TextFormField(
                        controller: name,
                        validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                        decoration: InputDecoration(
                          hintText: 'Organization-name'.tr,
                        ),
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //       CustomRegexPattern.englishInput),
                        // ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: primary),
                      title: TextFormField(
                        controller: focalPerson,
                        validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                        decoration: InputDecoration(
                          hintText: 'focal_person'.tr,
                        ),
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //       CustomRegexPattern.englishInput),
                        // ],
                      ),
                    ),

                    ListTile(
                      leading: Icon(Icons.home, color: primary),
                      title: TextFormField(
                        controller: address,
                        validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                        decoration: InputDecoration(
                          hintText: '${'organization'.tr} ${'address'.tr}',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: primary,
                      ),
                      title: TextFormField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          FormBuilderValidators.email(context, errorText: 'email_validate'.tr),
                        ]),
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "${'organization'.tr} ${'EMAIL'.tr}",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: primary),
                      title: TextFormField(
                        controller: mobile,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          FormBuilderValidators.minLength(
                            context,
                            10,
                            errorText: 'minLength'.tr,
                          ),
                          FormBuilderValidators.maxLength(
                            context,
                            10,
                            errorText: 'maxLength'.tr,
                          ),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'MOBILE-NUM'.tr,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    ListTile(
                      leading: Transform.translate(
                          offset: Offset(0, -22), child: Icon(Icons.info_sharp, color: primary)),
                      title: TextFormField(
                        controller: description,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          // FormBuilderValidators.minLength(
                          //   context,
                          //   10,
                          //   errorText: 'minLength'.tr,
                          // ),
                          // FormBuilderValidators.maxLength(
                          //   context,
                          //   10,
                          //   errorText: 'maxLength'.tr,
                          // ),
                        ]),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "${'organization'.tr} ${'description'.tr}",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.language, color: primary),
                      title: TextFormField(
                        controller: websiteUrl,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          // FormBuilderValidators.minLength(
                          //   context,
                          //   10,
                          //   errorText: 'minLength'.tr,
                          // ),
                          // FormBuilderValidators.maxLength(
                          //   context,
                          //   10,
                          //   errorText: 'maxLength'.tr,
                          // ),
                        ]),
                        // maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "${'organization'.tr} ${'website_url'.tr}",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 44.0),
                          margin: const EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                          child: DropdownButton(
                            menuMaxHeight: 400,
                            hint: Text('toilet_type'.tr),
                            isExpanded: true,
                            items: type.map(
                              (val) {
                                return DropdownMenuItem(
                                    value: val["value"],
                                    child: Text(
                                      val["name"]!.tr,
                                    ));
                              },
                            ).toList(),
                            value: _currentType,
                            onChanged: (value) {
                              setState(() {
                                _currentType = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                          child: Icon(
                            Icons.location_city,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      // leading: Icon(Icons.phone, color: primary),
                      title: Text("${'organization'.tr} ${'logo'.tr}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              ToiletImageHandler(
                                  isCropperRequired: false,
                                  onFilePickSuccess: (file) {
                                    if (file.isNotEmpty) {
                                      imagefile = file[0];
                                    }
                                    // widget.field.file = file;
                                    setState(() {});
                                  }).getImage(context);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: primary,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: imagefile == null
                            ? const DecorationImage(
                                image: ExactAssetImage('assets/image.png'),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: FileImage(File(imagefile!.path)),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      // leading: Icon(Icons.phone, color: primary),
                      title: Text("application_document".tr),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // IconButton(
                          //   onPressed: () async {
                          //     ImageHandler(
                          //         isCropperRequired: false,
                          //         onFilePickSuccess: (file) async {
                          //           applicationFile = file;
                          //           setState(() {});
                          //         }).getImage(context);
                          //   },
                          //   icon: Icon(
                          //     Icons.camera_alt,
                          //     color: primary,
                          //     size: 27,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () async {
                              // PermissionStatus storage = await Permission
                              //     .manageExternalStorage
                              //     .request();
                              // print(storage.isGranted);

                              // if(storage.isGranted){
                              FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                                allowMultiple: false,
                              );
                              if (filePickerResult != null) {
                                XFile? file = XFile(filePickerResult.files.single.path!);
                                applicationFile = file;
                                setState(() {});
                              }
                              // widget.onFilePickSuccess(file);
                              // }
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
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              applicationFile != null ? applicationFile!.name : "Choose File",
                              style: TextStyle(
                                fontSize: 16,
                                color: text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: 140.0,
                    //   height: 140.0,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     image: applicationFile == null
                    //         ? DecorationImage(
                    //             image: ExactAssetImage('assets/image.png'),
                    //             fit: BoxFit.cover,
                    //           )
                    //         : DecorationImage(
                    //             image: FileImage(File(applicationFile!.path)),
                    //             fit: BoxFit.cover,
                    //           ),
                    //   ),
                    // ),
                    //         CustomPhotoField(
                    //   field: SifarishFieldModel(fieldName: "Document", label: "Document", fieldTypeEnum: SifarishFieldTypeEnum.photo),
                    //   formGroup: formgroup,
                    //   showPdfChooserIcon: true,
                    //   isCropperRequired: false,
                    //   // onFilePickSuccess: (file) async {
                    //   //   bool isSuccess =
                    //   //       await BlocProvider.of<SifarishFormCubit>(context)
                    //   //           .uploadFile(file, field, formGroup);
                    //   //   if (isSuccess) {
                    //   //     field.file = file;
                    //   //     setState(() {});
                    //   //   } else {
                    //   //     EasyLoading.showError("file_upload_failed".tr);
                    //   //   }
                    //   // },
                    // )
                    // const Divider(
                    //   height: 1.0,
                    // ),

                    //Checkbox

                    // GestureDetector(
                    //   onTap: () {
                    //     ImageHandler(onFilePickSuccess: (file) async {
                    //       String imageName =
                    //           await registerProfileImageUpload(file);
                    //       if (imageName != "") {
                    //         setState(() {
                    //           imagefile = file;
                    //           imageUploadURL = imageName;
                    //         });
                    //       }
                    //     }).getImage(context);
                    //   },
                    //   child: imagefile != null
                    //       ? Container(
                    //           width: 90.0,
                    //           height: 90.0,
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(50.0),
                    //             child: Image.file(
                    //               File(imagefile!.path),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         )
                    //       : Container(
                    //           width: 140.0,
                    //           height: 140.0,
                    //           decoration:  BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             image:  DecorationImage(
                    //               image:
                    //                    ExactAssetImage('assets/image.png'),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    // ),

                    // ImageFormField<ImageInputAdapter>(
                    //   shouldAllowMultiple: false,
                    //   onSaved: (val) => _images = val,
                    //   // initialValue: this
                    //   //     .existingImages
                    //   //     .map((i) => ImageInputAdapter(url: i.originalUrl))
                    //   //     .toList()
                    //   //     .cast<ImageInputAdapter>(),
                    //   initializeFileAsImage: (file) => ImageInputAdapter(
                    //     file: UploadableImage(
                    //       file,
                    //       storagePath: "appImages",
                    //     ),
                    //   ),
                    //   buttonBuilder: (_, count) => PhotoUploadButton(
                    //       count: count, shouldAllowMultiple: false),
                    //   previewImageBuilder: (_, image) => image.widgetize(),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              enrollButton(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  enrollButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(tertiary),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5, horizontal: 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
          onPressed: () {
            submit();

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Otp()));
          },
        ),
      ),
    );
    // return Center(
    //     child:  Container(
    //   child: ButtonTheme(
    //       minWidth: 250.0,
    //       height: 40.0,
    //       child:  RaisedButton(
    //           elevation: 1.0,
    //           disabledColor: primary,
    //           disabledTextColor: statusBar,
    //           color: primary,
    //           child: Wrap(children: [
    //             Text(
    //               'SEND'.tr,
    //               style: TextStyle(fontSize: 16, color: textPrimaryLightColor),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    //               child: Icon(Icons.arrow_forward_rounded,
    //                   color: textPrimaryLightColor),
    //             )
    //           ]),
    //           shape:  RoundedRectangleBorder(
    //             side: BorderSide(color: textPrimaryLightColor, width: 2.0),
    //             borderRadius:  BorderRadius.circular(10.0),
    //           ),
    //           onPressed: () {

    //           })),
    // ));
  }

  void submit() async {
    if (_fbKey.currentState!.validate() == true) {
      if (!(_currentType == null || applicationFile == null || imagefile == null)) {
        EasyLoading.show(status: 'Please wait...'.tr);

        _fbKey.currentState?.save();
        var logo = await dio.MultipartFile.fromFile(imagefile!.path, filename: imagefile!.path);
        var application =
            await dio.MultipartFile.fromFile(applicationFile!.path, filename: applicationFile!.name);
        var data = {
          "organization_name": name.text,
          "organization_description": description.text,
          "organization_type": _currentType,
          "focal_person": focalPerson.text,
          "organization_address": address.text,
          "organization_contact": mobile.text,
          "organization_website_url": websiteUrl.text,
          "organization_email": email.text,
          "organization_logo": logo,
          "organization_pdf": application,
        };
        // if (email.text != "") {
        //   data["email"] = email.text;
        // }
        try {
          enrollOrganization(data).then((value) => {
                EasyLoading.dismiss(),
                if (value == true)
                  {Get.back(), EasyLoading.showSuccess("Application sent for review")}
                else
                  {
                    EasyLoading.dismiss(),
                    EasyLoading.showError('Please check all fields !! or try again later')
                  }
              });
        } catch (e) {
          EasyLoading.dismiss();
          EasyLoading.showError('Please check all fields !! or try again later');
        }
      } else {
        EasyLoading.showError('Please check all fields !! or try again later');
      }
    }
  }
}

class BlogImage {
  const BlogImage({
    @required this.storagePath,
    @required this.originalUrl,
    @required this.bucketName,
    this.id,
  });

  final String? storagePath;
  final String? originalUrl;
  final String? bucketName;
  final String? id;

  static String get collectionPath => "blogImages";

  create() {}

  // static Future<BlogImage> fromUrl(String url) async {}
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/home/signUpOTP.dart';
import 'package:kmc/utils/image_picker/image_picker_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactiveForm;
import '../pages/sewa/sifarish_new/static_data/custom_regex_pattern.dart';

class EnrollPage extends StatefulWidget {
  @override
  _EnrollPageState createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  var _currentGender;
  var _currentWard;
  bool? checkboxValue = false;
  // List<ImageInputAdapter> _images;
  XFile? imagefile;
  String? imageUploadURL;
  var type = [
    {"name": "निजी", "value": "1"},
    {"name": "सार्वजनिक", "value": "2"},
    
  ];
  reactiveForm.FormGroup formgroup=reactiveForm.FormGroup({});

  var name = TextEditingController();
  var set_password = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var address = TextEditingController();
  var re_password = TextEditingController();
  var description= TextEditingController();
  String? imagePath=null;
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
                Text('SIGNUP'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
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
              FormBuilder(
                key: _fbKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: Icon(Icons.location_city, color: primary),
                      title: new TextFormField(
                        controller: name,
                        validator: FormBuilderValidators.required(context,
                            errorText: 'required_field'.tr),
                        decoration: new InputDecoration(
                          hintText: 'Organization-name'.tr,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              CustomRegexPattern.englishInput),
                        ],
                      ),
                    ),
          
                    new ListTile(
                      leading: Icon(Icons.home, color: primary),
                      title: new TextFormField(
                        controller: address,
                        validator: FormBuilderValidators.required(context,
                            errorText: 'required_field'.tr),
                        decoration: new InputDecoration(
                          hintText: 'address'.tr,
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: Icon(
                        Icons.email,
                        color: primary,
                      ),
                      title: new TextFormField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          FormBuilderValidators.email(context,
                              errorText: 'email_validate'.tr),
                        ]),
                        controller: email,
                        decoration: new InputDecoration(
                          hintText: 'EMAIL'.tr,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    new ListTile(
                      leading: Icon(Icons.phone, color: primary),
                      title: new TextFormField(
                        controller: mobile,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
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
                        decoration: new InputDecoration(
                          hintText: 'MOBILE-NUM'.tr,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                     ListTile(
                      leading: Transform.translate(
                        offset: Offset(0, -22),
                        child: Icon(Icons.info_sharp, color: primary)),
                      title: new TextFormField(
                        controller: description,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
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
                        maxLines: 3,
                        decoration: new InputDecoration(
                          hintText: 'विवरण'.tr,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 44.0),
                                  margin: EdgeInsets.only(
                                      top: 5.0, left: 28.0, right: 16.0),
                                  child: DropdownButton(
                                    menuMaxHeight: 400,
                                    hint: Text('शौचालयको प्रकार'.tr),
                                    isExpanded: true,
                                    items: type.map(
                                      (val) {
                                        return DropdownMenuItem(
                                            value: val["value"],
                                            child: Text(
                                              val["name"]!,
                                            ));
                                      },
                                    ).toList(),
                                    value: _currentWard,
                                    onChanged: (value) {
                                      setState(() {
                                        _currentWard = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 16.0, left: 16.0, right: 16.0),
                                  child: Icon(
                                    Icons.location_city,
                                    color: primary,
                                  ),
                                ),
                              ],
                            ),
                             new ListTile(
                      // leading: Icon(Icons.phone, color: primary),
                      title: Text('कम्पनीको लोगो'),
                      trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    ImageHandler(
                        isCropperRequired: false,
                        onFilePickSuccess: (file){
                            imagePath = file.path;
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
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image:imagePath==null? new DecorationImage(
                                  image:
                                      new ExactAssetImage('assets/image.png'),
                                  fit: BoxFit.cover,
                                ):new DecorationImage(
                                  image:
                                       FileImage(File(imagePath!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    new ListTile(
                      // leading: Icon(Icons.phone, color: primary),
                      title: Text('अनुप्रयोग कागजात'),
                      trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    ImageHandler(
                        isCropperRequired: false,
                        onFilePickSuccess: (file) async {
                            // imagePath = file.path;
                            setState(() {});
                        }).getImage(context);
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: primary,
                    size: 27,
                  ),
                ),
                  IconButton(
                    onPressed: () async {
                      await Permission.storage.request();
                      if(await Permission.location.isGranted){
                      FilePickerResult? filePickerResult =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                        allowMultiple: false,
                      );
                      if (filePickerResult != null) {
                        XFile? file =
                            XFile(filePickerResult.files.single.path!);
                          // widget.file = file;
                          setState(() {});
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
                    Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: new DecorationImage(
                                  image:
                                      new ExactAssetImage('assets/image.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                    //           decoration: new BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             image: new DecorationImage(
                    //               image:
                    //                   new ExactAssetImage('assets/image.png'),
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
              SizedBox(height: 40,),
                      signupButton(),
              SizedBox(height: 40,),

          
            ],
          ),
        ),
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      
      child: SizedBox(
        width:MediaQuery.of(context).size.width/1.5,
        child: ElevatedButton(
          
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(tertiary),
              padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 35)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Text('SEND'.tr,
              style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
          onPressed: () {
            // submit();
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Otp()));
          },
        ),
      ),
    );
    // return Center(
    //     child: new Container(
    //   child: ButtonTheme(
    //       minWidth: 250.0,
    //       height: 40.0,
    //       child: new RaisedButton(
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
    //           shape: new RoundedRectangleBorder(
    //             side: BorderSide(color: textPrimaryLightColor, width: 2.0),
    //             borderRadius: new BorderRadius.circular(10.0),
    //           ),
    //           onPressed: () {

    //           })),
    // ));
  }

  void submit() {
    if (_fbKey.currentState!.validate() == true) {
      EasyLoading.show(status: 'Please wait...'.tr);

      _fbKey.currentState?.save();
      var data = {
        "name": name.text,
        "address": address.text,
        "mobile": mobile.text,
        "password": set_password.text,
        "gender": _currentGender,
        "woda": _currentWard,
        "user_img": imageUploadURL != null ? imageUploadURL : 'noImg.jpg',
      };
      if (email.text != "") {
        data["email"] = email.text;
      }
      try {
        signUp(data).then((value) => {
              userID = value['data']['id'],
              EasyLoading.dismiss(),
              if (value['status'] == true)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpOTP(
                                user_id: userID,
                                email: email.text,
                                password: re_password.text,
                                mobile: mobile.text
                              ))),
                }
              else
                {
                  EasyLoading.dismiss(),
                  EasyLoading.showError(
                      'Please check all fields !! or try again later')
                }
            });
      } catch (e) {
        EasyLoading.dismiss();
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

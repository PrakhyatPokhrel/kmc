import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var contact = TextEditingController();
  var message = TextEditingController();
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
                Text('suggestions'.tr,
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: <Widget>[
                  new Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image(
                            image: AssetImage('assets/images/Banner.png'),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            'नेपालका हरेक स्थानीय निकायलाई सूचना तथा आधुनिक प्रविधिका माध्यमबाट सशक्त बनाई सिङ्गो नेपाललाई नै डिजिटल युगमा प्रवेश गराउने स्मार्टपालिकाको उद्देश्य हो । सूचना प्रविधिको यस युगमा नेपाललाई विश्वस्तरको प्रतिश्पर्धामा लैजाने यस मिशनमा तपाईं हामी सबैको साथ र सहकार्य अपरिहार्य छ।',
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Mukta')),
                      ),
                    ),
                  ]),
                  SizedBox(height: 8),
                  // Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  //     decoration: new BoxDecoration(
                  //       border: Border.all(color: primary),
                  //       color: Colors.grey.shade200,
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(16.0),
                  //       child: Text(
                  //           'Smartpalika App को स्तरउन्नतिका लागि यहाँहरुका केहि सल्लाह/सुझाव छन भने हामीलाई पठाउनुहोस ।',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               color: primary, fontSize: 16, height: 1.5)),
                  //     )),
                  FormBuilder(
                      key: _fbKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(children: <Widget>[
                        new ListTile(
                          leading: Icon(Icons.person, color: primary),
                          title: new TextFormField(
                            controller: name,
                            validator: FormBuilderValidators.required(context,
                                errorText: 'required_field'.tr),
                            decoration: new InputDecoration(
                              hintText: 'NAME'.tr,
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: Icon(
                            Icons.email,
                            color: primary,
                          ),
                          title: new TextFormField(
                            validator: FormBuilderValidators.email(context),
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
                            validator: FormBuilderValidators.required(context,
                                errorText: 'required_field'.tr),
                            controller: contact,
                            decoration: new InputDecoration(
                              hintText: 'CONTACT'.tr,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        new ListTile(
                          leading: Icon(Icons.home, color: primary),
                          title: new TextFormField(
                            maxLines: 6,
                            validator: FormBuilderValidators.required(context,
                                errorText: 'required_field'.tr),
                            controller: message,
                            decoration: new InputDecoration(
                              hintText: 'MESSAGES'.tr,
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        )
                      ])),
                  SizedBox(height: 10),
                  submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitButton() {
    return Center(
        child: new Container(
      child: ButtonTheme(
          height: 40.0,
          child: new ElevatedButton(
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(Get.width - 54, 50)),
                backgroundColor: MaterialStateProperty.all(tertiary),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Wrap(children: [
                Text(
                  'SEND'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: textPrimaryLightColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Icon(Icons.arrow_forward_rounded,
                      color: textPrimaryLightColor),
                )
              ]),
            ),
            onPressed: () {
              submit();
            },
          )),
    ));
  }

  submit() {
    _fbKey.currentState?.save();

    if (_fbKey.currentState?.validate() == true) {
      var a = {
        "name": name.text,
        "email": email.text,
        "contact": contact.text,
        "message": message.text,
      };
      suggestionApi(a).then((value) => {
            if (value['success'])
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('प्रतिक्रिया/सुझावको लागि धन्यबाद '))),
                Navigator.pop(context)
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('प्रतिक्रिया/सुझाव पठाउदा समस्या आयो। '))),
                // Toast.show("सलाह/सुझाब पठाउदा समस्या आयो। ", context,
                //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM)
              }
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('कृपया फील्ड चेक गर्नुहोस्।')));
      // Toast.show("कृपया फील्ड चेक गर्नुहोस्। ", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  footer() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        decoration: new BoxDecoration(
          // border: Border.all(color: primary),
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(children: <Widget>[
          Expanded(
            flex: 5,
            child: Image(
                image: AssetImage('assets/images/sp_logo.png'), height: 100),
          ),
          Expanded(
            flex: 7,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Text('थप जानकारीको लागि',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('www.smartpalika.org'),
                  Text('hello@smartpalika.co'),
                ],
              ),
            ),
          )
        ]));
  }
}

import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/tax/propertyregister/gharregistration.dart';
import 'package:kmc/pages/tax/propertyregister/landregister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyChooseHomePage extends StatefulWidget {
  String? taxpayerID;
  PropertyChooseHomePage({this.taxpayerID});

  @override
  _PropertyChooseHomePageState createState() => _PropertyChooseHomePageState();
}

class _PropertyChooseHomePageState extends State<PropertyChooseHomePage> {
  var _site;
  var totalhomes = TextEditingController();
  var totalland = TextEditingController();
  var taxpayerID = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? taxID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // dynamic totalland;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Expanded(
                  child: Text("आफ्नो सम्पति सूचीकृत गर्नुहोस",
                      style: TextStyle(color: primary, fontSize: 22)),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 44.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('तपाई कुन सम्पति सूचीकृत गर्न चाहनुहुन्छ ?',
                    style: TextStyle(fontSize: 16, height: 1.5)),
                // Text("तपाई कुन सम्पति सूचीकृत गर्न चाहनुहुन्छ ?"),

                ListTile(
                  title: Text('घर'),
                  leading: Radio(
                    value: "home",
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                // _site == "home"
                //     ? new ListTile(
                //         leading: Icon(Icons.home, color: primary),
                //         title: new TextFormField(
                //             controller: totalhomes,
                //             decoration: new InputDecoration(
                //               hintText: 'घरको कित्ता संख्या',
                //             ),
                //             keyboardType: TextInputType.number),
                //       )
                //     : Container(),
                ListTile(
                  title: const Text('जग्गा'),
                  leading: Radio(
                    value: "land",
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),

                signupButton()
              ],
            )),
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(tertiary),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 16, horizontal: 100)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        child: Text('SEND'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
        onPressed: () {
          if (_site == "home") {
            Get.to(GharRegister(
              tax_payer_id: taxpayerID.text,
              totalhomes: totalhomes.text,
            ));
          }
          if (_site == "land") {
            Get.to(PropertyRegister());
          }
          if (_site == "landhome") {
            landhome(context);
          }
        },
      ),
    );
  }

  // Future<void> _displayTextInputDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('कित्ता संख्या'),
  //           content: new ListTile(
  //             // leading: Icon(Icons.home, color: primary),
  //             title: Column(
  //               children: [
  //                 new TextFormField(
  //                     controller: totalhomes,
  //                     decoration: new InputDecoration(
  //                       hintText: 'घरको कित्ता संख्या',
  //                     ),
  //                     keyboardType: TextInputType.number),
  //                 Row(
  //                   children: [
  //                     new TextFormField(
  //                       controller: taxpayerID,
  //                       decoration: new InputDecoration(
  //                         prefixIcon: Icon(
  //                           Icons.http,
  //                           color: primary,
  //                         ),
  //                         hintText: 'घरको कित्ता संख्या',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               color: Colors.red,
  //               textColor: Colors.white,
  //               child: Text('CANCEL'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             FlatButton(
  //               color: Colors.green,
  //               textColor: Colors.white,
  //               child: Text('OK'),
  //               onPressed: () {
  //                 setState(() {
  //                   // codeDialog = valueText;
  //                   Navigator.pop(context);
  //                   Get.to(GharRegister());
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('कित्ता संख्या'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.landscape, color: primary),
                    title: new TextFormField(
                      controller: totalhomes,
                      decoration: new InputDecoration(
                        hintText: 'घरको कित्ता संख्या',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.https, color: primary),
                    title: new TextFormField(
                      controller: taxpayerID,
                      decoration: new InputDecoration(
                        hintText: 'करदाता आईडी',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
                    Get.to(GharRegister(
                      tax_payer_id: taxpayerID.text,
                      totalhomes: totalhomes.text,
                    ));
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> gharjaggaalert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('कित्ता संख्या'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.landscape, color: primary),
                    title: new TextFormField(
                        onChanged: (text) {
                          setState(() {
                            // print(totalland);
                          });
                        },
                        controller: totalland,
                        decoration: new InputDecoration(
                          hintText: 'जग्गाको कित्ता संख्या',
                        ),
                        keyboardType: TextInputType.number),
                  ),
                  ListTile(
                    leading: Icon(Icons.https, color: primary),
                    title: new TextFormField(
                      controller: taxpayerID,
                      decoration: new InputDecoration(
                        hintText: 'करदाता आईडी',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _formKey.currentState?.save();
                    Navigator.pop(context);
                    Get.to(PropertyRegister());
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> landhome(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('कित्ता संख्या'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new ListTile(
                    leading: Icon(Icons.home, color: primary),
                    title: new TextFormField(
                        controller: totalhomes,
                        decoration: new InputDecoration(
                          hintText: 'घरको कित्ता संख्या',
                        ),
                        keyboardType: TextInputType.number),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  new ListTile(
                    leading: Icon(Icons.landscape, color: primary),
                    title: new TextFormField(
                        controller: totalland,
                        decoration: new InputDecoration(
                          hintText: 'जग्गाको कित्ता संख्या',
                        ),
                        keyboardType: TextInputType.number),
                  ),
                  ListTile(
                    leading: Icon(Icons.https, color: primary),
                    title: new TextFormField(
                        controller: taxpayerID,
                        decoration: new InputDecoration(
                          hintText: 'करदाता आईडी',
                        ),
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    // codeDialog = valueText;
                    _formKey.currentState?.save();
                    Navigator.pop(context);
                    Get.to(PropertyRegister());
                  });
                },
              ),
            ],
          );
        });
  }
}

import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:kmc/pages/tax/propertyEdit/gharEditPage.dart';
import 'package:kmc/pages/tax/propertyEdit/landEditPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyEditHomePage extends StatefulWidget {
  @override
  _PropertyEditHomePageState createState() => _PropertyEditHomePageState();
}

class _PropertyEditHomePageState extends State<PropertyEditHomePage> {
  var _site;
  TabController? _tabController;
  String? taxPayerID;

  Future<TaxPayerDetailModel> getTaxPayer() async {
    TaxPayerDetailModel detail = await getTaxPayerDetail();
    return detail;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaxPayerID();
    // getTaxPayer().then((value) {
    //   setState(() {
    //     taxPayerID = value.data!.taxdata!.taxPayerId;
    //   });
    // });
  }

  getTaxPayerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      taxPayerID = prefs.getString("sptaxID");
      // print("taxPayerID :" + "$taxPayerID");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: primary,
              )),
          toolbarHeight: size.height * 0.09,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 0.5, color: text)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("tax_id".tr,
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: primary, fontSize: 14)),
                              SizedBox(
                                width: 5.0,
                              ),
                              taxPayerID == null
                                  ? Container(
                                      height: 20,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ))
                                  : Text(": " + taxPayerID!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: primary, fontSize: 14)),
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: taxPayerID != null
                                        ? taxPayerID!
                                        : " "));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "tax_id ".tr + "copied",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ));
                              },
                              child: Icon(Icons.copy, color: primary))
                        ],
                      ),
                    )),
              ],
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(
              fontSize: 20.0,
            ),
            controller: _tabController,
            indicatorColor: primary,
            labelColor: primary,
            unselectedLabelColor: textPrimaryColor,
            tabs: [
              Tab(
                text: 'house'.tr,
              ),
              Tab(text: 'land'.tr),
              // Tab(text: 'PurbaKarmachari'.tr)
            ],
          ),
        ),
        body: TabBarView(
          children: [GharEditPage(), LandEditPage()],
        ),
      ),
    ));
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
            // Get.to(GharRegister(
            //   tax_payer_id: taxpayerID.text,
            //   totalhomes: totalhomes.text,
            // ));
            Get.to(GharEditPage());
          }
          if (_site == "land") {
            // gharjaggaalert(context);
            Get.to(LandEditPage());
          }
        },
      ),
    );
  }
}

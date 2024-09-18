import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/bibhag/bibhag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BibhagCard extends StatefulWidget {
  const BibhagCard({Key? key, this.data}) : super(key: key);

  final data;

  @override
  _BibhagCardState createState() => _BibhagCardState();
}

class _BibhagCardState extends State<BibhagCard> {
  bool loginstatus = false;

  checklogindata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    dynamic s = pref.getBool('login');
    if (s != null) {
      getToken();
      loginstatus = s;
    }
  }

  List bibagh = [];
  // List specificbibagh = [];
  dynamic specificbibagh;
  dynamic bibaghdata;

  @override
  void initState() {
    super.initState();
    checklogindata();

    // fetchapis();
  }

  fetchapis() async {
    // bibagh = await getBibagh();
    bibagh = await wardsgetpratinidhidataFromWordpress();
    // setState(() {});
    // getBibagh().then((value) => {
    //       setState(() {
    //         bibagh = value;
    //       })
    //     });
  }

  filterdata(name, context) {
    // Timer(Duration(milliseconds: 2000), () {

    setState(() {
      // specificbibagh =
      //     bibagh.where((bibagh) => bibagh['name'].toLowerCase().contains(name.toLowerCase())).toList();

      switch (name) {
        case 'प्रशासन':
          specificbibagh = bibagh[0];
          EasyLoading.dismiss();
          break;
        case 'शिक्षा':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("शिक्षा विभाग"));
          EasyLoading.dismiss();
          break;
        case 'स्वास्थ्य':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("स्वास्थ्य विभाग"));
          EasyLoading.dismiss();
          break;
        case 'सूचना प्रविधि':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("सूचना प्रबिधि बिभाग"));
          EasyLoading.dismiss();
          break;
        case 'राजस्व':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("राजश्‍व बिभाग"));
          EasyLoading.dismiss();
          break;
        case 'सहरी व्यवस्थापन':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("शहरी व्यवस्थापन बिभाग"));
          EasyLoading.dismiss();
          break;
        case 'बित्त':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("वित्त विभाग"));
          EasyLoading.dismiss();
          break;
        case 'सार्वजनिक निर्माण':
          specificbibagh =
              bibagh.firstWhere((bibagh) => bibagh['Section'].contains("सार्वजनिक निर्माण विभाग"));
          EasyLoading.dismiss();
          break;
        case 'सामाजिक विकास':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("सामाजिक विकास बिभाग"));
          EasyLoading.dismiss();
          break;
        case 'वातावरण':
          specificbibagh = bibagh.firstWhere((bibagh) => bibagh['Section'].contains("वातावरण विभाग"));
          EasyLoading.dismiss();
          break;
        case 'कृषि':
          specificbibagh =
              bibagh.firstWhere((bibagh) => bibagh['Section'].contains("कृषि तथा पशुपक्षी विभाग"));
          EasyLoading.dismiss();
          break;
        default:
          EasyLoading.dismiss();
          specificbibagh = null;
      }

      // if (specificbibagh.length == 0) {
      if (specificbibagh == null) {
        not_available_Alert(context);
      } else {
        //Get.to(Bibhag(data: json.encode(specificbibagh.first)));
        Get.to(Bibhag(data: specificbibagh));
      }
    });
    // });
    // bibagh.map((e) => print(e.name)).toList();
    // bibagh.map((e) => print(e)).where((element) =>element['name']== );
    // for (var data in bibagh) {
    //   if (data.name == 'कृषि') {
    //     specificbibagh.addAll(data);
    //     print(specificbibagh);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        EasyLoading.show(status: 'Please wait...'.tr);
        // await fetchapis();
        bibagh = await wardsgetpratinidhidataFromWordpress();
        filterdata(widget.data.nepaliname, context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
          // height: MediaQuery.of(context).size.width * 0.41,
          // width: MediaQuery.of(context).size.width * 0.41,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //     border: Border.all(width: 15.0)),
                child: SvgPicture.asset(
                  widget.data.icon,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${widget.data.title}'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // height: 1.5,
                    color: textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

not_available_Alert(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text('डाटा छैन !', textAlign: TextAlign.center, style: TextStyle(color: primary)),
          content: Text('यो सेवाको डाटा छैन !',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5)),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(tertiary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Text('cancel'.tr),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        );
      });
}

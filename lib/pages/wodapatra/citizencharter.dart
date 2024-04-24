import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/wodapatra/patralist.dart';

class CitizenCharter extends StatefulWidget {
  @override
  _CitizenCharterState createState() => _CitizenCharterState();
}

class _CitizenCharterState extends State<CitizenCharter> {
  // Future<List<WodaPatraData>> getwodapatra() async {
  //   List<WodaPatraData> wodapatralist = await wodapatraApi();
  //   return wodapatralist;
  // }

  @override
  @override
  void initState() {
    super.initState();
    wodapatraApi().then((res) => {});
  }

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
                Text('wodapatra'.tr,
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
            child: Column(
              children: <Widget>[
                topCard(),
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 500) {
                    return Container(
                        height: Get.height,
                        child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            primary: false,
                            childAspectRatio: 1.25,
                            crossAxisCount: 2,
                            children:
                                List.generate(citizenList.length, (index) {
                              var abc = '${citizenList[index].icon}';
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: sewaCard(citizenList[index], index),
                              );
                            })));
                  } else {
                    return Container(
                        height: Get.height * 0.8,
                        child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            primary: false,
                            childAspectRatio: 1.25,
                            crossAxisCount: 2,
                            children:
                                List.generate(citizenList.length, (index) {
                              var abc = '${citizenList[index].icon}';
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: sewaCard(citizenList[index], index),
                              );
                            })));
                  }
                })
              ],
            ),
            //         });
            //   }
            // }),
          ),
        ),
      ),
    );
  }

  topCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: new BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.2),
                        child: Text(
                            'काठमाडौँ महानगरपालिका र यस भित्रका वडाहरुलाई पेपरलेस बनाउने हाम्रो अभियान हो।',
                            style: TextStyle(
                              height: 1.5,
                              color: textPrimaryColor,
                              fontSize: 15,
                            )),
                      ),
                    ]),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/newIcons/sifarish_top.svg',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  sewaCard(data, index) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            var datas = {
              'title': data.title,
              'icon': data.icon,
            };

            Get.to(PatraList(data: index, title: citizenList[index].title));
          },
          child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: SvgPicture.asset(
                        data.icon,
                        height: 40,
                        width: 40,
                        color: primary,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(data.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            color: textPrimaryColor,
                            fontSize: 15,
                          )),
                    ),
                  ])),
        ));
  }
}

class CitizenData {
  final dynamic icon;
  final String title;
  CitizenData(this.title, this.icon);
}

var link = "assets/images/icons/sp-icon/";

final List<CitizenData> citizenList = [
  CitizenData('घर/जग्गा/बाटो', link + 'wadapatra_GharJagga.svg'),
  CitizenData('पञ्जीकरण', link + 'wadapatra_Panjikaran.svg'),
  CitizenData('सेवा/सुविधा', link + 'wadapatra_SewaSubidha.svg'),
  CitizenData('व्यापार/व्यवसाय/उद्योग', link + 'wadapatra_Industry.svg'),
  CitizenData("कर/कानुन", link + 'wadapatra_TaxLaw.svg'),
  CitizenData('शिक्षा/स्वास्थ्य/विदेश', link + 'wadapatra_EduHealth.svg'),
  CitizenData('बसोबास/बसाइँसराई', link + 'wadapatra_SettleMigrant.svg'),
  CitizenData("अन्य", link + 'other.svg'),
];

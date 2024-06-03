import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/pages/sewa/sewadata.dart';
import 'package:kmc/pages/sewa/sifarish/allSifarish.dart';
import 'package:kmc/pages/sewa/sifarish/sifarishList.dart';
import 'package:get/get.dart';

class Sifarish extends StatefulWidget {
  @override
  _SifarishState createState() => _SifarishState();
}

class _SifarishState extends State<Sifarish> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sifarishlitApi().then((value) => null);
  }

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
                Text('sifaris'.tr,
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
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: <Widget>[
                  topCard(),
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth >= 500) {
                      return bottomSectionTablet();
                    } else {
                      return bottomSection();
                    }
                  }),
                  gotoAll(),
                ],
              ),
            ),
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
                            'palika-name'.tr +
                                ' ' +
                                'palika-name-sub'.tr +
                                ' ' +
                                ' र यस भित्रका वडाहरुलाई पेपरलेस बनाउने हाम्रो अभियान हो।',
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

  bottomSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            primary: false,
            childAspectRatio: 1.05,
            crossAxisCount: 2,
            children: List.generate(sifarishInsideData.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: sewaCard(sifarishInsideData[index], index),
              );
            })),
      ),
    );
  }

  bottomSectionTablet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            primary: false,
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            children: List.generate(sifarishInsideData.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: sewaCard(sifarishInsideData[index], index),
              );
            })),
      ),
    );
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
              'index': index
            };
            Get.to(SifarishList(data: datas));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             SifarishList({data: data})));
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
                        height: 50,
                        width: 50,
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
                            fontSize: 18,
                          )),
                    ),
                  ])),
        ));
  }

  gotoAll() {
    return Center(
        child: new Container(
      child: ButtonTheme(
          height: 40.0,
          child: new ElevatedButton(
            style: ButtonStyle(
                minimumSize:
                    WidgetStateProperty.all(Size(Get.width - 64, 60)),
                backgroundColor: WidgetStateProperty.all(tertiary),
                padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Wrap(children: [
                Text(
                  'Viewall_sifarish'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: textPrimaryLightColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(Icons.arrow_forward_rounded,
                      color: textPrimaryLightColor),
                )
              ]),
            ),
            onPressed: () {
              var datas = {'index': sifarishInsideData.length};
              Get.to(AllSifarish(data: datas));
            },
          )),
    ));
  }
}

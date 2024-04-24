import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/pages/bibhag/bibhag.dart';
import 'package:kmc/pages/home/bibhagCard.dart';
import 'package:kmc/pages/home/homedata.dart';
import 'package:get/get.dart';

class BibaghList extends StatefulWidget {
  @override
  _BibaghListState createState() => _BibaghListState();
}

class _BibaghListState extends State<BibaghList> {
  List bibagh = [];
  List specificbibagh = [];
  dynamic bibaghdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBibagh().then((value) => {
          setState(() {
            bibagh = value;
          })
        });
  }

  filterdata(name) {
    setState(() {
      specificbibagh = bibagh
          .where((bibagh) =>
              bibagh['name'].toLowerCase().contains(name.toLowerCase()))
          .toList();
      if (specificbibagh.length == 0) {
        not_available_Alert(context);
      } else {
        Get.to(Bibhag(data: json.encode(specificbibagh.first)));
      }

      // Get.to(Bibhag(data: json.encode(specificbibagh.first)));
    });
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
                Text('departmnt'.tr,
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
                bottomSection(),
              ],
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
                            'काठमाडौँ महानगरपालिका र यस भित्रका विभागहरु निम्नानुसार छन्।',
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
        height: Get.height * 1.5,
        child: GridView.count(
            scrollDirection: Axis.vertical,
            primary: false,
            childAspectRatio: 1.05,
            crossAxisCount: 2,
            children: List.generate(homeData.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: sewaCard(homeData[index], index),
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
            filterdata(data.nepaliname);
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
                      child: Text('${data.title}'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 18,
                            color: text,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ])),
        ));
  }
}

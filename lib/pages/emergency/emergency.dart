import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/emergencynum.dart';
import 'package:kmc/pages/emergency/emergencypagemap.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  List<bool> _buttonsState = List.generate(4, (index) => false);
  int indexvalue = 0;
  @override
  void initState() {
    super.initState();
    _buttonsState[0] = true;
  }

  dynamic text = "रगत";
  Future<List<Emergencydata>> emergencyAPi() async {
    List<Emergencydata>? emergency = await emergencyAPitest(text);
    // var newMap = groupBy(emergency, (obj) => obj['type']);

    return emergency!;
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
                    Text('emergency-services'.tr,
                        style: TextStyle(color: primary, fontSize: 22)),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            Icon(Icons.arrow_back, color: primary, size: 28)),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ToggleButtons(
                            isSelected: _buttonsState,
                            selectedColor: primary,
                            splashColor: Colors.teal,
                            selectedBorderColor: primary,
                            borderWidth: 1,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: Get.width / 4.8,
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/images/icons/sp-icon/Blood.svg',
                                          height: 35,
                                          width: 35,
                                          fit: BoxFit.cover,
                                        ),
                                        new Text(
                                          'रगत',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: textPrimaryDarkColor,
                                              height: 1.5),
                                        )
                                      ],
                                    )),
                              ),
                              Container(
                                  width: Get.width / 4.8,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/images/icons/sp-icon/Embulance.svg',
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                      new Text(
                                        'एम्बुलेन्स',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: textPrimaryDarkColor,
                                            height: 1.5),
                                      )
                                    ],
                                  )),
                              Container(
                                  width: Get.width / 4.8,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/images/icons/sp-icon/FireTruck.svg',
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                      new Text(
                                        'दमकल',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: textPrimaryDarkColor,
                                            height: 1.5),
                                      )
                                    ],
                                  )),
                              Container(
                                  width: Get.width / 4.8,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/images/icons/sp-icon/NaturalCalamities.svg',
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                      new Text(
                                        'प्रा. प्रकोप',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: textPrimaryDarkColor,
                                            height: 1.5),
                                      )
                                    ],
                                  )),
                            ],
                            onPressed: (int index) => {
                              setState(() {
                                this.indexvalue = index;

                                if (index == 0) {
                                  text = "रगत";
                                  emergencyAPi();
                                }
                                if (index == 1) {
                                  text = "यम्बुलेन्स";
                                  emergencyAPi();
                                }
                                if (index == 2) {
                                  text = "दमकल";
                                  emergencyAPi();
                                }
                                if (index == 3) {
                                  text = "प्रा. प्रकोप";
                                  emergencyAPi();
                                }
                                for (int i = 0; i < _buttonsState.length; i++) {
                                  if (_buttonsState[i] == true) {
                                    _buttonsState[i] = false;
                                  }
                                }
                                _buttonsState[index] = !_buttonsState[index];
                              })
                            },
                          )),
                      Container(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('powered by Rakshya',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: textPrimaryDarkColor) // has impact
                              ),
                        ),
                      ),
                      Container(
                        child: FutureBuilder(
                          future: emergencyAPi(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ShimmerWidget().buildMovieShimmer();
                            } else if (snapshot.data.isEmpty) {
                              return Container(
                                child: Center(
                                    heightFactor: 5,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.no_sim_outlined,
                                          size: 80,
                                          color: primary,
                                        ),
                                        Text("no_data_found".tr,
                                            style: TextStyle(
                                                height: 1.3,
                                                color: textPrimaryColor,
                                                fontSize: 16))
                                      ],
                                    )),
                              );
                            } else {
                              return Container(
                                height: Get.height * 0.72,
                                child: !snapshot.data.isEmpty
                                    ? ListView.builder(
                                        itemCount: snapshot.data[0].data.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              elevation: 0,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 6,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Container(
                                                                child: Text(
                                                                  snapshot
                                                                      .data[0]
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          textPrimaryDarkColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      height:
                                                                          1.5),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Container(
                                                                child: Text(
                                                                  snapshot
                                                                      .data[0]
                                                                      .data[
                                                                          index]
                                                                      .location_name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      height:
                                                                          1.5),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  nav(snapshot
                                                                          .data[0]
                                                                          .data[
                                                                      index]);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .pin_drop_rounded,
                                                                  size: 30,
                                                                  color:
                                                                      primary,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  _callNumber(snapshot
                                                                      .data[0]
                                                                      .data[
                                                                          index]
                                                                      .contact1);
                                                                },
                                                                child: Icon(
                                                                  Icons.call,
                                                                  size: 30,
                                                                  color:
                                                                      primary,
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  )));
                                        },
                                      )
                                    : Container(),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

_callNumber(contact) async {
  bool? res = await FlutterPhoneDirectCaller.callNumber(contact);
}

nav(datas) {
  Get.to(MappageEmergency(data: datas));
}

import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LandEditPage extends StatefulWidget {
  @override
  _LandEditPageState createState() => _LandEditPageState();
}

class _LandEditPageState extends State<LandEditPage> {
  List<String>? kittaNum;

  Future<TaxPayerDetailModel> getTaxPayer() async {
    TaxPayerDetailModel detail = await getTaxPayerDetail();
    return detail;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaxPayer().then((value) => value.data!.taxdata!.houseDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getTaxPayer(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerWidget().buildMovieShimmer();
          } else if (snapshot.hasData == false) {
            return Container(
              child: Center(
                  heightFactor: 5,
                  child: Column(
                    children: [
                      Icon(
                        Icons.no_sim_outlined,
                        color: primary,
                        size: 80,
                      ),
                      Text("no_data_found".tr,
                          style: TextStyle(
                              height: 1.3,
                              color: textPrimaryColor,
                              fontSize: 16))
                    ],
                  )),
            );
          } else if (snapshot.data == null) {
            return Container(
                child: Center(
                    heightFactor: 5,
                    child: Column(
                      children: [
                        Icon(
                          Icons.no_sim_outlined,
                          color: primary,
                          size: 80,
                        ),
                        Text("no_data_found".tr,
                            style: TextStyle(
                                height: 1.3,
                                color: textPrimaryColor,
                                fontSize: 16))
                      ],
                    )));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.data.taxdata.landDetail.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.landscape, color: primary),
                      title: Text(
                        snapshot.data.data.taxdata.landDetail[index].kitta,
                        style: TextStyle(
                          color: text,
                          fontSize: 16.0,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              snapshot
                                  .data.data.taxdata.landDetail[index].kitta,
                              style: TextStyle(
                                color: primary,
                                fontSize: 24.0,
                              ),
                            ),
                            content: Table(
                              defaultColumnWidth: FixedColumnWidth(120.0),
                              border: TableBorder.all(
                                  color: text,
                                  style: BorderStyle.solid,
                                  width: 2),
                              children: [
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                snapshot
                                                            .data
                                                            .data
                                                            .taxdata
                                                            .landDetail[index]
                                                            .landUnit ==
                                                        "ropani_aana_paisa"
                                                    ? "ropani".tr
                                                    : "bigha".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  snapshot
                                                              .data
                                                              .data
                                                              .taxdata
                                                              .landDetail[index]
                                                              .landUnit ==
                                                          "ropani_aana_paisa"
                                                      ? "${snapshot.data.data.taxdata.landDetail[index].areaRopani}"
                                                      : "${snapshot.data.data.taxdata.landDetail[index].areaBigha}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                snapshot
                                                            .data
                                                            .data
                                                            .taxdata
                                                            .landDetail[index]
                                                            .landUnit ==
                                                        "ropani_aana_paisa"
                                                    ? "aana".tr
                                                    : "katha".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  snapshot
                                                              .data
                                                              .data
                                                              .taxdata
                                                              .landDetail[index]
                                                              .landUnit ==
                                                          "ropani_aana_paisa"
                                                      ? "${snapshot.data.data.taxdata.landDetail[index].areaAana}"
                                                      : "${snapshot.data.data.taxdata.landDetail[index].areaKatha}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                snapshot
                                                            .data
                                                            .data
                                                            .taxdata
                                                            .landDetail[index]
                                                            .landUnit ==
                                                        "ropani_aana_paisa"
                                                    ? "paisa".tr
                                                    : "dhur".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  snapshot
                                                              .data
                                                              .data
                                                              .taxdata
                                                              .landDetail[index]
                                                              .landUnit ==
                                                          "ropani_aana_paisa"
                                                      ? "${snapshot.data.data.taxdata.landDetail[index].areaPaisa}"
                                                      : "${snapshot.data.data.taxdata.landDetail[index].areaDhur}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                                snapshot.data.data.taxdata.landDetail[index]
                                            .landUnit ==
                                        "ropani_aana_paisa"
                                    ? TableRow(children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("daam".tr,
                                                      style: TextStyle(
                                                          fontSize: 18.0)),
                                                ),
                                              )
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "${snapshot.data.data.taxdata.landDetail[index].areaDaam}",
                                                        style: TextStyle(
                                                            fontSize: 18.0)),
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ])
                                    : TableRow(),
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("land_tole".tr,
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${snapshot.data.data.taxdata.landDetail[index].jaggaTole}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("road_name".tr,
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${snapshot.data.data.taxdata.landDetail[index].sadakName}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("road_type".tr,
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${snapshot.data.data.taxdata.landDetail[index].sadakType}",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                            ),
                                          ),
                                        )
                                      ]),
                                ]),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(tertiary),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10),
                                  child: Text('cancel'.tr),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

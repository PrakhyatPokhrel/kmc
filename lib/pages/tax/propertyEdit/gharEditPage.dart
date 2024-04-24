import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GharEditPage extends StatefulWidget {
  @override
  _GharEditPageState createState() => _GharEditPageState();
}

class _GharEditPageState extends State<GharEditPage> {
  String? housetype;
  int? id;

  Future<TaxPayerDetailModel> getTaxPayer() async {
    TaxPayerDetailModel detail = await getTaxPayerDetail();
    return detail;
  }

  Future? getGharDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTaxPayer().then((value) => value.data.taxdata.houseDetail)
    setState(() {
      getGharDetail = getTaxPayer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: getGharDetail,
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
                            height: 1.3, color: textPrimaryColor, fontSize: 16))
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
              itemCount: snapshot.data.data.taxdata.houseDetail.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: primary,
                    ),
                    title: Row(
                      children: [
                        Text(
                          snapshot.data.data.taxdata.houseDetail[index].type,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "(${snapshot.data.data.taxdata.houseDetail[index].id})",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Row(
                            children: [
                              Text(
                                snapshot
                                    .data.data.taxdata.houseDetail[index].type,
                                style:
                                    TextStyle(color: primary, fontSize: 24.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "${snapshot.data.data.taxdata.houseDetail[index].id}",
                                style:
                                    TextStyle(color: primary, fontSize: 24.0),
                              ),
                            ],
                          ),
                          content: Table(
                            defaultColumnWidth: FixedColumnWidth(140.0),
                            border: TableBorder.all(
                                color: text,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("talla".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].talla}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("land_area".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].landArea}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("total_land_area".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].totalLandArea}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("construction_date".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].constructionDate}",
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("ghar_banot".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].gharBanot}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Ghar_usage".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].gharUsage}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                              TableRow(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("prayokarta".tr,
                                                style:
                                                    TextStyle(fontSize: 18.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data.data.taxdata.houseDetail[index].prayokarta}",
                                                style:
                                                    TextStyle(fontSize: 18.0)),
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
                            // FlatButton(
                            //   onPressed: () {
                            //     Navigator.of(ctx).pop();
                            //   },
                            //   child: Text(
                            //     "Cancel",
                            //     style: TextStyle(
                            //       color: Colors.red,
                            //       fontSize: 18.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        }
      },
    ));
  }
}

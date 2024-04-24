import 'dart:convert';

import 'package:kmc/components/constantdatasforchartpage.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/digitalprofilemodal.dart';
import 'package:kmc/pages/digitalprofile/Populationchartpage.dart';
import 'package:kmc/pages/digitalprofile/agechart.dart';
import 'package:kmc/pages/digitalprofile/chartpage.dart';
import 'package:kmc/pages/digitalprofile/literacy.dart';
import 'package:kmc/pages/digitalprofile/road.dart';
import 'package:kmc/pages/home/bibhagCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:get/get.dart';

class Digitalprofile extends StatefulWidget {
  @override
  _DigitalprofileState createState() => _DigitalprofileState();
}

var link = "assets/images/icons/sp-icon/";

class DigitalData {
  DigitalData(this.title, this.icon, this.link, this.name);

  final icon;
  final link;
  final String name;
  final String title;
}

final List<DigitalData> digitalData = [
  DigitalData('POPULATION', link + 'population.svg', PopulationChartPage(),
      'population_data'),
  // DigitalData('RELIGION', link + 'prayer.svg', '', ''),
  // DigitalData(
  //     'M_LANGUAGE', link + 'translator.svg', ChartPage(), 'mother_language'),
  DigitalData('TOILETUSE', link + 'toilet.svg', ChartPage(), 'toilet_type'),

  // DigitalData('LITERACY', link + 'literacy.svg', ChartPage(), 'literacy_woda'),
  // DigitalData(
  //     'ELECTRICITY', link + 'electricity.svg', ChartPage(), 'electricity_type'),
  DigitalData('WATERUSE', link + 'tap.svg', ChartPage(), 'water_type'),
  DigitalData('FUELUSE', link + 'fire.svg', ChartPage(), 'fuel_type'),
  // DigitalData('ROAD', link + 'road.svg', ChartPage(), 'road_type'),
  // DigitalData('AGE', link + 'age.svg', AgeChartPage(), 'age_dist'),
];

class _DigitalprofileState extends State<Digitalprofile> {
  dynamic female;
  List? graphdata;
  dynamic male;
  dynamic others;
  var size;
  List specificchart = [];

  @override
  void initState() {
    super.initState();

    barchartdatawithoutmodal().then((res) => {
          setState(() {
            graphdata = res;
          })
        });
  }

  Future<DigitalProfileModal> dig_profile() async {
    DigitalProfileModal graph = await digitalprofile();
    return graph;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        child: Icon(Icons.home, color: Color(0xFF009688)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: white,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            upperPart(),
            Container(
              color: primary,
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'palika-name'.tr + ' ' + 'palika-name-sub'.tr + 'stats'.tr,
                    style:
                        TextStyle(color: textPrimaryLightColor, fontSize: 16),
                  ),
                  Text(
                    'dp_details'.tr,
                    style:
                        TextStyle(color: textPrimaryLightColor, fontSize: 16),
                  ),
                ],
              ),
            ),
            lowerPart()
          ],
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        Container(
            // color: Colors.white,
            width: double.infinity,
            height: 300,
            // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21),
            margin: EdgeInsets.fromLTRB(0, 55, 0, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.white,
            ),
            child: Column(mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'palika-name'.tr + 'palika-name-sub'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primary,
                        fontFamily: 'Mukta',
                        height: 0.5,
                        fontSize: 16.0),
                  ),
                  Text(
                    'digitalprofile'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primary,
                        fontFamily: 'Mukta',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6, // 20%
                          child: Container(
                            height: 200,
                            child: FutureBuilder(
                                future: dig_profile(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 8, 20, 8),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              dataText('जम्मा घरधुरी : ' +
                                                  '${snapshot.data.total_house}'),
                                              dataText('जनसंख्या : ' +
                                                  '${snapshot.data.total_population}'),
                                              dataText('महिला संख्या : ' +
                                                  '${snapshot.data.female_population}'),
                                              dataText('पुरुष संख्या : ' +
                                                  '${snapshot.data.male_population}'),
                                              dataText('अन्य संख्या : ' +
                                                  '${snapshot.data.others_population}'),
                                            ]));
                                  }
                                }),
                          ),
                        ),
                        Expanded(
                            flex: 6, // 60%
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FutureBuilder(
                                      future: dig_profile(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container();
                                        } else if (snapshot.hasError) {
                                          return Container();
                                        } else {
                                          return snapshot
                                                      .data.male_population !=
                                                  null
                                              ? Center(
                                                  child: Container(
                                                    height: 130,
                                                    width: 300,
                                                    child: SfCircularChart(
                                                        tooltipBehavior:
                                                            TooltipBehavior(
                                                                enable: true),
                                                        legend: Legend(
                                                            isVisible: true),
                                                        series: <
                                                            CircularSeries>[
                                                          PieSeries<ChartData,
                                                                  String>(
                                                              enableTooltip:
                                                                  true,
                                                              dataSource: [
                                                                ChartData(
                                                                    'पुरुष',
                                                                    snapshot
                                                                        .data
                                                                        .male_population
                                                                        .toDouble()),
                                                                ChartData(
                                                                    'महिला',
                                                                    snapshot
                                                                        .data
                                                                        .female_population
                                                                        .toDouble()),
                                                                ChartData(
                                                                    'अन्य',
                                                                    snapshot
                                                                        .data
                                                                        .others_population
                                                                        .toDouble()),
                                                              ],
                                                              xValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.x,
                                                              yValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.y,
                                                              name:
                                                                  'Population'),
                                                        ]),
                                                  ),
                                                )
                                              : Container();
                                        }
                                      })
                                ])),
                      ],
                    ),
                  )
                ])),
        graphdata != null
            ? Container(
                margin: EdgeInsets.fromLTRB(20, 250, 20, 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.green[200]!,
                          offset: Offset(0, 5)),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Container(
                              color: Colors.white,
                              height: 200,
                              width: 500,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:

                                      // print(snapshot.data.chart[0].data[0].);

                                      // for (int index = 0;
                                      //     index <
                                      //         snapshot.data.chart[0].data.length;
                                      //     index++) {
                                      //   abc.add(DataList.fromJson(
                                      //       snapshot.data.chart));
                                      //   print(abc);
                                      // }

                                      // // here we are storing the data into a list which is used for chart’s data source
                                      // List<SalesDatas> chartData1 =
                                      //     <SalesDatas>[];

                                      Center(
                                          child: SfCartesianChart(
                                              title: ChartTitle(
                                                  text: graphdata![4]['data']
                                                      ['chart']['key_label'],
                                                  // Aligns the chart title to left
                                                  alignment:
                                                      ChartAlignment.center,
                                                  textStyle: TextStyle(
                                                    color: primary,
                                                    fontFamily: 'Mukta',
                                                    fontSize: 14,
                                                  )),
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                              primaryXAxis: CategoryAxis(
                                                  arrangeByIndex: true),
                                              series: <
                                                  ChartSeries<dynamic, String>>[
                                        ColumnSeries<dynamic, String>(
                                          dataSource: graphdata![4]['data']
                                              ['chart']['data'],
                                          xValueMapper: (dynamic sales, _) =>
                                              sales['key'],
                                          yValueMapper: (dynamic sales, _) =>
                                              sales['value'],
                                          // name: all[0].key_label,
                                        ),
                                        // ColumnSeries<DataList, String>(
                                        //   dataSource: data2,
                                        //   xValueMapper: (DataList sales, _) =>
                                        //       sales.key,
                                        //   yValueMapper: (DataList sales, _) =>
                                        //       sales.value,
                                        //   name: all[0].key_label,
                                        // ),
                                      ])))))
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Text dataText(a) {
    return Text(
      a,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: textPrimaryColor, fontFamily: 'Mukta', fontSize: 14.0),
    );
  }

  Widget lowerPart() {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 8),
      child: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constraint) {
            if (constraint.maxWidth >= 500) {
              return Container(
                  height: Get.height * 0.7,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      primary: false,
                      childAspectRatio: 0.92,
                      crossAxisCount: 3,
                      children: List.generate(digitalData.length, (index) {
                        return GestureDetector(
                            onTap: () => {
                                  // not_available_Alert(context)
                                },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: grid(digitalData[index], context),
                            ));
                      })));
            } else {
              return Container(
                  height: Get.height * 0.55,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      primary: false,
                      childAspectRatio: 0.92,
                      crossAxisCount: 3,
                      children: List.generate(digitalData.length, (index) {
                        return GestureDetector(
                            onTap: () => {
                                  // not_available_Alert(context)
                                },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: grid(digitalData[index], context),
                            ));
                      })));
            }
          })
        ],
      ),
    );
  }

  // drawSimpleBar() {
  //   Map<String, dynamic> options = <String, dynamic>{
  //     'chart': {
  //       'height': 380,
  //       'type': 'bar',
  //     },
  //     'plotOptions': {
  //       'bar': {
  //         'distributed': true,
  //       }
  //     },
  //     'series': [
  //       {
  //         'data': [400, 430, 448, 470, 540, 580, 690, 1100]
  //       }
  //     ],
  //     'xaxis': {
  //       'categories': [
  //         'South Korea',
  //         'Canada',
  //         'United Kingdom',
  //         'Netherlands',
  //         'Italy',
  //         'France',
  //         'Japan',
  //         'United States'
  //       ],
  //       'labels': {
  //         'style': {
  //           'colors': [
  //             '#008FFB',
  //             '#00E396',
  //             '#FEB019',
  //             '#FF4560',
  //             '#775DD0',
  //             '#546E7A',
  //             '#26a69a',
  //             '#D10CE8'
  //           ]
  //         }
  //       }
  //     },
  //   };
  //   ApexCharts chart = ApexCharts('#simpleBar', options);
  //   chart.render();
  // }

  grid(data, context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: EdgeInsets.all(0),
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              filterdata(data, context);
            },
            child: Container(
                alignment: Alignment.center,
                height: 130,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        data.icon,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${data.title}'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.3,
                              color: textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ])),
          ),
        ));
  }

  filterdata(value, context) {
    setState(() {
      specificchart = graphdata!
          .where((data) =>
              data['title'].toLowerCase().contains(value.name.toLowerCase()))
          .toList();

      if (specificchart.length == 0) {
        not_available_Alert(context);
      } else {
        if (value.title == "AGE") {
          Get.to(AgeChartPage(
              data: json.encode(specificchart.first), title: value.title));
        } else if (value.title == "POPULATION") {
          Get.to(PopulationChartPage(
              data: json.encode(specificchart.first), title: value.title));
        } else if (value.title == "LITERACY") {
          Get.to(LiteracyPage(
              data: json.encode(specificchart.first), title: value.title));
        } else if (value.title == "ROAD") {
          Get.to(Roadcharttype(
              data: json.encode(specificchart.first), title: value.title));
        } else {
          Get.to(ChartPage(
              data: json.encode(specificchart.first), title: value.title));
        }
      }
    });
  }
}

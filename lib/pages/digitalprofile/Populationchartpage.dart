import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class PopulationChartPage extends StatefulWidget {
  @override
  final data;
  String? title;
  PopulationChartPage({this.data, this.title});
  _PopulationChartPageState createState() =>
      _PopulationChartPageState(data: data, title: title!);
}

class _PopulationChartPageState extends State<PopulationChartPage> {
  final data;
  String? title;

  _PopulationChartPageState({this.data, this.title});
  var navdata;
  List<dynamic> data1 = [];
  List<dynamic> data2 = [];
  List<dynamic> data3 = [];
  List<dynamic> table = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      navdata = json.decode(this.data);
      data1 = navdata['data']['chart'][0]['data'];
      data2 = navdata['data']['chart'][1]['data'];
      data3 = navdata['data']['chart'][2]['data'];

      table = navdata['data']['table'];
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
                Text('$title'.tr,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  chartPart(),
                  SizedBox(height: 5),
                  tablePart()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chartPart() {
    return Container(
        height: 300,
        child: Center(
            child: SfCartesianChart(
                title: ChartTitle(
                    text: 'जनसंख्या अनुसार विवरण',
                    // Aligns the chart title to left
                    alignment: ChartAlignment.center,
                    textStyle: TextStyle(
                      color: primary,
                      fontFamily: 'Mukta',
                      fontSize: 14,
                    )),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(arrangeByIndex: true),
                series: <ChartSeries<dynamic, String>>[
              ColumnSeries<dynamic, String>(
                dataSource: data1,
                xValueMapper: (dynamic sales, _) => sales['key'],
                yValueMapper: (dynamic sales, _) => sales['value'],
                name: navdata['data']['chart'][0]['key_label'],
              ),
              ColumnSeries<dynamic, String>(
                dataSource: data2,
                xValueMapper: (dynamic sales, _) => sales['key'],
                yValueMapper: (dynamic sales, _) => sales['value'],
                name: navdata['data']['chart'][1]['key_label'],
              ),
              ColumnSeries<dynamic, String>(
                dataSource: data3,
                xValueMapper: (dynamic sales, _) => sales['key'],
                yValueMapper: (dynamic sales, _) => sales['value'],
                name: navdata['data']['chart'][2]['key_label'],
              ),
              // ColumnSeries<DataList, String>(
              //   dataSource: data2,
              //   xValueMapper: (DataList sales, _) =>
              //       sales.key,
              //   yValueMapper: (DataList sales, _) =>
              //       sales.value,
              //   name: all[0].key_label,
              // ),
            ])));
  }

  Widget tablePart() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
                // height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columnSpacing: Get.width * 0.1,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(
                            label: Text('Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    // fontWeight: FontWeight.bold,
                                    color: primary))),
                        DataColumn(
                            label: Text('Male',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    // fontWeight: FontWeight.bold,
                                    color: primary))),
                        DataColumn(
                            label: Text('Female',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    // fontWeight: FontWeight.bold,
                                    color: primary))),
                        DataColumn(
                            label: Text('Total',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    // fontWeight: FontWeight.bold,
                                    color: primary))),
                      ],
                      rows: table
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(Text('${e['name']}',
                                  style: TextStyle(
                                      fontSize: 14, height: 1.5, color: text))),
                              DataCell(Text('${e['male']}',
                                  style: TextStyle(
                                      fontSize: 14, height: 1.5, color: text))),
                              DataCell(Text('${e['female']}',
                                  style: TextStyle(
                                      fontSize: 14, height: 1.5, color: text))),
                              DataCell(Text('${e['total']}',
                                  style: TextStyle(
                                      fontSize: 14, height: 1.5, color: text))),
                            ]),
                          )
                          .toList()),
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/yojanamodal.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';

import '../../config/replaceable.dart';

class Yojana extends StatefulWidget {
  @override
  _YojanaState createState() => _YojanaState();
}

class _YojanaState extends State<Yojana> {
  int indexvalue = 0;
  dynamic value;
  dynamic subIndex = 1;

  @override
  void initState() {
    super.initState();
    this.indexvalue = 0;
  }

  Future<List<Yojanalist>> geteventsdataapi() async {
    List<Yojanalist>? yojana = await yojanaAPis('$subIndex');

    return yojana!;
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
                Text('yojana'.tr,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: Get.height * 0.12,
                    child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        childAspectRatio: 1.02,
                        crossAxisCount: 1,
                        children: List.generate(Config.woda_count, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: wardCard(index + 1),
                          );
                        })),
                  ),
                  titleText(
                      'Wardno'.tr + ' ' + '$subIndex'.tr + ' ' + 'w_plans'.tr),
                  detailsPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  wardCard(index) {
    return InkWell(
        onTap: () {
          setState(() {
            this.subIndex = index;
            indexvalue = index - 1;
          });
        },
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: subIndex == index ? primary : shadowColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Wardno'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: subIndex == index ? primary : text)),
                  Text('$index'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: subIndex == index ? primary : text)),
                ],
              ),
            )));
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: primary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.5)),
    );
  }

  detailsPart() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: geteventsdataapi(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return buildMovieShimmer();
                    } else if (snapshot.hasError) {
                      return Container();
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
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 4.0,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              borderOnForeground: true,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 6, 6, 0),
                                      child: Text(
                                          "${snapshot.data[index].pariyojana_name}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: text,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5)),
                                    ),
                                    // Divider(),
                                    SizedBox(height: 10),
                                    wraptext(
                                        Icons.person_outline,
                                        'contractor'.tr,
                                        "${snapshot.data[index]?.contracter_name}"),
                                    wraptext(
                                        Icons.money_outlined,
                                        'budget'.tr,
                                        snapshot.data[index]?.total_amount
                                            .toString()),
                                    wraptext(
                                        Icons.money_off_outlined,
                                        'paid_amount'.tr,
                                        "${snapshot.data[index]?.paid_amount}"),
                                    wraptext(
                                        Icons.date_range_outlined,
                                        'deadline'.tr,
                                        "${snapshot.data[index]?.end_date}"),
                                    SizedBox(height: 10),
                                    new LinearPercentIndicator(
                                      percent: snapshot.data[index]
                                                  .percent_progress !=
                                              null
                                          ? double.parse(snapshot.data[index]
                                                  .percent_progress) /
                                              100
                                          : 0,
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      animation: true,
                                      lineHeight: 15.0,
                                      animationDuration: 2500,
                                      center: Text(snapshot.data[index]
                                                  .percent_progress !=
                                              null
                                          ? snapshot
                                                  .data[index].percent_progress
                                                  .toString() +
                                              '%'
                                          : '0%'),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: primary,
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  wraptext(icon, title, textt) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            icon,
            color: Colors.blueGrey,
            size: 20,
          ),
        ),
        SizedBox(width: 10),
        Text(title + ': ',
            textAlign: TextAlign.left,
            style: TextStyle(color: text, height: 1.5, fontSize: 16)),
        Text(textt,
            textAlign: TextAlign.left,
            style: TextStyle(color: primary, height: 1.5, fontSize: 16)),
      ],
    );
  }

  Widget buildMovieShimmer() => Container(
        height: Get.height,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                CustomWidget.rectangular(height: 25),
                SizedBox(
                  height: 24,
                ),
              ],
            );
          },
        ),
      );
}

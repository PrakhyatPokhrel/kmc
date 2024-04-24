import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:get/get.dart';

class Emeeting extends StatefulWidget {
  @override
  _EmeetingState createState() => _EmeetingState();
}

class _EmeetingState extends State<Emeeting> {
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
                Text('eMeeting'.tr,
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
                  Container(
                    width: Get.width,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                        margin: EdgeInsets.all(0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('title',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: primary,
                                        height: 2)),
                                Divider(height: 0.5),
                                Text('detail',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: text,
                                        height: 1.5)),
                                detailsRow('time'.tr, 'start_date'),
                                detailsRow('organizer'.tr, 'name'),
                                SizedBox(height: 10),
                                gotoButton(),
                              ]),
                        )),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  detailsRow(title, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title + ': ',
            style: TextStyle(fontSize: 16, color: text, height: 2)),
        Text(details,
            style: TextStyle(fontSize: 16, color: primary, height: 2)),
      ],
    );
  }

  gotoButton() {
    return Center(
        child: new Container(
      child: ButtonTheme(
          height: 40.0,
          child: new ElevatedButton(
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(Get.width - 64, 60)),
                backgroundColor: MaterialStateProperty.all(tertiary),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Wrap(children: [
                Text(
                  'gotoMeeting'.tr,
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
              // Get.to(AllSifarish(data: datas));
            },
          )),
    ));
  }
}

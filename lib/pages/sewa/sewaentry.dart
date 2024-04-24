import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/sewa/sewadata.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SewaEntry extends StatefulWidget {
  @override
  _SewaEntryState createState() => _SewaEntryState();
}

class _SewaEntryState extends State<SewaEntry> {
  @override
  void initState() {
    super.initState();
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
                Text('ward-service'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Get.back();
                      // Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.82,
                    child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        childAspectRatio: 0.86,
                        crossAxisCount: 2,
                        children: List.generate(sifarishData.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: sewaCard(sifarishData[index]),
                          );
                        })),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: titleText('Payment')),
                  Bhuktaani()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(color: primary, fontSize: 22)),
    );
  }

  sewaCard(data) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: SvgPicture.asset(
                      data.icon,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('${data.title}'.tr,
                      style: TextStyle(
                        height: 1.3,
                        color: textPrimaryColor,
                        fontSize: 18,
                      )),
                  SizedBox(height: 5),
                  Text('${data.details}'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.3, color: textPrimaryColor, fontSize: 10)),
                ])));
  }

  Bhuktaani() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 270,
            child: GridView.count(
                // scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                childAspectRatio: 1,
                crossAxisCount: 3,
                children: List.generate(bhuktaanigridData.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: grid(bhuktaanigridData[index]),
                  );
                })),
          ),
        ],
      ),
    ));
  }

  grid(data) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: Container(
            alignment: Alignment.center,
            height: 50,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      data.icon,
                      height: 40,
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
                          fontSize: 18,
                        )),
                  ]),
            )));
  }
}

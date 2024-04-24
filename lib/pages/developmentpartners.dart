import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class DevPartners extends StatefulWidget {
  @override
  _DevPartnersState createState() => _DevPartnersState();
}

var link = 'assets/images/icons/';

class Data {
  final String icon;
  final String title;
  Data(this.title, this.icon);
}

final List<Data> data = [
  Data('Committed Nepal', link + 'Committed.png'),
  Data('Australian Aid', link + 'AustralianAid.png'),
  Data('VROCK', link + 'VROCK.png'),
  Data('AEPC', link + 'AEPC.png'),
  Data('वालिङ उद्योग बाणिज्य संघ', link + 'WallingUdhyog.png'),
  Data('The Asia Foundation', link + 'AsiaFoundation.png'),
  Data('Kantipur City College', link + 'KCC.png'),
  Data('नेपाल महामहानगरपालिका संघ', link + 'Muan.png'),
];

class _DevPartnersState extends State<DevPartners> {
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
                Text('dev_partners'.tr,
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      height: Get.height * 1,
                      child: GridView.count(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          childAspectRatio: 1.02,
                          crossAxisCount: 2,
                          children: List.generate(data.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: card(data[index]),
                            );
                          })),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  card(data) {
    return Container(
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(data.icon, height: 100),
            Text(data.title, style: TextStyle(fontSize: 16))
          ],
        ));
  }
}

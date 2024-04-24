import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/modal/sifarishlistmodal.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/sewa/sifarish/sifarishForm.dart';

class SifarishList extends StatefulWidget {
  final data;
  SifarishList({this.data});
  @override
  _SifarishListState createState() => _SifarishListState(data: this.data);
}

class _SifarishListState extends State<SifarishList> {
  Future<List<SifarishModal>> sifarishcall() async {
    List<SifarishModal>? sifarishlist = await sifarishlitApi();
    return sifarishlist!;
  }

  void deactivate() {
    EasyLoading.dismiss();
  }

  var data;
  _SifarishListState({this.data});
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
                Text(data['title'],
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
            child: Column(
              children: <Widget>[
                topCard(data),
                listSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  topCard(data) {
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
                            data['title'] +
                                'का निम्ति आवश्यक कागजात तथा अन्य जानकारीका लागि नागरिक वडापत्रमा जानुहोस।',
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
                        data['icon'],
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

  listSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.73,
        child: FutureBuilder(
            future: sifarishcall(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerWidget().buildMovieShimmer();
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return new ListView.builder(
                    itemCount: snapshot.data[data['index']].formdata.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: new Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(SifarishForm(
                                    data: snapshot
                                        .data[data['index']].formdata[index]));
                              },
                              child: ListTile(
                                  title: Text(
                                    snapshot.data[data['index']].formdata[index]
                                        .form_name,
                                    style:
                                        TextStyle(fontSize: 18, color: primary),
                                  ),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: primary)),
                            )),
                      );
                    });
              }
            }),
      ),
    );
  }
}

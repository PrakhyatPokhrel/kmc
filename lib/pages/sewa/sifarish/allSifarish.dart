import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/modal/sifarishlistmodal.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/sewa/sifarish/sifarishForm.dart';

class AllSifarish extends StatefulWidget {
  final data;
  AllSifarish({this.data});
  @override
  _AllSifarishState createState() => _AllSifarishState(data: this.data);
}

class _AllSifarishState extends State<AllSifarish> {
  Future<List<SifarishModal>> sifarishcall() async {
    List<SifarishModal>? sifarishlist = await sifarishlitApi();
    return sifarishlist!;
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  var data;
  _AllSifarishState({this.data});

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
                Text('sifaris'.tr,
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
                topCard(),
                listSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  topCard() {
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
                            'palika-name'.tr +
                                ' ' +
                                'palika-name-sub'.tr +
                                ' ' +
                                ' र यस भित्रका वडाहरुलाई पेपरलेस बनाउने हाम्रो अभियान हो।',
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
                        'assets/images/icons/newIcons/sifarish_top.svg',
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
        child: FutureBuilder<List<SifarishModal>>(
            future: sifarishcall(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SifarishModal>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerWidget().buildMovieShimmer();
              } else if (snapshot.hasError) {
                return Container();
              } else if (snapshot.data!.isEmpty) {
                return Container();
              } else {
                var check = [];
                for (int i = 0; i < snapshot.data!.length; i++) {
                  for (int j = 0; j < snapshot.data![i].formdata!.length; j++) {
                    check.add(snapshot.data![i].formdata![j]);
                  }
                }

                return ListView.builder(
                    itemCount: check.length,
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
                                Get.to(SifarishForm(data: check[index]));
                              },
                              child: ListTile(
                                  title: Text(
                                    check[index].form_name,
                                    style:
                                        TextStyle(fontSize: 18, color: primary),
                                  ),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: primary)),
                            )),
                      );
                    });
                // for (int i = 0; i < data.length; i++) {
                // return
                // ListView.builder(
                //     itemCount: snapshot.data![i].formdata!.length,
                //     itemBuilder: (BuildContext ctxt, int index) {
                //       return Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30.0),
                //         ),
                //         child: new Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: GestureDetector(
                //               onTap: () {
                //                 Get.to(SifarishForm(
                //                     data:
                //                         snapshot.data![i].formdata![index]));
                //               },
                //               child: ListTile(
                //                   title: Text(
                //                     snapshot
                //                         .data![i].formdata![index].form_name,
                //                     style: TextStyle(
                //                         fontSize: 18, color: primary),
                //                   ),
                //                   trailing: Icon(Icons.chevron_right_rounded,
                //                       color: primary)),
                //             )),
                //       );
                //     });
                // }
              }

              return Container();
            }),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_spinner.dart';
import 'package:kmc/pages/pratinidhiwordpress/cubit/pratinidhinew_cubit.dart';
import 'package:kmc/pages/pratinidhiwordpress/screen/karmacharitab.dart';

import '../../../config/colors.dart';

class PratinidhiWordpress extends StatefulWidget {
  const PratinidhiWordpress({Key? key}) : super(key: key);

  @override
  State<PratinidhiWordpress> createState() => _PratinidhiWordpressState();
}

class _PratinidhiWordpressState extends State<PratinidhiWordpress> {
  void initState() {
    super.initState();
  }
  int count = 1;
  TabController? _tabController;
  //int _currentIndex = 0;
  bool isLoading = true;
  RegExp regExp = RegExp(r"https?://(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}\b/?");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
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
                Text('prati_karma'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: primary,
            labelColor: primary,
            unselectedLabelColor: textPrimaryColor,
            tabs: [
              Tab(text: 'representative'.tr),
              Tab(text: 'karmachari'.tr),
              // Tab(text: 'PurbaKarmachari'.tr)
            ],
          ),
        ),
        body: BlocBuilder<PratinidhinewCubit, PratinidhinewState>(
          builder: (context, state) {
            if (state is PratinidhinewLoaded) {
              var head = state.pratinidhiModel
                  .where((element) =>
                      element.designation == 'नगर प्रमुख' ||
                      element.designation == 'उप– प्रमुख')
                  .toList();
              var ward1 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १')
                  .toList();
              var ward2 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २')
                  .toList();
              var ward3 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ३')
                  .toList();
              var ward4 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ४')
                  .toList();
              var ward5 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ५')
                  .toList();
              var ward6 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ६')
                  .toList();
              var ward7 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ७')
                  .toList();
              var ward8 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ८')
                  .toList();
              var ward9 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ९')
                  .toList();
              var ward10 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १०')
                  .toList();
              var ward11 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ११')
                  .toList();
              var ward12 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १२')
                  .toList();
              var ward13 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १३')
                  .toList();
              var ward14 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १४')
                  .toList();
              var ward15 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १५')
                  .toList();
              var ward16 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १६')
                  .toList();
              var ward17 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १७')
                  .toList();
              var ward18 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १८')
                  .toList();
              var ward19 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं १९')
                  .toList();
              var ward20 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २०')
                  .toList();
              var ward21 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २१')
                  .toList();
              var ward22 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २२')
                  .toList();
              var ward23 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २३')
                  .toList();
              var ward24 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २४')
                  .toList();
              var ward25 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २५')
                  .toList();
              var ward26 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २६')
                  .toList();
              var ward27 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २७')
                  .toList();
              var ward28 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २८')
                  .toList();
              var ward29 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं २९')
                  .toList();
              var ward30 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ३०')
                  .toList();
              var ward31 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ३१')
                  .toList();
              var ward32 = state.pratinidhiModel
                  .where((element) => element.section == 'वडा नं ३२')
                  .toList();

              return TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        titletext('head'.tr),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.designation == "नगर प्रमुख" ||
                                element.designation == 'उप– प्रमुख')).length,
                            itemBuilder: (context, index) {
                              String inputString = head[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: head[index].title,
                                designation: head[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं १'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward1[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward1[index].title,
                                designation: ward1[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २ '),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं २'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward2[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward2[index].title,
                                designation: ward2[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ३'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ३'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward3[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward3[index].title,
                                designation: ward3[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ४'),
                        Container(
                          height: 123,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ४'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward4[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward4[index].title,
                                designation: ward4[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ५'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ५'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward5[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward5[index].title,
                                designation: ward5[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ६'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ६'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward6[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward6[index].title,
                                designation: ward6[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ७'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ७'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward7[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward7[index].title,
                                designation: ward7[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ८'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ८'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward8[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward8[index].title,
                                designation: ward8[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ९'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where(
                                    (element) => element.section == 'वडा नं ९'))
                                .length,
                            itemBuilder: (context, index) {
                              String inputString = ward9[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward9[index].title,
                                designation: ward9[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १o'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १०')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward10[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward10[index].title,
                                designation: ward10[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ११'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं ११')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward11[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward11[index].title,
                                designation: ward11[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १२'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १२')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward12[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward12[index].title,
                                designation: ward12[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १३'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १३')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward13[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward13[index].title,
                                designation: ward13[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १४'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १४')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward14[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward14[index].title,
                                designation: ward14[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १५'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १५')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward15[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward15[index].title,
                                designation: ward15[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १६'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १६')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward16[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward16[index].title,
                                designation: ward16[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १७'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १७')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward17[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward17[index].title,
                                designation: ward17[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १८'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १८')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward18[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward18[index].title,
                                designation: ward18[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं १९'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं १९')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward19[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward19[index].title,
                                designation: ward19[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २०'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २०')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward20[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward20[index].title,
                                designation: ward20[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २१'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २१')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward21[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward21[index].title,
                                designation: ward21[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २२'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २२')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward22[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward22[index].title,
                                designation: ward22[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २३'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २३')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward23[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward23[index].title,
                                designation: ward23[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २४'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २४')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward24[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward24[index].title,
                                designation: ward24[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २५'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २५')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward25[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward25[index].title,
                                designation: ward25[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २६'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २६')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward26[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward26[index].title,
                                designation: ward26[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २७'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २७')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward27[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward27[index].title,
                                designation: ward27[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २८'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २८')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward28[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward28[index].title,
                                designation: ward28[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं २९'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं २९')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward29[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward29[index].title,
                                designation: ward29[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ३०'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं ३०')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward30[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward30[index].title,
                                designation: ward30[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ३१'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं ३१')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward31[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward31[index].title,
                                designation: ward31[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                        titletext('वडा नं ३२'),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (state.pratinidhiModel.where((element) =>
                                element.section == 'वडा नं ३२')).length,
                            itemBuilder: (context, index) {
                              String inputString = ward32[index].photo;
                              String url =
                                  regExp.stringMatch(inputString).toString();
                              return PratinidhiCard(
                                index: index,
                                title: ward32[index].title,
                                designation: ward32[index].designation,
                                url: url,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  KarmachariTabNew()
                ],
              );
            } else if (state is PratinidhinewError) {
              BlocProvider.of<PratinidhinewCubit>(context).pratinidhiWordpressApi();
          if(count < 2)
          EasyLoading.showError(state.message!);
          count++;
          return Container();
            } else if (state is PratinidhinewInitial || state is PratinidhinewLoading) {
              return SizedBox(
                child: CustomSpinner(),
              );
            } else {
              return SizedBox(
              );
            }
          },
        ),
      ),
    ));
  }
}

class PratinidhiCard extends StatelessWidget {
  const PratinidhiCard(
      {Key? key,
      required this.url,
      required this.index,
      required this.title,
      required this.designation})
      : super(key: key);

  final String url;
  final String title;
  final String designation;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.3,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: url,
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    'assets/images/dummyuser.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 30,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: tertiary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textPrimaryDarkColor,
                fontFamily: 'Mukta',
                height: 1.5,
                fontSize: 13.0,
              ),
            ),
            Text(
              designation,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primary,
                fontFamily: 'Mukta',
                fontSize: 14.0,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget titletext(title) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    Expanded(
      child: new Container(
          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
    Text(title, style: TextStyle(color: primary, fontSize: 14)),
    Expanded(
      child: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
  ]);
}

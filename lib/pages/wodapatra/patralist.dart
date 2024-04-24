import 'package:kmc/components/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/citizencharter.dart';

class PatraList extends StatefulWidget {
  @override
  final data;
  final title;
  PatraList({this.data, this.title});
  _PatraListState createState() => _PatraListState(data: data, title: title);
}

class _PatraListState extends State<PatraList> {
  var data;
  var title;
  _PatraListState({this.data, this.title});

  Future<List<WodaPatraData>> getwodapatra() async {
    List<WodaPatraData> wodapatralist = await wodapatraApi();
    return wodapatralist;
  }

  late Future getWoda;
  @override
  void initState() {
    // TODO: implement initState
    getWoda = getwodapatra();
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
                Text('${widget.title}',
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
        // appBar: AppBar(backgroundColor: primary, title: Text(this.title)),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: getWoda,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerWidget().buildMovieShimmer();
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot
                                  .data[widget.data].wodapatradata.length,
                              itemBuilder: (context, index) {
                                // var a = snapshot.data[this.data].wodapatradata[index].category
                                //     .toString(); //Kanun ko oripari ko bracket hatauna lai]
                                return Card(
                                  child: Container(
                                    color: primary,
                                    child: ExpansionTile(
                                      initiallyExpanded:
                                          index == 0 ? true : false,
                                      trailing: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: textPrimaryLightColor,
                                      ),
                                      title: Text(
                                        snapshot.data[widget.data]
                                            .wodapatradata[index].title,
                                        // a.substring(1, a.length - 1),
                                        style: TextStyle(
                                            color: textPrimaryLightColor,
                                            fontSize: 16.0,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      children: <Widget>[
                                        Container(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.5,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey[100],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'आवश्यक कागजातहरू',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Html(
                                                      // defaultTextStyle:
                                                      //     TextStyle(
                                                      //         height: 1.5),
                                                      data: snapshot
                                                          .data[widget.data]
                                                          .wodapatradata[index]
                                                          .description,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                'समय',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data[widget
                                                                        .data]
                                                                    .wodapatradata[
                                                                        index]
                                                                    .time,
                                                                style:
                                                                    TextStyle(),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                'शुल्क',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data[widget
                                                                        .data]
                                                                    .wodapatradata[
                                                                        index]
                                                                    .cost,
                                                                style:
                                                                    TextStyle(),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                'सेवा दिने ब्यक्ति',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data[widget
                                                                        .data]
                                                                    .wodapatradata[
                                                                        index]
                                                                    .sewa_person,
                                                                style:
                                                                    TextStyle(),
                                                              ))
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

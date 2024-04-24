import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/eventsmodal.dart';
import 'package:kmc/modal/newsnoticemodal.dart';
import 'package:kmc/pages/bibhag/overview/fullnews.dart';
import 'package:kmc/pages/eventdetails.dart';

class OverView extends StatefulWidget {
  const OverView({Key? key, this.data}) : super(key: key);

  final data;

  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  Future<List<Eventsapi>> geteventsdataapi() async {
    List<Eventsapi>? event = await eventsAPis();
    return event!;
  }

  Future<List<NewsNoticeModal>> newsApi() async {
    List<NewsNoticeModal> news = await newsnoticeAPI();
    return news;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ScrollController? _scrollController;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            titleText('upcoming_events'.tr),
            eventsPart(),
            titleText('activities'.tr),
            newsPart()
          ],
        ),
      );
    });
  }

  eventsPart() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: widget.data['events'].length == 0
            ? Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 48,
                  ),
                  child: Center(
                    child: Text(
                      'हाललाई कुनै कार्यक्रम फेला परेन।',
                      style: TextStyle(
                        fontSize: 18,
                        color: text,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: widget.data['events'].length == 0
                    ? 0
                    : widget.data['events'].length == 1
                        ? Get.height * 0.22
                        : Get.height * 0.44,
                child: ListView.builder(
                  itemCount: widget.data['events'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () => {
                              Get.to(EventDetails(
                                  data: widget.data['events'][index]))
                            },
                        child: Card(
                            elevation: 0,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            borderOnForeground: true,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(widget.data['events'][index]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: text,
                                      )),
                                  // CachedNetworkImage(
                                  //   imageUrl:
                                  //       '$eventsimagewaling${ widget.data['notice'][index].image_url}',
                                  //   height: 180,
                                  //   fit: BoxFit.cover,
                                  //   placeholder: (context, url) =>
                                  //       CircularProgressIndicator(
                                  //     backgroundColor: text,
                                  //   ),
                                  // ),
                                  SizedBox(height: 10),
                                  Column(children: <Widget>[
                                    eventText(
                                        Icons.watch_later_outlined,
                                        'time'.tr,
                                        widget.data['events'][index]['time']),
                                    eventText(
                                        Icons.calendar_today_outlined,
                                        'date'.tr,
                                        widget.data['events'][index]['date']),
                                    eventText(
                                        Icons.location_on,
                                        'place'.tr,
                                        widget.data['events'][index]
                                            ['location']),
                                    // Row(children: [
                                    //   Text('organizer'.tr + ': ',
                                    //       textAlign: TextAlign.left,
                                    //       style: TextStyle(fontSize: 16)),
                                    //   Text( widget.data['notice'][index].organizer ?? '',
                                    //       textAlign: TextAlign.left,
                                    //       style: TextStyle(
                                    //           fontSize: 16, color: primary)),
                                    // ])
                                  ]),
                                ],
                              ),
                            )));
                  },
                ),
              ));
  }

  newsPart() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: widget.data['notice'].length == 0
            ? Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 48,
                  ),
                  child: Center(
                    child: Text(
                      'हाललाई कुनै गतिविधी फेला परेन।',
                      style: TextStyle(
                        fontSize: 18,
                        color: text,
                      ),
                    ),
                  ),
                ))
            : Container(
                height: widget.data['notice'].length == 0 ? 0 : Get.height,
                child: ListView.builder(
                    itemCount: widget.data['notice'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            var a = {
                              'name': 'NEWS'.tr,
                              'title': widget.data['notice'][index]['title'],
                              'news_date': widget.data['notice'][index]
                                  ['notice_date_nep'],
                              'feature_img': widget.data['notice'][index]
                                  ['feature_img'],
                              'link': widget.data['notice'][index]['link'],
                              'detail': widget.data['notice'][index]['detail'],
                            };
                            Get.to(BibaghNews(data: a));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 180.0,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${widget.data['notice'][index]['feature_img']}',
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: primary,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/Grey_Placeholder.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        backgroundImage: imageProvider,
                                      ),
                                    )

                                    //   NetworkImage(
                                    //       '$newsimage${snapshot.data[index].feature_img}'),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                                SizedBox(height: 16),
                                Text(widget.data['notice'][index]['title'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: primary,
                                    )),
                                SizedBox(height: 16),
                                Text(widget.data['notice'][index]['detail'],
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontSize: 16, color: text)),
                                Divider(height: 1.0),
                              ]),
                        ),
                      );
                    }),
              ));
  }

  eventText(icon, title, data) {
    return Row(children: [
      Icon(icon, color: text, size: 20),
      SizedBox(width: 10),
      Text(title + ': ',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, height: 1.5)),
      Text(data ?? '',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: primary)),
    ]);
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(title,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: primary, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

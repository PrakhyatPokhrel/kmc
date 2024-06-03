import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_spinner.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/newsnoticemodal.dart';
import 'package:kmc/modal/newsnoticemodalwordpress.dart';
import 'package:kmc/modal/noticeModel.dart';
import 'package:kmc/pages/news/fullnews.dart';
import 'package:kmc/pages/news/news_detail.dart';

class NewsList extends StatefulWidget {
  final bool isBackRequired;

  const NewsList({Key? key, this.isBackRequired = false}) : super(key: key);
  @override
  _NewsListState createState() => _NewsListState();
}

Future<List<NewsNoticeModal>> newsApi() async {
  List<NewsNoticeModal> news = await newsnoticeAPI();
  return news;
}

Future<List<NoticeModal>> noticeApis() async {
  List<NoticeModal> notice = await noticeAPI();
  return notice;
}

class _NewsListState extends State<NewsList> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    // newsApi().then((value) => print("news length: " + "${value[0].news_file}"));
    super.initState();
    // noticeApis().then((value) => print("notice length: " + "${value[0]}"));
    getNews();
  }

  List<NewsNoticeModelWordpress> newsList = [];

  getNews() {
    wordpressApi().then((value) {
      setState(() {
        newsList = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              actions: [
                widget.isBackRequired
                    ? IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: primary,
                        ),
                      )
                    : Container(),
              ],
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'newsnotice'.tr,
                      style: TextStyle(
                        color: primary,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: background,
            body: DoubleBack(
                background: background,
                textStyle: TextStyle(color: Colors.black),
                message: "Press back again to close",
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CustomSpinner()
                        : (newsList.isEmpty)
                            ? Container(
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
                              )
                            : ListView.separated(
                                addRepaintBoundaries: false,
                                addAutomaticKeepAlives: false,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: newsList.length > 100
                                    ? 100
                                    : newsList.length,
                                itemBuilder: (context, index) {
                                  var news = newsList[index];
                                  return ListTile(
                                    onTap: () {
                                      Get.to(NewsDetailScreen(
                                        news: news,
                                      ));
                                    },
                                    title: Text(
                                      news.title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: primary,
                                      ),
                                    ),
                                    subtitle: Text(news.tags),
                                    trailing: news.type == TypeEnum.image
                                        ? news.docs.isNotEmpty
                                            ? ClipRRect(
                                                // borderRadius:
                                                //     BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        news.docs.first.url,
                                                    height: 100,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        ClipRRect(
                                                            child: Image.asset(
                                                          'assets/images/Grey_Placeholder.png',
                                                          fit: BoxFit.fill,
                                                        )),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                              width: 19,
                                                              height: 19,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            )),
                                              )
                                            : null
                                        : Container(
                                            height: 100,
                                            width: 50,
                                            child: Icon(
                                              Icons.picture_as_pdf,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  );
                                },
                              )))));

    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       automaticallyImplyLeading: false,
    //       backgroundColor: Colors.transparent,
    //       title: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text('newsnotice'.tr,
    //                 style: TextStyle(color: primary, fontSize: 22)),
    //           ],
    //         ),
    //       ),
    //       bottom: TabBar(
    //           labelColor: primary,
    //           unselectedLabelColor: text,
    //           indicatorSize: TabBarIndicatorSize.label,
    //           indicator: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(30),
    //                   topRight: Radius.circular(30)),
    //               color: Colors.white),
    //           tabs: [
    //             Tab(
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text('NEWS'.tr,
    //                     style: TextStyle(fontSize: 18)),
    //               ),
    //             ),
    //             Tab(
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text('notices'.tr,
    //                     style: TextStyle(fontSize: 18)),
    //               ),
    //             ),
    //           ]),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         news(),
    //         // Container(
    //         //     height: Get.height * 0.7,
    //         //     color: textPrimaryLightColor,
    //         //     margin: const EdgeInsets.symmetric(
    //         //         horizontal: 5.0, vertical: 5.0),
    //         //     child: news()),
    //         Container(
    //             height: Get.height * 0.7,
    //             color: textPrimaryLightColor,
    //             margin: const EdgeInsets.symmetric(
    //                 horizontal: 5.0, vertical: 5.0),
    //             child: notice()),
    //       ],
    //     ),
    //   ),
    // ),
  }

  news() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: FutureBuilder(
            future: newsApi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomSpinner();
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
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            var a = {
                              'name': 'NEWS'.tr,
                              'title': snapshot.data[index].title,
                              'news_date': snapshot.data[index].news_date,
                              'feature_img': snapshot.data[index].feature_img,
                              'link': snapshot.data[index].link,
                              'detail': snapshot.data[index].detail,
                              'news_file': snapshot.data[index].news_file,
                            };

                            Get.to(FullNews(data: a));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                snapshot.data[index].feature_img.length != 0
                                    ? Container(
                                        width: 500.0,
                                        height: 180.0,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${snapshot.data[index].feature_img[0].value}',
                                          fit: BoxFit.cover,

                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: tertiary,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: Image.asset(
                                              'assets/images/Grey_Placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // imageBuilder:
                                          //     (context, imageProvider) =>
                                          //         CircleAvatar(
                                          //   backgroundImage: imageProvider,
                                          // ),
                                        )

                                        //   NetworkImage(
                                        //       '$newsimage${snapshot.data[index].feature_img}'),
                                        //   fit: BoxFit.fill,
                                        // ),
                                        )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/Grey_Placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                SizedBox(height: 16),
                                Text(snapshot.data[index].title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18, color: primary)),
                                SizedBox(height: 16),
                                Text(snapshot.data[index].detail,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontSize: 16, color: text)),
                                Divider(height: 1.0),
                              ]),
                        ),
                      );
                    });
              }
            }));
  }

  notice() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: FutureBuilder(
            future: noticeApis(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomSpinner();
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
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            var a = {
                              'name': 'notices'.tr,
                              'title': snapshot.data[index].title,
                              'news_date': snapshot.data[index].notice_date,
                              'feature_img': snapshot.data[index].feature_img,
                              'link': '',
                              'detail': snapshot.data[index].detail,
                              'news_file': snapshot.data[index].pdf_files,
                            };
                            Get.to(FullNews(data: a));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 500.0,
                                    height: 180.0,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data[index].feature_img
                                                  .length !=
                                              0
                                          ? '${snapshot.data[index].feature_img[0].value}'
                                          : "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: tertiary,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/Grey_Placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // imageBuilder:
                                      //     (context, imageProvider) =>
                                      //         CircleAvatar(
                                      //   backgroundImage: imageProvider,
                                      // ),
                                    )

                                    //   NetworkImage(
                                    //       '$newsimage${snapshot.data[index].feature_img}'),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                                SizedBox(height: 16),
                                Text(snapshot.data[index].title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18, color: primary)),
                                SizedBox(height: 16),
                                Text(snapshot.data[index].detail,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontSize: 16, color: text)),
                                Divider(height: 1.0),
                              ]),
                        ),
                      );
                    });
              }
            }));
  }

  // Widget _buildReadMoreModelList(items, int index) {
  //   return Container(
  //     // height:DeviceSize.height(context),
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: ReadMoreText(
  //           items.title,
  //           trimLines: 2,
  //           colorClickableText: Colors.pink,
  //           trimMode: TrimMode.Line,
  //           trimCollapsedText: '..Read More',
  //           style: TextStyle(fontSize: 13),
  //           trimExpandedText: ' Less',
  //         ),
  //       ),
  //       /* Divider(
  //         color: const Color(0xFF167F67),
  //       ),,*/
  //     ),
  //   );
  // }
}

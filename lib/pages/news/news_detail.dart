import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/newsnoticemodalwordpress.dart';
import 'package:kmc/pages/profile/pdfview.dart';
import 'package:photo_view/photo_view.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  final NewsNoticeModelWordpress news;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var news = widget.news;
    return Scaffold(
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
              Text(
                "कागजात",
                style: TextStyle(
                  color: primary,
                  fontSize: 22,
                ),
              ),
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
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                // SizedBox(height: 2),
                // Text(data['detail'],
                //     style: TextStyle(fontSize: 16, color: text)),
                // Text("NEWS DETAILS"),
                //!PDF List
                if (news.type == TypeEnum.pdf)
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: news.docs.length,
                        itemBuilder: (context, index) {
                          var item = news.docs[index];

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // margin: EdgeInsets.symmetric(
                            //   horizontal: 12,
                            //   vertical: 3,
                            // ),
                            child: ListTile(
                              onTap: () {
                                Get.to(Pdfviewer(data: item.url));
                              },
                              leading: Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              title: Text(
                                item.title ?? "",
                                style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                //!Image List
                if (news.type == TypeEnum.image)
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 12,
                          );
                        },
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: news.docs.length,
                        itemBuilder: (context, index) {
                          var item = news.docs[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // margin: EdgeInsets.symmetric(
                            //   horizontal: 16,
                            //   vertical: 6,
                            // ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                color: Colors.white,
                                child: PhotoView(
                                  backgroundDecoration: BoxDecoration(color: Colors.transparent),
                                  imageProvider: CachedNetworkImageProvider(
                                    item.url,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          )),
    );
  }
}

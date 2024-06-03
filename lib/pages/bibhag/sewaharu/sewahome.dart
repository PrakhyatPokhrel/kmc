import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class SewaHome extends StatefulWidget {
  @override
  final data;
  SewaHome({this.data});
  _SewaHomeState createState() => _SewaHomeState(data: this.data);
}

class _SewaHomeState extends State<SewaHome> {
  var data;
  final ScrollController _scrollController = ScrollController();
  _SewaHomeState({this.data});
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
                Text(data['name'],
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
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(width: 0.5, color: text)),
                              height: 180.0,
                              child: CachedNetworkImage(
                                imageUrl: '${data['icon']}',
                                fit: BoxFit.contain,
                                // height: 180,
                                width: Get.width,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: primary,
                                  ),
                                ),
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/Grey_Placeholder.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                // placeholder: (context, url) =>
                                //     CircularProgressIndicator(
                                //   backgroundColor: primary,
                                // ),
                              )),
                          SizedBox(height: 16),
                          Text(data['name'],
                              style: TextStyle(fontSize: 18, color: primary)),
                          SizedBox(height: 16),
                          // Text(
                          //     data['description'] != null
                          //         ? data['description']
                          //         : '',
                          //     style: TextStyle(fontSize: 16, color: text)),
                          // Html(
                          //     data: data['description'],
                          //     defaultTextStyle:
                          //         TextStyle(fontSize: 16, color: text)),
                          // Divider(height: 1.0),
                        ]),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

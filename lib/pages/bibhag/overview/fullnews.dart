import 'package:kmc/config/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BibaghNews extends StatefulWidget {
  @override
  final data;
  BibaghNews({this.data});
  _BibaghNewsState createState() => _BibaghNewsState(data: this.data);
}

class _BibaghNewsState extends State<BibaghNews> {
  var data;
  _BibaghNewsState({this.data});
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
                              height: 180.0,
                              child: CachedNetworkImage(
                                imageUrl: '${data['feature_img']}',
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
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                ),
                                // placeholder: (context, url) =>
                                //     CircularProgressIndicator(
                                //   backgroundColor: primary,
                                // ),
                              )),
                          SizedBox(height: 16),
                          Text(data['title'],
                              style: TextStyle(fontSize: 18, color: primary)),
                          SizedBox(height: 16),
                          // Text(data['detail'],
                          //     style: TextStyle(fontSize: 16, color: text)),
                          Html(
                            data: data['detail'],
                            // defaultTextStyle:
                            //     TextStyle(fontSize: 16, color: text)
                          ),
                          Divider(height: 1.0),
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

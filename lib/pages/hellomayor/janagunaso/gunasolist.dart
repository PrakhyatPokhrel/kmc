import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/modal/chatlistmodal.dart';
import 'package:kmc/pages/hellomayor/chatData.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasoJGchat.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pusher_client/pusher_client.dart';

class GunasoList extends StatefulWidget {
  @override
  // final data;
  // HelloGunasoEntry({this.data});
  _GunasoList createState() => _GunasoList();
}

class _GunasoList extends State<GunasoList> {
  final LocalStorage storage = new LocalStorage('changu');

  Channel? channel;
  dynamic userdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamic s = storage.getItem('user');
    if (s != null) {
      userdata = jsonDecode(s);
    }
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  Future<Chatlist>? messageApi() async {
    Chatlist? chatlist = await gunasochatlistAPI();

    return chatlist!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black45),
          title: Text('Judicial_committee'.tr),
          toolbarTextStyle: Theme.of(context).textTheme.apply(bodyColor: Colors.black45).bodyMedium,
          titleTextStyle: Theme.of(context).textTheme.apply(bodyColor: Colors.black45).titleLarge,
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {},
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.add_box),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: FutureBuilder(
            future: messageApi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                return Container();
              } else if (snapshot.hasError) {
                return Container(
                  child: dismiss(),
                );
              } else {
                EasyLoading.dismiss();
                return ListView.builder(
                  itemCount: snapshot.data.conversationlist.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          isThreeLine: true,
                          onLongPress: () {},
                          onTap: () => {gunasoJGchatpage(snapshot.data.conversationlist[i])},
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.3), offset: Offset(0, 5), blurRadius: 25)
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage("$user_image${snapshot.data.conversationlist[i].icon}"),
                                  ),
                                ),
                                friendsList[i]['isOnline']
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          title: Text(
                            "${snapshot.data.conversationlist[i].name}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            "${snapshot.data.conversationlist[i].last_message}",
                            style: snapshot.data.conversationlist[i].seen_at != null
                                ? Theme.of(context).textTheme.titleMedium!.apply(color: Colors.black87)
                                : Theme.of(context).textTheme.titleMedium!.apply(color: Colors.black54),
                          ),
                          trailing: Container(
                            width: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    snapshot.data.conversationlist[i].seen_at != null
                                        ? Icon(
                                            Icons.check,
                                            size: 15,
                                          )
                                        : Container(height: 15, width: 15),
                                    Text(snapshot.data.conversationlist[i].updated_at != ''
                                        ? "${snapshot.data.conversationlist[i].updated_at.substring(0, 7)}"
                                        : '')
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  },
                );
              }
            }),
      ),
    );
  }

  gunasoJGchatpage(userdatafromapi) {
    var alldata;
    getchathistoryApifromGunaso('${userdatafromapi.conv_id}').then((value) => {
          alldata = {
            'name': userdatafromapi.name,
            'mobile': userdatafromapi.mobile,
            'conv_id': userdatafromapi.conv_id,
            'user_img': userdatafromapi.user_img,
            'chat': value,
            'id': userdata['id'],
          },
          Get.to(GunasoJGchat({'data': alldata}))
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => GunasoJGchat({'data': alldata})),
        });
  }

  dismiss() {
    EasyLoading.dismiss();
  }
}

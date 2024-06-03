import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:kmc/components/chat_widgets/chatwidgets.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/modal/getmessage.dart';
import 'package:kmc/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/replaceable.dart';

class UserJGChat extends StatefulWidget {
  final data;
  UserJGChat(this.data);
  @override
  _UserJGChatState createState() => _UserJGChatState();
}

class _UserJGChatState extends State<UserJGChat> {
  dynamic datalist;
  final LocalStorage storage = new LocalStorage('changu');
  List<Conversationlistmessage> data1 = [];
  PusherClient? pusher;
final chatkey = GlobalKey<FormState>();
  Channel? channel;
  bool _showBottom = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var message = TextEditingController();
  dynamic userdata;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startingmessage();
    setState(() {
      userdata = widget.data;
      data1.addAll(widget.data['data']['chat']);
    });
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      // if (mounted) {
      Timer(Duration(milliseconds: 500), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      // } else {
      timer.cancel();
      // }
    });
    getsoredata();
  }

  dynamic loginuserdata;
  getsoredata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic s = jsonDecode(pref.getString('user')!);
    setState(() {
      loginuserdata = s;
      chatmessage();
    });
  }

  Future<Getmessage> messageApi() async {
    Getmessage? message = await getMsgFromUserJGApi();

    return message!;
  }

  startingmessage() async {}

  chatmessage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var token = localStorage.getString('token');

    PusherClient pusher = PusherClient(
        "${Config.pusher_key}",
        PusherOptions(
          auth: PusherAuth(pusher_authorize, headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + token!
          }),
          cluster: "ap2",
          encrypted: true,
        ),
        enableLogging: true);

    // Pusher.connect(onConnectionStateChange: (x) async {
    //   print(x.currentState);
    // }, onError: (x) {
    //   debugPrint("Error: ${x.exception}");
    // });
    pusher.onConnectionStateChange((state) {});

    channel = pusher
        .subscribe('private-message-' + '${widget.data['data']['conv_id']}');

    channel?.bind('newmessage', (onEvent) {
      dynamic ab = onEvent?.data;
      dynamic a = json.decode(ab);

      setState(() {
        data1.add(Conversationlistmessage(
          conv_id: a['conv_id'],
          created_at: a['created_at'],
          file: a['file'],
          image: a['image'],
          message: a['message'],
          message_id: a['message_id'],
          nepali_timestamp: a['nepali_timestamp'],
          parent_message: a['parent_message'],
          seen_at: a['seen_at'],
          seen_by: a['seen_by'],
          sender_id: a['sender_id'],
          sender_name: a['sender_name'],
          updated_at: a['updated_at'],
        ));
      });

      // data1.add(json.decode(a));
    });
  }

  storemessage(a) {
    var data = {'message': a};
    message.clear();
    storechatJGApi(data).then((value) => {});
  }

  imagestore(a) {
    var data = {'image': a};

    storechatJGApi(data).then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    startingmessage();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyCircleAvatar(
                imgUrl: suchanaAdhikari['user_img'],
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    suchanaAdhikari['name'],
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.clip,
                  ),
                  // Text(
                  //   "Online",
                  //   style: Theme.of(context).textTheme.subtitle.apply(
                  //         color: primary,
                  //       ),
                  // )
                ],
              )
            ],
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.camera),
          //     onPressed: () {},
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.file_copy),
          //     onPressed: () {},
          //   ),
          // IconButton(
          //   icon: Icon(Icons.more_vert),
          //   onPressed: () {},
          // ),
          // ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  Expanded(
                      // child: FutureBuilder(
                      //     future: messageApi(),
                      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //       if (snapshot.connectionState ==
                      //               ConnectionState.waiting ||
                      //           snapshot.hasData == null) {
                      //         return Container(
                      //           child: Text('Please Wait....'),
                      //         );
                      //       } else if (snapshot.hasError) {
                      //         return Container(
                      //           child: Text('Please Wait....'),
                      //         );
                      //       } else {
                      child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(15),
                    itemCount: data1.length,
                    itemBuilder: (ctx, i) {
                      if ('${data1[i].sender_id} ' !=
                          '${loginuserdata['id']}') {
                        var v = {
                          'sender_name': data1[i].sender_name,
                          'message': data1[i].message,
                          'file': data1[i].file,
                          'image': data1[i].image,
                          'nepali_timestamp': data1[i].nepali_timestamp,
                          'userimage': suchanaAdhikari['user_img']
                        };
                        return SentMessageWidget(data: v);
                      } else {
                        var v = {
                          'sender_name': data1[i].sender_name,
                          'message': data1[i].message,
                          'file': data1[i].file,
                          'image': data1[i].image,
                          'nepali_timestamp': data1[i].nepali_timestamp,
                          //'userimage': suchanaAdhikari[0]['user_img']
                        };
                        return ReceivedMessagesWidget(data: v);
                      }
                    },
                  )
                      // }
                      // }),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      height: 61,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.grey)
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.photo_camera),
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                  ),
                                  Expanded(
                                    child: Form(
                                      key: chatkey,
                                      child: TextFormField(
                                        controller: message,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Type ...",
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.attach_file),
                                  //   onPressed: () {
                                  //     print('file');
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () => {},
                            child: InkWell(
                              onTap: () => {
                                setState(
                                  () {
                                
                                    if (chatkey.currentState!.validate()) {
                                      storemessage(message.text);
                                    }

                                    _showBottom = false;
                                  },
                                )
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: white, shape: BoxShape.circle),
                                child: Icon(
                                  Icons.send,
                                  color: primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // _showBottom
            //     ?
            //      Positioned(
            //         bottom: 90,
            //         left: 25,
            //         right: 25,
            //         child: Container(
            //           padding: EdgeInsets.all(25.0),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                   offset: Offset(0, 5),
            //                   blurRadius: 15.0,
            //                   color: Colors.grey)
            //             ],
            //           ),
            //           child: GridView.count(
            //             mainAxisSpacing: 21.0,
            //             crossAxisSpacing: 21.0,
            //             shrinkWrap: true,
            //             crossAxisCount: 3,
            //             children: List.generate(
            //               icons.length,
            //               (i) {
            //                 return Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(15.0),
            //                     color: Colors.grey[200],
            //                     border: Border.all(color: primary, width: 2),
            //                   ),
            //                   child: IconButton(
            //                     icon: Icon(
            //                       icons[i],
            //                       color: primary,
            //                     ),
            //                     onPressed: () {
            //
            //                     },
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = Io.File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);

      setState(() {
        var fulldata = 'data:image/png;base64,' + img64;
        imagestore(fulldata);
      });
    }
  }

  Future getImageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {}
    });
  }
}

List<IconData> icons = [
  Icons.image,
  Icons.camera,
  Icons.file_upload,
  Icons.folder,
  Icons.gif
];

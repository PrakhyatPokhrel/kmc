import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/chat_widgets/chatwidgets.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/modal/getmessage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/replaceable.dart';

class UserHMChat extends StatefulWidget {
  final data;
  UserHMChat(this.data);
  @override
  _UserHMChatState createState() => _UserHMChatState();
}

class _UserHMChatState extends State<UserHMChat> {
  dynamic datalist;
  final LocalStorage storage = new LocalStorage('changu');
  List<Conversationlistmessage> data1 = [];
  PusherClient? pusher;

  Channel? channel;
  bool? _showBottom = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var message = TextEditingController();
  dynamic userdata;
  ScrollController _scrollController = new ScrollController();
  final chatkey = GlobalKey<FormState>();
  @override
  void initState() {
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
    Getmessage? message = await getMsgFromUserHMApi();

    return message!;
  }

  startingmessage() async {}

  chatmessage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var token = localStorage.getString('token');
    PusherClient pusher = PusherClient(
        "${Config.pusher_key}",
        PusherOptions(
          auth: PusherAuth(pusher_authorize,
              headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ' + token!}),
          cluster: "ap2",
          encrypted: true,
        ),
        enableLogging: true);
    pusher.connect();

    pusher.onConnectionStateChange((state) {});
    channel = pusher.subscribe('private-message-' + '${widget.data['data']['conv_id']}');

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
    var data = {
      'message': a,
    };
    message.clear();
    storechatHMApi(data).then((value) => {print(value)});
  }

  imagestore(a) {
    var data = {'image': a};

    storechatHMApi(data).then((value) => {print(value)});
  }

  @override
  Widget build(BuildContext context) {
    startingmessage();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: primary),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyCircleAvatar(
                imgUrl: mayordata['image_url'],
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mayordata['name'],
                    style:
                        Theme.of(context).textTheme.titleMedium!.apply(color: primary, fontSizeFactor: 1.1),
                    overflow: TextOverflow.clip,
                  ),
                ],
              )
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(15),
                    itemCount: data1.length,
                    itemBuilder: (ctx, i) {
                      if ('${data1[i].sender_id}' != '${loginuserdata?['id']}') {
                        var v = {
                          'sender_name': data1[i].sender_name,
                          'message': data1[i].message,
                          'file': data1[i].file,
                          'image': data1[i].image,
                          'nepali_timestamp': data1[i].nepali_timestamp,
                          'userimage': mayordata['image_url'],
                        };
                        return ReceivedMessagesWidget(data: v);
                      } else {
                        var v = {
                          'sender_name': data1[i].sender_name,
                          'message': data1[i].message,
                          'file': data1[i].file,
                          'image': data1[i].image,
                          'nepali_timestamp': data1[i].nepali_timestamp,
                          'userimage': loginuserdata['user_img']
                        };
                        return SentMessageWidget(data: v);
                      }
                    },
                  )
                      // }
                      // }),
                      ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 14.0,
                      right: 10.0,
                      bottom: 8.0,
                      top: 4.0,
                    ),
                    color: Colors.transparent,
                    //height: 61,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)],
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: primary,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: FormBuilder(
                                    key: _fbKey,
                                    child: TextField(
                                      controller: message,
                                      decoration:
                                          InputDecoration(hintText: "Type ...", border: InputBorder.none),
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
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () => {
                            setState(
                              () {
                                this._fbKey.currentState!.save();
                                if (message.text.isNotEmpty) {
                                  storemessage(message.text);
                                }

                                _showBottom = false;
                              },
                            )
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(color: white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.send,
                              color: primary,
                              size: 30.0,
                            ),
                          ),
                        )
                      ],
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

List<IconData> icons = [Icons.image, Icons.camera, Icons.file_upload, Icons.folder, Icons.gif];

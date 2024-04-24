import 'dart:convert';

class Chatlist {
  List<Conversationlist>? conversationlist;
  User? user;
  Chatlist({
    this.conversationlist,
    this.user,
  });

  factory Chatlist.fromJson(Map<String, dynamic> map) {
    List<dynamic> conversation = map['conversation'];

    var conversationlists =
        conversation.map((e) => Conversationlist.fromJson(e)).toList();

    User userdetail = User.fromJson(map['user']);
    return Chatlist(
      conversationlist: conversationlists,
      user: userdetail,
    );
  }
}

class Conversationlist {
  dynamic conv_id;
  dynamic created_at;
  dynamic email;
  dynamic gender;
  dynamic id;
  dynamic initiate_user;
  dynamic last_message;
  dynamic last_message_id;
  dynamic mobile;
  dynamic name;
  dynamic seen_at;
  dynamic updated_at;
  dynamic user_img;
  dynamic woda_id;
  Conversationlist({
    this.conv_id,
    this.created_at,
    this.email,
    this.gender,
    this.id,
    this.initiate_user,
    this.last_message,
    this.last_message_id,
    this.mobile,
    this.name,
    this.seen_at,
    this.updated_at,
    this.user_img,
    this.woda_id,
  });

  factory Conversationlist.fromJson(Map<String, dynamic> map) {
    return Conversationlist(
      conv_id: map['conv_id'],
      created_at: map['created_at'],
      email: map['email'],
      gender: map['gender'],
      id: map['id'],
      initiate_user: map['initiate_user'],
      last_message: map['last_message'],
      last_message_id: map['last_message_id'],
      mobile: map['mobile'],
      name: map['name'],
      seen_at: map['seen_at'],
      updated_at: map['updated_at'],
      user_img: map['user_img'],
      woda_id: map['woda_id'],
    );
  }
}

class User {
  dynamic address;
  dynamic designation;
  dynamic education;
  dynamic email;
  dynamic emergency;
  dynamic gender;
  dynamic id;
  dynamic mobile;
  dynamic name;
  dynamic user_img;
  User({
    this.address,
    this.designation,
    this.education,
    this.email,
    this.emergency,
    this.gender,
    this.id,
    this.mobile,
    this.name,
    this.user_img,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      address: map['address'],
      designation: map['designation'],
      education: map['education'],
      email: map['email'],
      emergency: map['emergency'],
      gender: map['gender'],
      id: map['id'],
      mobile: map['mobile'],
      name: map['name'],
      user_img: map['user_img'],
    );
  }
}

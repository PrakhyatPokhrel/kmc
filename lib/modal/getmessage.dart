
class Getmessage {
  List<Conversationlistmessage>? conversationlist;
  Getmessage({
    this.conversationlist,
  });

  factory Getmessage.fromJson(Map<String, dynamic> map) {
    List<dynamic> conversation = map['messages'];

    var conversationlists =
        conversation.map((e) => Conversationlistmessage.fromJson(e)).toList();

    return Getmessage(
      conversationlist: conversationlists,
    );
  }
}

class Conversationlistmessage {
  dynamic conv_id;
  dynamic created_at;
  dynamic file;
  dynamic image;
  dynamic message;
  dynamic message_id;
  dynamic nepali_timestamp;
  dynamic parent_message;
  dynamic seen_at;
  dynamic seen_by;
  dynamic sender_id;
  dynamic sender_name;
  dynamic updated_at;
  Conversationlistmessage({
    this.conv_id,
    this.created_at,
    this.file,
    this.image,
    this.message,
    this.message_id,
    this.nepali_timestamp,
    this.parent_message,
    this.seen_at,
    this.seen_by,
    this.sender_id,
    this.sender_name,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'conv_id': conv_id,
      'created_at': created_at,
      'file': file,
      'image': image,
      'message': message,
      'message_id': message_id,
      'nepali_timestamp': nepali_timestamp,
      'parent_message': parent_message,
      'seen_at': seen_at,
      'seen_by': seen_by,
      'sender_id': sender_id,
      'sender_name': sender_name,
      'updated_at': updated_at,
    };
  }

  factory Conversationlistmessage.fromJson(Map<String, dynamic> map) {
    return Conversationlistmessage(
      conv_id: map['conv_id'],
      created_at: map['created_at'],
      file: map['file'],
      image: map['image'],
      message: map['message'],
      message_id: map['message_id'],
      nepali_timestamp: map['nepali_timestamp'],
      parent_message: map['parent_message'],
      seen_at: map['seen_at'],
      seen_by: map['seen_by'],
      sender_id: map['sender_id'],
      sender_name: map['sender_name'],
      updated_at: map['updated_at'],
    );
  }
}

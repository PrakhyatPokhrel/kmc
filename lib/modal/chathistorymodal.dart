import 'dart:convert';

class ChathistoryfromMayorside {
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
  ChathistoryfromMayorside({
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

  factory ChathistoryfromMayorside.fromJson(Map<String, dynamic> map) {
    return ChathistoryfromMayorside(
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

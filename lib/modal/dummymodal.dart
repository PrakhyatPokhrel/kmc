import 'dart:convert';

class ToiletModal {
  dynamic key;
  dynamic value;

  ToiletModal({
    this.key,
    this.value,
  });

  factory ToiletModal.fromJson(Map<String, dynamic> map) {
    return ToiletModal(
      key: map['key'],
      value: map['value'],
    );
  }
}

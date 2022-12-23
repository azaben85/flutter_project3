import 'dart:convert';

class MyList {
  String? id;
  String userId;
  String type;
  String reference_id;
  MyList({
    this.id,
    required this.userId,
    required this.type,
    required this.reference_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'reference_id': reference_id,
    };
  }

  factory MyList.fromMap(Map<String, dynamic> map) {
    return MyList(
      id: map['id'],
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      reference_id: map['reference_id'] ?? '',
    );
  }
}

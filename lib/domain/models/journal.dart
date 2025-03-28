// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:uuid/uuid.dart';

class Journal {
  String id;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Journal({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  static Journal empty() {
    return Journal(
      id: Uuid().v1(),
      content: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // ignore: non_constant_identifier_names
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'Journal(id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'] as String,
      content: map['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }
}

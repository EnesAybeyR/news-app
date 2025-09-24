import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsContent {
  final String id;
  final String content;
  final int order;
  final String contentType;
  final String newId;
  NewsContent({
    required this.id,
    required this.content,
    required this.order,
    required this.contentType,
    required this.newId,
  });

  factory NewsContent.fromMap(Map<String, dynamic> map) {
    return NewsContent(
      id: map['id'] as String,
      content: map['content'] as String,
      order: map['order'] as int,
      contentType: map['contentType'] as String,
      newId: map['newId'] as String,
    );
  }
  factory NewsContent.fromJson(String source) =>
      NewsContent.fromMap(json.decode(source) as Map<String, dynamic>);
}

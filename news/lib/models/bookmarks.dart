// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:news/models/news.dart';

class Bookmarks {
  final String id;
  final News news;
  Bookmarks({required this.id, required this.news});

  factory Bookmarks.fromMap(Map<String, dynamic> map) {
    return Bookmarks(
      id: map['id'] as String,
      news: News.fromMap(map['new'] as Map<String, dynamic>),
    );
  }

  factory Bookmarks.fromJson(String source) =>
      Bookmarks.fromMap(json.decode(source) as Map<String, dynamic>);
}

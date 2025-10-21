// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:news/models/images.dart';
import 'package:news/models/newsContent.dart';

class News {
  final String id;
  final String headline;
  final DateTime createDate;
  final String countryName;
  final int entryCount;
  final String editorId;
  final int categoryId;
  final List<Images> images;
  final List<NewsContent> newContents;

  News({
    required this.id,
    required this.headline,
    required this.createDate,
    required this.countryName,
    required this.entryCount,
    required this.editorId,
    required this.categoryId,
    required this.images,
    required this.newContents,
  });

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] as String,
      headline: map['headline'] as String,
      createDate: DateTime.parse(map['createDate'] as String),
      countryName: map['countryName'] as String,
      entryCount: map['entryCount'] as int,
      editorId: map['editorId'] as String,
      categoryId: map['categoryId'] as int,
      newContents:
          (map['newsContents'] as List<dynamic>?)
              ?.map<NewsContent>(
                (x) => NewsContent.fromMap(x as Map<String, dynamic>),
              )
              .toList() ??
          [],
      images:
          (map['images'] as List<dynamic>?)
              ?.map<Images>((x) => Images.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);
}

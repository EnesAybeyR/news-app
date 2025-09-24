import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final int id;
  final String categoryName;
  Category({required this.id, required this.categoryName});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      categoryName: map['categoryName'] as String,
    );
  }

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

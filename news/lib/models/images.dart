import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Images {
  final String id;
  final String imageName;
  final String imagePath;
  final String alt;
  final int order;
  final String newId;
  Images({
    required this.id,
    required this.imageName,
    required this.imagePath,
    required this.alt,
    required this.order,
    required this.newId,
  });

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      id: map['id'] as String,
      imageName: map['imageName'] as String,
      imagePath: map['imagePath'] as String,
      alt: map['alt'] as String,
      order: map['order'] as int,
      newId: map['newId'] as String,
    );
  }
  factory Images.fromJson(String source) =>
      Images.fromMap(json.decode(source) as Map<String, dynamic>);
}

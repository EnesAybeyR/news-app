// ignore_for_file: public_member_api_docs, sort_constructors_first
class News {
  final int id;
  final String headline;
  final DateTime createDate;
  final int editorId;
  final String countryName;
  final int topicId;
  final int entryCount;
  News({
    required this.id,
    required this.headline,
    required this.createDate,
    required this.editorId,
    required this.countryName,
    required this.topicId,
    required this.entryCount,
  });
}

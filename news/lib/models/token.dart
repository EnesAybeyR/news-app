import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Token {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  Token({this.accessToken, this.refreshToken, this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userId': userId,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);
}

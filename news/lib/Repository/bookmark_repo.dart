import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/bookmark_adapter.dart';

import 'package:http/http.dart' as http;
import 'package:news/models/bookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkRepo extends BookmarkAdapter {
  final WidgetRef ref;
  BookmarkRepo(this.ref);
  final String baseUrl = "http://10.0.2.2:5287";
  final dio = Dio();
  @override
  Future<bool> addBookmarks(ref, String newId) async {
    final String url = '$baseUrl/api/News/bookmarks/add/$newId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    final response = await dio.post(
      url,
      options: Options(
        contentType: "application/json",
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteBookmarks(ref, String bookmarkId) async {
    final String url = '$baseUrl/api/News/bookmarks/delete/$bookmarkId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    final response = await dio.delete(
      url,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<Bookmarks>> fetchBookmarks(ref) async {
    final String url = '$baseUrl/api/News/bookmarks';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        if (jsonData == [] || jsonData == null || jsonData is! List) {
          return [];
        }

        return jsonData.map((item) => Bookmarks.fromMap(item)).toList();
      } else {
        throw Exception(
          'Failed to load bookmarks. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network or processing error: $e');
    }
  }
}

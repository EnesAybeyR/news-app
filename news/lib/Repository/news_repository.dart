import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:news/Repository/adapter.dart';
import 'package:news/models/category.dart';
import 'package:news/models/news.dart';

class NewsRepository extends Adapter {
  final WidgetRef ref;
  NewsRepository(this.ref);
  final String baseUrl = "http://10.0.2.2:5287";
  final dio = Dio();

  @override
  Future<List<News>> fetchNews(
    BuildContext context,
    int page,
    int pageSize,
  ) async {
    final String url = "$baseUrl/api/News/getallnews";
    final response = await dio.get(
      url,
      queryParameters: {"page": page, "pageSize": pageSize},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((item) => News.fromMap(item)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  Future<List<Category>> fetchCategories(BuildContext context) async {
    final String url = "$baseUrl/api/Category";

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((item) => Category.fromMap(item)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  @override
  Future<List<News>> fetchNewsByCategory(
    BuildContext context,
    int categoryId,
  ) async {
    final String url = "$baseUrl/api/News/getNewsByCategory/$categoryId";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((item) => News.fromMap(item)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  Future<List<News>> fetchByName(BuildContext context, String newName) async {
    final String url = "$baseUrl/api/News/search/$newName";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((item) => News.fromMap(item)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  Future<String> fetchEditorName(BuildContext context, String editorId) async {
    final String url = "$baseUrl/api/News/getName/$editorId";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      String jsonData = response.data;

      return jsonData;
    } else {
      throw Exception("Failed to get editor name");
    }
  }
}

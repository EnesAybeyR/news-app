// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:news/Repository/auth_adapter.dart';
import 'package:news/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends AuthAdapter {
  WidgetRef ref;
  AuthRepository(this.ref);
  final String baseUrl = "http://10.0.2.2:5287";
  final dio = Dio();

  @override
  // Future<Token> login(ref, String username, String password) async {
  //   final String url = "$baseUrl/api/auth/user/login";
  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: {"userName": username, "password": password},
  //       options: Options(contentType: "application/json"),
  //     );
  //     if (response.statusCode == 200) {
  //       Token token = Token.fromJson(response.data);
  //       return token;
  //     } else if (response.statusCode == 400) {
  //       throw Exception("bad req");
  //     }
  //     throw Exception();
  //   } catch (e) {
  //     throw Exception("aaaaaaa");
  //   }
  // }
  @override
  Future<Token> login(ref, String username, String password) async {
    final String url = "$baseUrl/api/auth/user/login";
    try {
      final response = await dio.post(
        url,
        data: {"userName": username, "password": password},
        options: Options(contentType: "application/json"),
      );

      if (response.statusCode == 200) {
        Token token = Token.fromMap(response.data);
        return token;
      } else {
        throw Exception("Beklenmeyen Durum: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // --- HATAYI GÖRMEK İÇİN BURASI ÖNEMLİ ---
      if (e.response != null) {
        throw Exception(
          "Sunucu Hatası (${e.response?.statusCode}): ${e.response?.data}",
        );
      } else {
        throw Exception("Sunucuya ulaşılamadı");
      }
    } catch (e) {
      throw Exception("Bilinmeyen Hata: $e");
    }
  }

  @override
  Future<Token> nfaLogin(
    ref,
    String username,
    String password,
    String code,
  ) async {
    final String url = "$baseUrl/api/auth/user/login/nfa";
    try {
      final response = await dio.post(
        url,
        options: Options(contentType: "application/json"),
        data: {"username": username, "password": password, "code": code},
      );
      if (response.statusCode == 200) {
        Token token = Token.fromMap(response.data);
        return token;
      }
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Token> register(ref, String username, String password) async {
    final String url = "$baseUrl/api/auth/user/register";
    try {
      final response = await dio.post(
        url,
        data: {"userName": username, "password": password},
        options: Options(contentType: "application/json"),
      );

      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.data);

        return token;
      } else if (response.statusCode == 400) {
        throw Exception();
      }
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> nfa(ref, String username) async {
    final String url = "$baseUrl/api/auth/user/nfa";
    try {
      final response = await dio.post(
        url,
        data: {"username": username},
        options: Options(contentType: "application/json"),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> nfaWithId(ref) async {
    final String url = "$baseUrl/api/auth/user/mail";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    try {
      final response = await dio.get(
        url,
        options: Options(
          contentType: "application/json",
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Token?> refreshToken(ref, String userId, String refreshToken) async {
    final String url = "$baseUrl/api/auth/user/refresh-token";
    try {
      final response = await dio.post(
        url,
        options: Options(contentType: "application/json"),
        data: {"id": userId, "refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.data);
        return token;
      } else if (response.statusCode == 401) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> changeEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    final String url = "$baseUrl/api/auth/user/mail/update";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    try {
      final response = await dio.put(
        url,
        options: Options(
          contentType: "application/json",
          headers: {"Authorization": "Bearer $token"},
        ),
        data: {"mail": email, "password": password},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception();
    }
  }
}

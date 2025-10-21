// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:news/Repository/auth_adapter.dart';
import 'package:news/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends AuthAdapter {
  WidgetRef ref;
  AuthRepository(this.ref);
  final String baseUrl = "http://localhost:5287";

  @override
  Future<Token> login(ref, String username, String password) async {
    final String url = "$baseUrl/api/auth/user/login";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userName": username, "password": password}),
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.body);

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
  Future<Token> nfaLogin(
    ref,
    String username,
    String password,
    String code,
  ) async {
    final String url = "$baseUrl/api/auth/user/login/nfa";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userName": username,
          "password": password,
          "code": code,
        }),
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.body);
        return token;
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(ref).showSnackBar(
          SnackBar(
            content: Text("Code expired or wrong"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
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
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userName": username, "password": password}),
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.body);

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
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username}),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
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
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  Future<Token?> refreshToken(ref, String userId, String refreshToken) async {
    final String url = "$baseUrl/api/auth/user/refresh-token";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": userId, "refreshToken": refreshToken}),
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.body);
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
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"mail": email, "password": password}),
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/auth_repository.dart';
import 'package:news/models/authState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authprovider extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool("isLogged") ?? false;
    if (isLogged) {
      //final accessToken = prefs.getString("accessToken");
      final refreshToken = prefs.getString("refreshToken");
      final userId = prefs.getString("userId");

      if (refreshToken != null && userId != null) {
        try {
          await RefreshToken(ref);
          return state.value as AuthState;
        } catch (e) {
          await logout();
          return const AuthState(isLogged: false);
        }
      }
    }
    return AuthState(
      accessToken: prefs.getString("accessToken"),
      refreshToken: prefs.getString("refreshToken"),
      userId: prefs.getString("userId"),
      isLogged: isLogged,
    );
  }

  Future<void> login(ref, String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final token = await AuthRepository(ref).login(ref, username, password);
      final newState = AuthState(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        userId: token.userId,
        isLogged: true,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", token.accessToken.toString());
      await prefs.setString("refreshToken", token.refreshToken.toString());
      await prefs.setString("userId", token.userId.toString());
      await prefs.setBool("isLogged", true);
      state = AsyncData(newState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<bool> nfaLogin(
    ref,
    String username,
    String password,
    String code,
  ) async {
    state = const AsyncValue.loading();
    try {
      final token = await AuthRepository(
        ref,
      ).nfaLogin(ref, username, password, code);
      final newState = AuthState(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        userId: token.userId,
        isLogged: true,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", token.accessToken.toString());
      await prefs.setString("refreshToken", token.refreshToken.toString());
      await prefs.setString("userId", token.userId.toString());
      await prefs.setBool("isLogged", true);
      state = AsyncData(newState);
      return true;
    } catch (error) {
      state = AsyncData(
        AuthState(
          accessToken: null,
          refreshToken: null,
          isLogged: false,
          userId: null,
        ),
      );
      return false;
    }
  }

  Future<void> register(ref, String username, String password) async {
    state = const AsyncValue.loading();
    try {
      await AuthRepository(ref).register(ref, username, password);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    state = AsyncData(const AuthState(isLogged: false));
  }

  Future<void> RefreshToken(ref) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getString("userId");
    final refreshTokenString = prefs.getString("refreshToken");

    if (userId == null || refreshTokenString == null) {
      await logout();
      return;
    }

    try {
      final token = await AuthRepository(
        ref,
      ).refreshToken(ref, userId, refreshTokenString);

      if (token == null) {
        await logout();
      } else {
        await prefs.setString("accessToken", token.accessToken.toString());
        await prefs.setString("refreshToken", token.refreshToken.toString());
        await prefs.setString("userId", token.userId.toString());
        await prefs.setBool("isLogged", true);

        final newState = AuthState(
          accessToken: token.accessToken,
          refreshToken: token.refreshToken,
          userId: token.userId,
          isLogged: true,
        );

        state = AsyncData(newState);
      }
    } catch (error) {
      await logout();
    }
  }
}

final authProviderNotifier = AsyncNotifierProvider<Authprovider, AuthState>(() {
  return Authprovider();
});

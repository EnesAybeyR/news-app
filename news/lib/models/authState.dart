class AuthState {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final bool isLogged;

  const AuthState({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.isLogged = false,
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    String? userId,
    bool? isLogged,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      isLogged: isLogged ?? this.isLogged,
    );
  }
}

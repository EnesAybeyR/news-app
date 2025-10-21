import 'package:flutter/material.dart';

abstract class AuthAdapter {
  Future login(BuildContext context, String username, String password);
  Future register(BuildContext context, String username, String password);
  Future nfa(BuildContext context, String username);
  Future nfaLogin(
    BuildContext context,
    String username,
    String password,
    String code,
  );
  Future nfaWithId(BuildContext context);
  Future changeEmail(BuildContext context, String email, String password);
}

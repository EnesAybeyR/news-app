import 'package:flutter/material.dart';

abstract class Adapter {
  Future fetchNews(BuildContext context);
  Future fetchCategories(BuildContext context);
  Future fetchNewsByCategory(BuildContext context, int categoryId);
  Future fetchEditorName(BuildContext context, String editorId);
  Future fetchByName(BuildContext context, String newName);
}

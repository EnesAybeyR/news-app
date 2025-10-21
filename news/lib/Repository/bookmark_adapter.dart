import 'package:flutter/material.dart';

abstract class BookmarkAdapter {
  Future addBookmarks(BuildContext context, String newId);
  Future fetchBookmarks(BuildContext context);
  Future deleteBookmarks(BuildContext context, String bookmarkId);
}

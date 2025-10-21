import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/bookmark_repo.dart';
import 'package:news/models/bookmarks.dart';
import 'package:news/provider/authProvider.dart';

class Bookmarkprovider extends AsyncNotifier<List<Bookmarks>> {
  @override
  List<Bookmarks> build() {
    return [];
  }

  Future addBookmark(ref, String newId) async {
    final authState = await ref.watch(authProviderNotifier.future);
    if (authState == null || !authState.isLogged) {
      state = const AsyncValue.data([]);
      return;
    }
    try {
      final add = await BookmarkRepo(ref).addBookmarks(ref, newId);
      if (add) {
        final resp = await BookmarkRepo(ref).fetchBookmarks(ref);
        state = AsyncValue.data(resp);
      }
    } catch (e) {
      //
    }
  }

  Future deleteBookmarks(ref, String bookmarkId) async {
    final authState = await ref.watch(authProviderNotifier.future);
    if (authState == null || !authState.isLogged) {
      state = const AsyncValue.data([]);
      return;
    }
    try {
      final add = await BookmarkRepo(ref).deleteBookmarks(ref, bookmarkId);
      if (add) {
        final resp = await BookmarkRepo(ref).fetchBookmarks(ref);
        state = AsyncValue.data(resp);
      }
    } catch (e) {
      //
    }
  }

  Future fetchBookmarks(ref) async {
    state = const AsyncValue.loading();

    try {
      final resp = await BookmarkRepo(ref).fetchBookmarks(ref);

      state = AsyncValue.data(resp);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final bookmarkprovider =
    AsyncNotifierProvider<Bookmarkprovider, List<Bookmarks>>(() {
      return Bookmarkprovider();
    });

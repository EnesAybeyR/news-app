import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/news_repository.dart';

class EditorNameProvider extends AsyncNotifier<String> {
  @override
  String build() {
    return " ";
  }

  Future<String> getEditorName(ref, String editorId) async {
    state = const AsyncValue.loading();
    try {
      final editorName = await NewsRepository(
        ref,
      ).fetchEditorName(ref, editorId);
      state = AsyncValue.data(editorName);
      return editorName;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return "";
    }
  }
}

final editorNameProviderNotifier =
    AsyncNotifierProvider<EditorNameProvider, String>(() {
      return EditorNameProvider();
    });

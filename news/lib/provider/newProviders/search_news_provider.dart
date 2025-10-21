import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/news_repository.dart';
import 'package:news/models/news.dart';

class SearchNewsProvider extends AsyncNotifier<List<News>> {
  @override
  List<News> build() {
    return [];
  }

  Future getNewsByName(ref, String newName) async {
    state = const AsyncValue.loading();
    try {
      final resp = await NewsRepository(ref).fetchByName(ref, newName);
      state = AsyncValue.data(resp);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final searchNewsProvider =
    AsyncNotifierProvider<SearchNewsProvider, List<News>>(() {
      return SearchNewsProvider();
    });

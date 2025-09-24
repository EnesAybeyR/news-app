import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/news_repository.dart';
import 'package:news/models/news.dart';

class NewsProvider extends AsyncNotifier<List<News>> {
  @override
  List<News> build() {
    return [];
  }

  Future<void> getNews(ref) async {
    state = const AsyncValue.loading();
    try {
      final news = await NewsRepository(ref).fetchNews(ref);
      state = AsyncValue.data(news);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final newsProviderNotifier = AsyncNotifierProvider<NewsProvider, List<News>>(
  () {
    return NewsProvider();
  },
);

class NewsCategoryScreenProvider extends AsyncNotifier<List<News>> {
  @override
  List<News> build() {
    return [];
  }

  Future<void> getNewsByCategory(ref, int categoryId) async {
    state = const AsyncValue.loading();
    try {
      final news = await NewsRepository(
        ref,
      ).fetchNewsByCategory(ref, categoryId);
      state = AsyncValue.data(news);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final newsCategoryScreenProviderNotifier =
    AsyncNotifierProvider<NewsCategoryScreenProvider, List<News>>(() {
      return NewsCategoryScreenProvider();
    });

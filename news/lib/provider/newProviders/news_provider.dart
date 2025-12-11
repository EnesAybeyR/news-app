import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/news_repository.dart';
import 'package:news/models/news.dart';

class NewsProvider extends AsyncNotifier<List<News>> {
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool get hasmore => _hasMore;

  @override
  List<News> build() {
    return [];
  }

  Future<void> initalLoadNews(ref) async {
    _page = 1;
    _hasMore = true;
    _isLoadingMore = false;
    state = const AsyncValue.loading();
    try {
      final news = await NewsRepository(ref).fetchNews(ref, _page, _limit);
      if (news.length < _limit) _hasMore = false;
      state = AsyncValue.data(news);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> loadMoreNews(ref) async {
    if (_isLoadingMore || !_hasMore || state.isLoading) {
      return;
    }
    final currentList = state.value ?? [];
    _isLoadingMore = true;
    try {
      final nextPage = _page + 1;
      final newNews = await NewsRepository(
        ref,
      ).fetchNews(ref, nextPage, _limit);
      if (newNews.length < _limit) {
        _hasMore = false;
      }
      _page = nextPage;
      state = AsyncData([...currentList, ...newNews]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> getNews(ref) async {
    state = const AsyncValue.loading();
    try {
      final news = await NewsRepository(ref).fetchNews(ref, 0, 0);
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

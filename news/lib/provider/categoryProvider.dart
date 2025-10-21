import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/news_repository.dart';
import 'package:news/models/category.dart';

class CategoryProvider extends AsyncNotifier<List<Category>> {
  @override
  List<Category> build() {
    return [];
  }

  Future<void> getCategories(ref) async {
    state = const AsyncValue.loading();
    try {
      final category = await NewsRepository(ref).fetchCategories(ref);
      state = AsyncValue.data(category);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final categoryProviderNotifier =
    AsyncNotifierProvider<CategoryProvider, List<Category>>(() {
      return CategoryProvider();
    });

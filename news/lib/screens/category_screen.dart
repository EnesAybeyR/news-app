// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/models/category.dart';
import 'package:news/provider/newProviders/news_provider.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/screens/news_detail_screen_alert.dart';
import 'package:news/widgets/all_item_widget.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({required this.category, super.key});
  final Category category;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(newsCategoryScreenProviderNotifier.notifier)
          .getNewsByCategory(ref, widget.category.id);
    });
  }

  final Color col = Color.fromARGB(255, 240, 238, 242);
  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsCategoryScreenProviderNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.categoryName,
          style: TextStyle(fontSize: 24),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: col,
      ),
      backgroundColor: col,
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(height: 10),
            news.when(
              data: (newsList) {
                if (newsList.isEmpty) {
                  return Center(
                    child: Text(
                      "There is no news about this category yet",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      var newItem = newsList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailScreen(new1: newItem),
                            ),
                          );
                        },
                        child: AllItemWidget(
                          imagePath: newItem.images[0].imagePath,
                          header: newItem.headline,
                          datetime: newItem.createDate,
                          country: newItem.countryName,
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stack) => Center(child: Text('Error: $error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

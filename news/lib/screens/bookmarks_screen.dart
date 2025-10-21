import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/provider/bookmarkProvider.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/widgets/all_item_widget.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    final bookmarks = ref.watch(bookmarkprovider);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('The Daily World News', style: TextStyle(fontSize: 22)),
        centerTitle: false,
      ),
      backgroundColor: Color.fromARGB(255, 240, 238, 242),
      body: SingleChildScrollView(
        child: bookmarks.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var newItem = data[index].news;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(new1: newItem),
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
            );
          },
          error: (error, stack) => Center(child: Text('Error: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

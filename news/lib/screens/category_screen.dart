// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/models/news.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/widgets/all_item_widget.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({required this.categoryName, super.key});
  final String categoryName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final News new1 = News(
    id: 1,
    headline: 'US blocks UN call for Gaza ceasefire for sixth time',
    createDate: DateTime(2024, 12, 24),
    editorId: 1,
    countryName: 'Turkey',
    topicId: 1,
    entryCount: 0,
  );
  final Color col = Color.fromARGB(255, 240, 238, 242);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName, style: TextStyle(fontSize: 24)),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: col,
      ),
      backgroundColor: col,
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //context.push(RouteLocation.detail);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(new1: new1),
                        ),
                      );
                    },
                    child: AllItemWidget(
                      imagePath: 'https://picsum.photos/200/300',
                      header: '',
                      datetime: DateTime(1998, 12, 21, 12, 44, 12, 12, 12),
                      country: '',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

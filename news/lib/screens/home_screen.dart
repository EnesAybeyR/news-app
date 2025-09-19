import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/models/news.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/widgets/all_item_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final tabbars = [
    'All',
    'News',
    'Earth',
    'Businnes',
    'Innovation',
    'Culture',
    'Arts',
    'Travel',
    'Sport',
  ];
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
      backgroundColor: col,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            SizedBox(height: 5),
            Text('The Daily World News', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(color: col),
              height: 30,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tabbars.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(tabbars[index]),
                        ),
                        if (index != tabbars.length - 1) Text(' | '),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
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

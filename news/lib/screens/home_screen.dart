import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/provider/categoryProvider.dart';
import 'package:news/provider/newProviders/news_provider.dart';
import 'package:news/screens/category_screen.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/widgets/all_item_widget.dart';
import 'package:news/widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsProviderNotifier.notifier).initalLoadNews(ref);
      ref.read(categoryProviderNotifier.notifier).getCategories(ref);
    });
  }

  void _onScroll() {
    // Listenin sonuna 200px kala tetikle
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(newsProviderNotifier.notifier).loadMoreNews(ref);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final Color col = Color.fromARGB(255, 240, 238, 242);
  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProviderNotifier);
    final categories = ref.watch(categoryProviderNotifier);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      backgroundColor: col,
      body: SafeArea(
        child: SizedBox(
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
                  child: categories.when(
                    data: (newCategories) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: newCategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (newCategories[index].categoryName !=
                                      "All") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryScreen(
                                          category: newCategories[index],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  newCategories[index].categoryName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:
                                        newCategories[index].categoryName ==
                                            "All"
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (index != newCategories.length - 1)
                                Text(' | '),
                            ],
                          );
                        },
                      );
                    },
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              SizedBox(height: 4),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(newsProviderNotifier.notifier)
                        .initalLoadNews(ref);
                  },
                  child: news.when(
                    data: (newsList) {
                      if (newsList.isEmpty) {
                        return const Center(child: Text("No News Available"));
                      }
                      final bool show = ref
                          .read(newsProviderNotifier.notifier)
                          .hasmore;
                      final itemCount = newsList.length + (show ? 1 : 0);
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          if (index == newsList.length) {
                            return const Padding(
                              padding: EdgeInsetsGeometry.all(8),
                              child: CircularProgressIndicator(),
                            );
                          }
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
                      );
                    },
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: tabbars.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CategoryScreen(
//                                   categoryName: tabbars[index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             tabbars[index],
//                             style: TextStyle(
//                               fontWeight: tabbars[index] == "All"
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         if (index != tabbars.length - 1) Text(' | '),
//                       ],
//                     );
//                   },
//                 ),







// news != AsyncValue.data([])
//         ? Scaffold(
//             body: SizedBox(
//               height: MediaQuery.sizeOf(context).height,
//               width: MediaQuery.sizeOf(context).width,
//               child: Column(
//                 children: [
//                   news.when(
//                     data: (newsList) {
//                       return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: MediaQuery.sizeOf(context).height,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: newsList.length,
//                                 itemBuilder: (context, index) {
//                                   final news = newsList[index];
//                                   return Column(
//                                     children: [
//                                       ListTile(title: Text(news.headline)),
//                                       ListTile(title: Text(news.countryName)),
//                                       ListTile(title: Text(news.editorId)),
//                                       ListTile(title: Text(news.id)),
//                                       ListTile(
//                                         title: Text(news.categoryId.toString()),
//                                       ),
//                                       ListTile(
//                                         title: Text(news.createDate.toString()),
//                                       ),
//                                       ListTile(
//                                         title: Text(news.entryCount.toString()),
//                                       ),
//                                       ListTile(
//                                         title: Text(news.images[0].imageName),
//                                       ),
//                                       ListTile(
//                                         title: Text(
//                                           news.newContents[0].content,
//                                         ),
//                                       ),
//                                       Text(
//                                         "==================================",
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     error: (error, stack) =>
//                         Center(child: Text('Error: $error')),
//                     loading: () =>
//                         const Center(child: CircularProgressIndicator()),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : 
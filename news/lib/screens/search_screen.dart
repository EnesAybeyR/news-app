import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/provider/bookmarkProvider.dart';
import 'package:news/provider/newProviders/search_news_provider.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/widgets/custom_bottom_nav_bar.dart';
import 'package:news/widgets/custom_search_item.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static SearchScreen builder(BuildContext context, GoRouterState state) =>
      SearchScreen();
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookmarkprovider.notifier).fetchBookmarks(ref);
    });
  }

  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchNewsProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 238, 242),
      appBar: AppBar(
        title: Text('SEARCH', style: TextStyle(fontSize: 22)),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsetsGeometry.directional(start: 8, end: 8),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hint: Text("Search"),
                  suffixIcon: const Icon(Icons.search_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                ),
                onChanged: (value) => ref
                    .read(searchNewsProvider.notifier)
                    .getNewsByName(ref, value),
              ),
            ),
            SizedBox(height: 12),
            controller.text != ''
                ? search.when(
                    data: (data) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var newItem = data[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailScreen(new1: newItem),
                                  ),
                                ),
                                child: CustomSearchItem(
                                  header: newItem.headline,
                                  imagePath: newItem.images.isNotEmpty
                                      ? newItem.images[0].imagePath
                                      : '',
                                  datetime: newItem.createDate,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}

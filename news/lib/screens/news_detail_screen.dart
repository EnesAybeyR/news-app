// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news/models/images.dart';

import 'package:news/models/news.dart';
import 'package:news/models/newsContent.dart';
import 'package:news/provider/authProvider.dart';
import 'package:news/provider/bookmarkProvider.dart';
import 'package:news/provider/editorNameProvider.dart';

class NewsDetailScreen extends ConsumerStatefulWidget {
  const NewsDetailScreen({required this.new1, super.key});
  final News new1;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewsDetailScreenState();
}

class _NewsDetailScreenState extends ConsumerState<NewsDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(editorNameProviderNotifier.notifier)
          .getEditorName(ref, widget.new1.editorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final new1 = widget.new1;
    final allLength = new1.newContents.length + new1.images.length;

    final bookmarks = ref.watch(bookmarkprovider);
    final auth = ref.watch(authProviderNotifier);
    final List<dynamic> allItems = [];
    allItems.addAll(new1.images);
    allItems.addAll(new1.newContents);

    allItems.sort((a, b) {
      final aOrder = a.order;
      final bOrder = b.order;
      return aOrder.compareTo(bOrder);
    });

    String remain = '';
    final name = ref.watch(editorNameProviderNotifier);
    final Duration dur = DateTime.now().difference(new1.createDate);
    if (dur.inSeconds < 60) {
      remain = 'Now';
    } else if (dur.inMinutes < 60) {
      remain = '${dur.inMinutes.toString()} minutes ago';
    } else if (dur.inHours < 24) {
      remain = '${dur.inHours.toString()} hours ago';
    } else if (dur.inDays < 365) {
      remain = '${dur.inDays.toString()} days ago';
    } else {
      remain = '${(dur.inDays / 365).toString()} year ago';
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('The Daily World News', style: TextStyle(fontSize: 22)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    new1.headline,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(remain, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      name.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Text(' ');
                          }
                          return Text(
                            data.toString(),
                            style: TextStyle(fontSize: 12),
                          );
                        },
                        error: (error, stack) =>
                            Center(child: Text('Error: $error')),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      auth.when(
                        data: (data) {
                          if (data.isLogged == true) {
                            return bookmarks.when(
                              data: (data) {
                                final existing = data.firstWhereOrNull(
                                  (b) => b.news.id == new1.id,
                                );
                                return IconButton(
                                  icon: Icon(
                                    existing == null
                                        ? Ionicons.bookmark_outline
                                        : Icons.bookmark,
                                    color: existing == null
                                        ? Colors.black
                                        : Colors.amber,
                                  ),
                                  onPressed: () async {
                                    if (existing == null) {
                                      await ref
                                          .read(bookmarkprovider.notifier)
                                          .addBookmark(ref, new1.id);
                                    } else {
                                      await ref
                                          .read(bookmarkprovider.notifier)
                                          .deleteBookmarks(ref, existing.id);
                                    }
                                  },
                                );
                              },
                              error: (error, stack) =>
                                  Center(child: Text('Error: $error')),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Text('');
                        },
                        error: (error, stack) =>
                            Center(child: Text('Error: $error')),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: allLength,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = allItems[index];
                if (item is Images) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12, top: 5),
                    child: Image.network(
                      item.imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  );
                }
                if (item is NewsContent) {
                  if (item.contentType == "subheader") {
                    return Padding(
                      padding: EdgeInsetsGeometry.all(12),
                      child: Text(
                        item.content,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: Text(item.content),
                    );
                  }
                }
                return Center(child: Text(allLength.toString()));
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

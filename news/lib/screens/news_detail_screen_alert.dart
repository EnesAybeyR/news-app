// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/retry.dart';
import 'package:news/models/news.dart';
import 'package:news/provider/editorNameProvider.dart';

class NewsDetailScreenAlert extends ConsumerStatefulWidget {
  const NewsDetailScreenAlert({required this.new1, super.key});
  final News new1;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewsDetailScreenState();
}

class _NewsDetailScreenState extends ConsumerState<NewsDetailScreenAlert> {
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
        title: Text('The Daily World News', style: TextStyle(fontSize: 24)),
        centerTitle: true,
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
                  SizedBox(height: 6),
                ],
              ),
            ),
            Image.network(
              new1.images[0].imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(new1.newContents[0].content),
                  SizedBox(height: 4),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

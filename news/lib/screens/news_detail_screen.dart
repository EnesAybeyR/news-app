import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/widgets/custom_app_bar.dart';

class NewsDetailScreen extends ConsumerStatefulWidget {
  const NewsDetailScreen({super.key, required this.new1});
  final News new1;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewsDetailScreenState();
}

class _NewsDetailScreenState extends ConsumerState<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final new1 = widget.new1;
    String remain = '';
    final Duration dur = DateTime.now().difference(new1.createDate);
    if (dur.inSeconds < 60) {
      remain = 'Now';
    } else if (dur.inMinutes < 60) {
      remain = dur.inMinutes.toString() + ' minutes ago';
    } else if (dur.inHours < 24) {
      remain = dur.inHours.toString() + ' hours ago';
    } else if (dur.inDays < 365) {
      remain = dur.inDays.toString() + ' days ago';
    } else {
      remain = (dur.inDays / 365).toString() + ' year ago';
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    new1.headline,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text(remain, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  Text('Editor name'),
                  SizedBox(height: 6),
                ],
              ),
            ),
            Image.network(
              'https://picsum.photos/1920/1080',
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate nesciunt accusantium deserunt ab doloremque.',
                  ),
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

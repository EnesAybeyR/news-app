// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchItem extends ConsumerStatefulWidget {
  const CustomSearchItem({
    required this.imagePath,
    required this.header,
    required this.datetime,
    super.key,
  });
  final String imagePath;
  final String header;
  final DateTime datetime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSearchItemState();
}

class _CustomSearchItemState extends ConsumerState<CustomSearchItem> {
  @override
  Widget build(BuildContext context) {
    String remain = '';
    final Duration dur = DateTime.now().difference(widget.datetime);
    if (dur.inSeconds < 60) {
      remain = 'Now';
    } else if (dur.inMinutes < 60) {
      remain = '${dur.inMinutes.toInt().toString()} minutes ago';
    } else if (dur.inHours < 24) {
      remain = '${dur.inHours.toInt().toString()} hours ago';
    } else if (dur.inDays < 365) {
      remain = '${dur.inDays.toInt().toString()} days ago';
    } else {
      remain = '${(dur.inDays / 365).toInt().toString()} year ago';
    }
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 90,

            child: Image.network(widget.imagePath, fit: BoxFit.fill),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.header,
                  style: TextStyle(overflow: TextOverflow.clip, fontSize: 16),
                  maxLines: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      remain,
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 101, 105, 106),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

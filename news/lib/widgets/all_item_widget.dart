import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllItemWidget extends ConsumerStatefulWidget {
  const AllItemWidget({
    required this.imagePath,
    required this.header,
    required this.datetime,
    required this.country,
    super.key,
  });
  final String imagePath;
  final String header;
  final DateTime datetime;
  final String country;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllItemWidgetState();
}

class _AllItemWidgetState extends ConsumerState<AllItemWidget> {
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        //height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                widget.imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.header,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("$remain / ${widget.country}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

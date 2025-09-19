// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 280,
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
                'https://picsum.photos/1920/1080',
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
                  "Şanlıurfa'yı ziyaret eden Japon Prensesi Mikasa'nın ilk durağı Balıklıgöl oldu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

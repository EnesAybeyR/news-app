import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Column(
        children: [
          SizedBox(height: 5),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 35),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'The Daily World News',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          Divider(color: Colors.black, thickness: 0.6),
        ],
      ),
    );
  }
}

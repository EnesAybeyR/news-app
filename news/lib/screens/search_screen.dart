import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/widgets/custom_bottom_nav_bar.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static SearchScreen builder(BuildContext context, GoRouterState state) =>
      SearchScreen();
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seacrh', style: TextStyle(fontSize: 24))),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(child: Text("Search page")),
    );
  }
}

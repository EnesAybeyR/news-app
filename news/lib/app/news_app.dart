import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/config/routes/routes_provider.dart';
import 'package:news/provider/authProvider.dart';
import 'package:news/provider/bookmarkProvider.dart';

class NewsApp extends ConsumerStatefulWidget {
  const NewsApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsAppState();
}

class _NewsAppState extends ConsumerState<NewsApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProviderNotifier.notifier).refreshToken(ref);
      ref.read(bookmarkprovider.notifier).fetchBookmarks(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeConfig = ref.watch(routeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routeConfig,
    );
  }
}














//
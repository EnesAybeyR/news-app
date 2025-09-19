import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/config/routes/routes_provider.dart';

class NewsApp extends ConsumerWidget {
    const NewsApp({super.key});


    @override
    Widget build(BuildContext context,WidgetRef ref) {
      final routeConfig = ref.watch(routeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routeConfig,
        );
    }
    
}
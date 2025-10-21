import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/config/routes/route_location.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/profile_screen.dart';
import 'package:news/screens/search_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.search,
    parentNavigatorKey: navigationKey,
    builder: SearchScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.profile,
    parentNavigatorKey: navigationKey,
    builder: ProfileScreen.builder,
  ),
];

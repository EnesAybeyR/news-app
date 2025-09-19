import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/config/routes/app_routes.dart';
import 'package:news/config/routes/route_location.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigationKey,
    initialLocation: RouteLocation.home,
    routes: appRoutes,
  );
});

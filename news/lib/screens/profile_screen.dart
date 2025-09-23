import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static ProfileScreen builder(BuildContext context, GoRouterState state) =>
      ProfileScreen();
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomNavBar());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/config/routes/route_location.dart';
import 'package:news/provider/bottom_nav_bar_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavBarProviderNotifier);
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        ref.read(bottomNavBarProviderNotifier.notifier).state = index;
        switch (index) {
          case 0:
            context.pushReplacement(RouteLocation.home);
            break;
          case 1:
            context.pushReplacement(RouteLocation.search);
          case 2:
            context.pushReplacement(RouteLocation.profile);
          default:
            context.pushReplacement(RouteLocation.home);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'search'),
        BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'profile'),
      ],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }
}

final bottomNavBarProviderNotifier =
    NotifierProvider<BottomNavBarProvider, int>(() {
      return BottomNavBarProvider();
    });

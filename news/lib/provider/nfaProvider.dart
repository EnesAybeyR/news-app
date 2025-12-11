import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/auth_repository.dart';

class Nfaprovider extends AsyncNotifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<bool> fetchNfa(ref, String username) async {
    state = const AsyncValue.loading();
    try {
      final nfa = await AuthRepository(ref).nfa(ref, username);
      state = AsyncValue.data(nfa);
      return nfa;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> fetchNfaWithId(ref) async {
    state = const AsyncValue.loading();
    try {
      final nfa = await AuthRepository(ref).nfaWithId(ref);

      state = AsyncValue.data(nfa);

      return nfa;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}

final nfaProvider = AsyncNotifierProvider<Nfaprovider, bool>(() {
  return Nfaprovider();
});

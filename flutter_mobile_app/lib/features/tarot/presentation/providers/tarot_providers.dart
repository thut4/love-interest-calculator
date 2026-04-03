import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/tarot_reading_repository_impl.dart';
import '../../domain/repositories/tarot_reading_repository.dart';
import '../state/tarot_reading_controller.dart';
import '../state/tarot_reading_state.dart';

final tarotReadingRepositoryProvider = Provider<TarotReadingRepository>((ref) {
  return TarotReadingRepositoryImpl();
});

final tarotReadingControllerProvider =
    StateNotifierProvider<TarotReadingController, TarotReadingState>((ref) {
      final repo = ref.watch(tarotReadingRepositoryProvider);
      return TarotReadingController(repository: repo);
    });

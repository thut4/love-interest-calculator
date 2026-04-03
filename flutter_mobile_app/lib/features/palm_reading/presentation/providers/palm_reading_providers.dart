import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/palm_reading_repository_impl.dart';
import '../../domain/repositories/palm_reading_repository.dart';
import '../state/palm_reading_controller.dart';
import '../state/palm_reading_state.dart';

final palmReadingRepositoryProvider = Provider<PalmReadingRepository>((ref) {
  return PalmReadingRepositoryImpl();
});

final palmReadingControllerProvider =
    StateNotifierProvider<PalmReadingController, PalmReadingState>((ref) {
  final repo = ref.watch(palmReadingRepositoryProvider);
  return PalmReadingController(repository: repo);
});

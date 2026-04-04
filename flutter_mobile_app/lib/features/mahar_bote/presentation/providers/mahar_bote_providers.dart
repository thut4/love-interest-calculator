import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mahar_bote_repository_impl.dart';
import '../../domain/entities/mahar_bote_house.dart';
import '../../domain/repositories/mahar_bote_repository.dart';
import '../../domain/usecases/calculate_mahar_bote.dart';
import '../state/mahar_bote_controller.dart';
import '../state/mahar_bote_state.dart';

final maharBoteRepositoryProvider = Provider<MaharBoteRepository>((ref) {
  return MaharBoteRepositoryImpl();
});

final maharBoteHouseCycleProvider = Provider<List<MaharBoteHouse>>((ref) {
  return ref.watch(maharBoteRepositoryProvider).getHouseCycle();
});

final calculateMaharBoteProvider = Provider<CalculateMaharBote>((ref) {
  return CalculateMaharBote(ref.watch(maharBoteRepositoryProvider));
});

final maharBoteControllerProvider =
    StateNotifierProvider.autoDispose<MaharBoteController, MaharBoteState>((
      ref,
    ) {
      final calculateMaharBote = ref.watch(calculateMaharBoteProvider);
      return MaharBoteController(calculateMaharBote: calculateMaharBote);
    });

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/saju_repository_impl.dart';
import '../../domain/repositories/saju_repository.dart';
import '../../domain/usecases/calculate_saju_profile.dart';
import '../state/saju_profile_controller.dart';
import '../state/saju_profile_state.dart';

final sajuRepositoryProvider = Provider<SajuRepository>((ref) {
  return SajuRepositoryImpl();
});

final calculateSajuProfileProvider = Provider<CalculateSajuProfile>((ref) {
  return CalculateSajuProfile(ref.watch(sajuRepositoryProvider));
});

final sajuProfileControllerProvider =
    StateNotifierProvider<SajuProfileController, SajuProfileState>((ref) {
      final useCase = ref.watch(calculateSajuProfileProvider);
      return SajuProfileController(useCase);
    });

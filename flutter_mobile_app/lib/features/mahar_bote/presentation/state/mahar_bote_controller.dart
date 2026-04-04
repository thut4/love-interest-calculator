import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/calculate_mahar_bote.dart';
import 'mahar_bote_state.dart';

class MaharBoteController extends StateNotifier<MaharBoteState> {
  MaharBoteController({required CalculateMaharBote calculateMaharBote})
    : _calculateMaharBote = calculateMaharBote,
      super(const MaharBoteState());

  final CalculateMaharBote _calculateMaharBote;

  void setBirthDate(DateTime birthDate) {
    final normalized = DateTime(birthDate.year, birthDate.month, birthDate.day);
    final result = _calculateMaharBote(normalized);

    state = state.copyWith(birthDate: normalized, result: result);
  }

  void reset() {
    state = const MaharBoteState();
  }
}

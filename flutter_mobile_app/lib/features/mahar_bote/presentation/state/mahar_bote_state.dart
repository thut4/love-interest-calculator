import '../../domain/entities/mahar_bote_result.dart';

class MaharBoteState {
  const MaharBoteState({this.birthDate, this.result});

  final DateTime? birthDate;
  final MaharBoteResult? result;

  bool get hasResult => result != null;

  MaharBoteState copyWith({
    DateTime? birthDate,
    MaharBoteResult? result,
    bool clearResult = false,
  }) {
    return MaharBoteState(
      birthDate: birthDate ?? this.birthDate,
      result: clearResult ? null : (result ?? this.result),
    );
  }
}

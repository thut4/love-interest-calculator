import '../entities/mahar_bote_result.dart';
import '../repositories/mahar_bote_repository.dart';

class CalculateMaharBote {
  const CalculateMaharBote(this._repository);

  final MaharBoteRepository _repository;

  MaharBoteResult call(DateTime birthDate) {
    return _repository.calculate(birthDate);
  }
}

import '../entities/saju_profile.dart';
import '../repositories/saju_repository.dart';

class CalculateSajuProfile {
  const CalculateSajuProfile(this._repository);

  final SajuRepository _repository;

  SajuProfile call({
    required DateTime birthDate,
    required int birthHour,
    required int birthMinute,
    required String birthCity,
    required String birthCountry,
  }) {
    return _repository.calculateProfile(
      birthDate: birthDate,
      birthHour: birthHour,
      birthMinute: birthMinute,
      birthCity: birthCity,
      birthCountry: birthCountry,
    );
  }
}

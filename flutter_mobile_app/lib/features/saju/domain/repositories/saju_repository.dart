import '../entities/saju_profile.dart';

abstract class SajuRepository {
  SajuProfile calculateProfile({
    required DateTime birthDate,
    required int birthHour,
    required int birthMinute,
    required String birthCity,
    required String birthCountry,
  });
}

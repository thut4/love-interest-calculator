import 'mahar_bote_house.dart';

class MaharBoteResult {
  const MaharBoteResult({
    required this.birthDate,
    required this.weekday,
    required this.myanmarYear,
    required this.remainder,
    required this.house,
  });

  final DateTime birthDate;
  final int weekday;
  final int myanmarYear;
  final int remainder;
  final MaharBoteHouse house;
}

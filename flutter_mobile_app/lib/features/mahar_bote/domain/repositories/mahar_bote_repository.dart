import '../entities/mahar_bote_house.dart';
import '../entities/mahar_bote_result.dart';

abstract class MaharBoteRepository {
  MaharBoteResult calculate(DateTime birthDate);

  List<MaharBoteHouse> getHouseCycle();
}

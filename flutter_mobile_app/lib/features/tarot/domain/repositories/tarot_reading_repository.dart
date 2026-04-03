import '../entities/tarot_card.dart';

abstract class TarotReadingRepository {
  Future<String> readSpread({required List<TarotCard> cards});
}

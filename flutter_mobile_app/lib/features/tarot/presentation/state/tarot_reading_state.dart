import '../../domain/entities/tarot_card.dart';

class TarotReadingState {
  const TarotReadingState({
    this.deck = const [],
    this.drawnCards = const [],
    this.isLoading = false,
    this.error,
    this.result,
    this.rawJson,
  });

  final List<TarotCard> deck;
  final List<TarotCard> drawnCards;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? result;
  final String? rawJson;

  bool get canDraw => deck.isNotEmpty && drawnCards.isEmpty && !isLoading;
  bool get canRead => drawnCards.length == 1 && !isLoading;
  bool get hasResult => result != null;
  int get cardsLeftToDraw => 1 - drawnCards.length;

  TarotReadingState copyWith({
    List<TarotCard>? deck,
    List<TarotCard>? drawnCards,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? result,
    String? rawJson,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return TarotReadingState(
      deck: deck ?? this.deck,
      drawnCards: drawnCards ?? this.drawnCards,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      result: clearResult ? null : result ?? this.result,
      rawJson: rawJson ?? this.rawJson,
    );
  }
}

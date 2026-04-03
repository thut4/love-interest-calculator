import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/tarot_card.dart';
import '../../domain/repositories/tarot_reading_repository.dart';
import 'tarot_reading_state.dart';

class TarotReadingController extends StateNotifier<TarotReadingState> {
  TarotReadingController({required TarotReadingRepository repository})
    : _repository = repository,
      _random = Random(),
      super(TarotReadingState(deck: _majorArcana));

  final TarotReadingRepository _repository;
  final Random _random;

  static const List<TarotCard> _majorArcana = [
    TarotCard(
      id: 'fool',
      number: 0,
      name: 'The Fool',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2000%20Fool.jpg',
    ),
    TarotCard(
      id: 'magician',
      number: 1,
      name: 'The Magician',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2001%20Magician.jpg',
    ),
    TarotCard(
      id: 'high-priestess',
      number: 2,
      name: 'The High Priestess',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2002%20High%20Priestess.jpg',
    ),
    TarotCard(
      id: 'empress',
      number: 3,
      name: 'The Empress',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2003%20Empress.jpg',
    ),
    TarotCard(
      id: 'emperor',
      number: 4,
      name: 'The Emperor',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2004%20Emperor.jpg',
    ),
    TarotCard(
      id: 'hierophant',
      number: 5,
      name: 'The Hierophant',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2005%20Hierophant.jpg',
    ),
    TarotCard(
      id: 'lovers',
      number: 6,
      name: 'The Lovers',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2006%20Lovers.jpg',
    ),
    TarotCard(
      id: 'chariot',
      number: 7,
      name: 'The Chariot',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2007%20Chariot.jpg',
    ),
    TarotCard(
      id: 'strength',
      number: 8,
      name: 'Strength',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2008%20Strength.jpg',
    ),
    TarotCard(
      id: 'hermit',
      number: 9,
      name: 'The Hermit',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2009%20Hermit.jpg',
    ),
    TarotCard(
      id: 'wheel-of-fortune',
      number: 10,
      name: 'Wheel of Fortune',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2010%20Wheel%20of%20Fortune.jpg',
    ),
    TarotCard(
      id: 'justice',
      number: 11,
      name: 'Justice',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2011%20Justice.jpg',
    ),
    TarotCard(
      id: 'hanged-man',
      number: 12,
      name: 'The Hanged Man',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2012%20Hanged%20Man.jpg',
    ),
    TarotCard(
      id: 'death',
      number: 13,
      name: 'Death',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2013%20Death.jpg',
    ),
    TarotCard(
      id: 'temperance',
      number: 14,
      name: 'Temperance',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2014%20Temperance.jpg',
    ),
    TarotCard(
      id: 'devil',
      number: 15,
      name: 'The Devil',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2015%20Devil.jpg',
    ),
    TarotCard(
      id: 'tower',
      number: 16,
      name: 'The Tower',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2016%20Tower.jpg',
    ),
    TarotCard(
      id: 'star',
      number: 17,
      name: 'The Star',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2017%20Star.jpg',
    ),
    TarotCard(
      id: 'moon',
      number: 18,
      name: 'The Moon',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2018%20Moon.jpg',
    ),
    TarotCard(
      id: 'sun',
      number: 19,
      name: 'The Sun',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2019%20Sun.jpg',
    ),
    TarotCard(
      id: 'judgement',
      number: 20,
      name: 'Judgement',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2020%20Judgement.jpg',
    ),
    TarotCard(
      id: 'world',
      number: 21,
      name: 'The World',
      imageUrl:
          'https://commons.wikimedia.org/wiki/Special:FilePath/RWS%20Tarot%2021%20World.jpg',
    ),
  ];

  void drawNextCard() {
    if (!state.canDraw) return;

    final nextDeck = List<TarotCard>.from(state.deck);
    final index = _random.nextInt(nextDeck.length);
    final baseCard = nextDeck.removeAt(index);
    final drawnCard = baseCard.copyWith(isReversed: _random.nextBool());

    state = state.copyWith(
      deck: nextDeck,
      drawnCards: [...state.drawnCards, drawnCard],
      clearError: true,
      clearResult: true,
      rawJson: null,
    );
  }

  void selectCard(String cardId) {
    if (!state.canDraw) return;

    final nextDeck = List<TarotCard>.from(state.deck);
    final index = nextDeck.indexWhere((card) => card.id == cardId);
    if (index == -1) return;

    final baseCard = nextDeck.removeAt(index);
    final drawnCard = baseCard.copyWith(isReversed: _random.nextBool());

    state = state.copyWith(
      deck: nextDeck,
      drawnCards: [...state.drawnCards, drawnCard],
      clearError: true,
      clearResult: true,
      rawJson: null,
    );
  }

  Future<void> readSpread() async {
    if (!state.canRead) {
      state = state.copyWith(
        error: 'Draw a Major Arcana card before requesting the reading.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final raw = await _repository.readSpread(cards: state.drawnCards);
      final parsed = _decodeJson(raw);
      if (parsed == null) {
        state = state.copyWith(
          isLoading: false,
          error:
              'Unable to read the tarot response. Check the raw response below.',
          rawJson: raw,
        );
        return;
      }

      state = state.copyWith(isLoading: false, result: parsed, rawJson: raw);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString().replaceFirst('StateError: ', ''),
      );
    }
  }

  void restart() {
    final refreshedDeck = List<TarotCard>.from(_majorArcana);
    state = TarotReadingState(deck: refreshedDeck);
  }

  Map<String, dynamic>? _decodeJson(String raw) {
    try {
      var sanitized = raw.trim();
      if (sanitized.startsWith('```')) {
        sanitized = sanitized.replaceAll('```json', '').replaceAll('```', '');
      }
      final firstBrace = sanitized.indexOf('{');
      final lastBrace = sanitized.lastIndexOf('}');
      if (firstBrace != -1 && lastBrace != -1 && lastBrace > firstBrace) {
        sanitized = sanitized.substring(firstBrace, lastBrace + 1);
      }
      final decoded = jsonDecode(sanitized);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }
}

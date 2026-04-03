import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/tarot_card.dart';
import '../providers/tarot_providers.dart';

class TarotReadingScreen extends ConsumerWidget {
  const TarotReadingScreen({super.key});

  static const List<String> _positions = ['Your Card'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tarotReadingControllerProvider);
    final controller = ref.read(tarotReadingControllerProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final selectedCount = state.drawnCards.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Major Arcana Tarot'),
        backgroundColor: Colors.transparent,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            physics: const BouncingScrollPhysics(),
            children: [
              GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Draw a card', style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Browse the 22-card Major Arcana deck, choose an insightful card, and begin your reading.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _DeckPanel(
                deck: state.deck,
                selectedCount: selectedCount,
                onSelect: state.canDraw ? controller.selectCard : null,
              ),
              const SizedBox(height: 14),
              _SpreadPanel(cards: state.drawnCards, positions: _positions),
              if (state.canRead) ...[
                const SizedBox(height: 14),
                _ChosenCardsPanel(
                  cards: state.drawnCards,
                  positions: _positions,
                ),
              ],
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: state.canRead ? controller.readSpread : null,
                icon: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.menu_book_rounded),
                label: Text(
                  state.canRead ? 'Read My Card' : 'Select a Card First',
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: state.isLoading ? null : controller.restart,
                  child: const Text('Shuffle and start over'),
                ),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                _MessageCard(
                  title: 'Tarot reading issue',
                  body: state.error!,
                  accent: const Color(0xFFFF7A7A),
                ),
              ],
              if (state.error != null && state.rawJson != null) ...[
                const SizedBox(height: 12),
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Raw response', style: textTheme.titleMedium),
                      const SizedBox(height: 8),
                      SelectableText(
                        state.rawJson!,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.84),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (state.hasResult) ...[
                const SizedBox(height: 18),
                _ReadingPanel(
                  result: state.result!,
                  cards: state.drawnCards,
                  positions: _positions,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DeckPanel extends StatelessWidget {
  const _DeckPanel({
    required this.deck,
    required this.selectedCount,
    required this.onSelect,
  });

  final List<TarotCard> deck;
  final int selectedCount;
  final void Function(String cardId)? onSelect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const double cardWidth = 90.0;
    const double cardHeight = cardWidth / 0.62;
    const double overlap = 55.0;
    const double visibleWidth = cardWidth - overlap;
    final double totalWidth = cardWidth + (deck.length - 1) * visibleWidth;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('The deck', style: textTheme.titleLarge)),
              _Badge(label: '$selectedCount / 1 selected'),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            selectedCount < 1
                ? 'Swipe horizontally through the deck and tap a card to draw it.'
                : 'The deck is now closed because your card is drawn.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: cardHeight + 20,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: totalWidth + 10,
                  height: cardHeight + 20,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: List.generate(deck.length, (index) {
                      final card = deck[index];
                      return Positioned(
                        left: index * visibleWidth,
                        top: 10,
                        child: _DeckBackCard(
                          number: card.number,
                          enabled: onSelect != null,
                          width: cardWidth,
                          onTap: onSelect == null
                              ? null
                              : () => onSelect!(card.id),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpreadPanel extends StatelessWidget {
  const _SpreadPanel({required this.cards, required this.positions});

  final List<TarotCard> cards;
  final List<String> positions;

  @override
  Widget build(BuildContext context) {
    if (cards.isNotEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Your card', style: textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Draw a card from the deck above.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 140,
              child: GlassPanel(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const AspectRatio(
                      aspectRatio: 0.62,
                      child: _SlotBack(number: 1),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      positions[0],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChosenCardsPanel extends StatelessWidget {
  const _ChosenCardsPanel({required this.cards, required this.positions});

  final List<TarotCard> cards;
  final List<String> positions;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;
    final card = cards.first;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Chosen card', style: textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Now the card identity is revealed. Review it before starting the reading.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 160,
              child: GlassPanel(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.62,
                      child: _TarotCardFace(card: card),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      positions[0],
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.68),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadingPanel extends StatelessWidget {
  const _ReadingPanel({
    required this.result,
    required this.cards,
    required this.positions,
  });

  final Map<String, dynamic> result;
  final List<TarotCard> cards;
  final List<String> positions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardReadings = result['cards'] is List
        ? (result['cards'] as List).whereType<Map<String, dynamic>>().toList()
        : const <Map<String, dynamic>>[];
    final lifeAreas = result['life_areas'] is Map<String, dynamic>
        ? result['life_areas'] as Map<String, dynamic>
        : const <String, dynamic>{};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MessageCard(
          title: result['spread_name']?.toString() ?? 'Single card reading',
          body: result['overall_theme']?.toString() ?? '',
          accent: const Color(0xFFFFC56E),
        ),
        if (cardReadings.isNotEmpty) ...[
          const SizedBox(height: 14),
          ...List.generate(cardReadings.length, (index) {
            final item = cardReadings[index];
            return GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(positions[index], style: textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 72,
                        child: AspectRatio(
                          aspectRatio: 0.62,
                          child: _TarotCardFace(
                            card: cards[index],
                            showLabel: false,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['card_name']?.toString() ?? '',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _Badge(
                                  label: item['orientation']?.toString() ?? '',
                                ),
                                _Badge(
                                  label: item['keywords']?.toString() ?? '',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['meaning']?.toString() ?? '',
                    style: textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['advice']?.toString() ?? '',
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
        if ((result['combination_message']?.toString() ?? '')
            .trim()
            .isNotEmpty) ...[
          const SizedBox(height: 14),
          _MessageCard(
            title: 'Combination message',
            body: result['combination_message']!.toString(),
            accent: const Color(0xFF8B7CFF),
          ),
        ],
        if (lifeAreas.isNotEmpty) ...[
          const SizedBox(height: 14),
          _MessageCard(
            title: 'Love',
            body: lifeAreas['love']?.toString() ?? '',
            accent: const Color(0xFFFF7AB6),
          ),
          const SizedBox(height: 12),
          _MessageCard(
            title: 'Career',
            body: lifeAreas['career']?.toString() ?? '',
            accent: const Color(0xFF57D7FF),
          ),
          const SizedBox(height: 12),
          _MessageCard(
            title: 'Spirituality',
            body: lifeAreas['spirituality']?.toString() ?? '',
            accent: const Color(0xFFFFC56E),
          ),
        ],
        if ((result['action_to_take']?.toString() ?? '').trim().isNotEmpty) ...[
          const SizedBox(height: 14),
          _MessageCard(
            title: 'Action to take',
            body: result['action_to_take']!.toString(),
            accent: const Color(0xFF8DFFCC),
          ),
        ],
        if ((result['closing_message']?.toString() ?? '')
            .trim()
            .isNotEmpty) ...[
          const SizedBox(height: 12),
          _MessageCard(
            title: 'Closing message',
            body: result['closing_message']!.toString(),
            accent: const Color(0xFFFF7AB6),
          ),
        ],
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.title,
    required this.body,
    required this.accent,
  });

  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.16),
              Colors.white.withValues(alpha: 0.04),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(body, style: textTheme.bodyMedium?.copyWith(height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _TarotCardFace extends StatelessWidget {
  const _TarotCardFace({required this.card, this.showLabel = true});

  final TarotCard card;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform.rotate(
              angle: card.isReversed ? math.pi : 0,
              child: Image.network(card.imageUrl, fit: BoxFit.cover),
            ),
            if (showLabel)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withValues(alpha: 0.75),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        card.isReversed
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        card.isReversed ? 'Rev' : 'Up',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SlotBack extends StatelessWidget {
  const _SlotBack({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withValues(alpha: 0.2),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

class _DeckBackCard extends StatelessWidget {
  const _DeckBackCard({
    required this.number,
    required this.enabled,
    this.width = 100,
    this.onTap,
  });

  final int number;
  final bool enabled;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: enabled ? 1 : 0.55,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: AspectRatio(
            aspectRatio: 0.62,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [Color(0xFF2B3245), Color(0xFF131824)],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: enabled ? 0.3 : 0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.star_outline_rounded,
                      color: Colors.white.withValues(alpha: 0.2),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

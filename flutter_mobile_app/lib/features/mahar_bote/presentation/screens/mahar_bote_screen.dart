import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/mahar_bote_house.dart';
import '../../domain/entities/mahar_bote_result.dart';
import '../providers/mahar_bote_providers.dart';

const List<String> _weekdayEnglish = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> _weekdayMyanmar = [
  'တနင်္လာ',
  'အင်္ဂါ',
  'ဗုဒ္ဓဟူး',
  'ကြာသပတေး',
  'သောကြာ',
  'စနေ',
  'တနင်္ဂနွေ',
];

const List<String?> _boardLayout = [
  null,
  'adipati',
  null,
  'atun',
  'thike',
  'yaza',
  'marana',
  'binga',
  'puti',
];

class MaharBoteScreen extends ConsumerWidget {
  const MaharBoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maharBoteControllerProvider);
    final controller = ref.read(maharBoteControllerProvider.notifier);
    final houses = ref.watch(maharBoteHouseCycleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahar Bote Baydin'),
        backgroundColor: Colors.transparent,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  'Find your Mahar Bote house 🪄',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Pick your birth date to reveal your Baydin house with a playful cosmic snapshot.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                _BirthDateCard(
                  birthDate: state.birthDate,
                  onTap: () async {
                    final selected = await _pickBirthDate(
                      context,
                      initialDate: state.birthDate,
                    );
                    if (selected != null) {
                      controller.setBirthDate(selected);
                    }
                  },
                ),
                const SizedBox(height: 12),
                if (!state.hasResult) ...[
                  const _ReadyStateCard(),
                  const SizedBox(height: 12),
                  _MaharBoteBoard(houses: houses),
                ] else ...[
                  _ResultHero(result: state.result!),
                  const SizedBox(height: 12),
                  _MaharBoteBoard(
                    houses: houses,
                    selectedHouseId: state.result!.house.id,
                  ),
                  const SizedBox(height: 12),
                  _ResultFacts(result: state.result!),
                  const SizedBox(height: 12),
                  _HouseInsightCard(house: state.result!.house),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: controller.reset,
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('Try Another Birthday'),
                  ),
                ],
                const SizedBox(height: 10),
                Text(
                  'Formula source: referenced Mahar Bote repo logic using Myanmar year and weekday modulo 7.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _pickBirthDate(
    BuildContext context, {
    DateTime? initialDate,
  }) {
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
      initialDate: initialDate ?? DateTime(2000, 1, 1),
      helpText: 'Select Birthday',
    );
  }
}

class _BirthDateCard extends StatelessWidget {
  const _BirthDateCard({required this.birthDate, required this.onTap});

  final DateTime? birthDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7AB6), Color(0xFF8B7CFF)],
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.cake_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Birthday',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      birthDate == null
                          ? 'Tap to select date'
                          : MaterialLocalizations.of(
                              context,
                            ).formatMediumDate(birthDate!),
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Color(0xFF57D7FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadyStateCard extends StatelessWidget {
  const _ReadyStateCard();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF7AB6).withValues(alpha: 0.22),
              const Color(0xFF57D7FF).withValues(alpha: 0.17),
              const Color(0xFF8B7CFF).withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            const Text('🔮', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Tap your birthday and we will reveal your Mahar Bote house instantly.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultHero extends StatelessWidget {
  const _ResultHero({required this.result});

  final MaharBoteResult result;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accent = Color(result.house.accentHex);

    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.36),
              const Color(0xFFFF7AB6).withValues(alpha: 0.26),
              const Color(0xFF57D7FF).withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Your Mahar Bote House',
              style: textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(result.house.emoji, style: const TextStyle(fontSize: 42)),
            const SizedBox(height: 6),
            Text(
              '${result.house.englishName} • ${result.house.myanmarName}',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              result.house.vibe,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaharBoteBoard extends StatelessWidget {
  const _MaharBoteBoard({required this.houses, this.selectedHouseId});

  final List<MaharBoteHouse> houses;
  final String? selectedHouseId;

  @override
  Widget build(BuildContext context) {
    final houseById = {for (final house in houses) house.id: house};

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mahar Bote Board',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Layout follows the traditional house arrangement from the reference app.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white60),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _boardLayout.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9,
              childAspectRatio: 1.08,
            ),
            itemBuilder: (context, index) {
              final houseId = _boardLayout[index];
              if (houseId == null) return const _EmptyBoardCell();

              final house = houseById[houseId];
              if (house == null) return const _EmptyBoardCell();

              return _BoardCell(
                house: house,
                selected: selectedHouseId == house.id,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyBoardCell extends StatelessWidget {
  const _EmptyBoardCell();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
    );
  }
}

class _BoardCell extends StatelessWidget {
  const _BoardCell({required this.house, required this.selected});

  final MaharBoteHouse house;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = Color(house.accentHex);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: selected
            ? LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.42),
                  accent.withValues(alpha: 0.16),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: selected ? null : Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: selected ? accent : Colors.white.withValues(alpha: 0.22),
          width: selected ? 1.8 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.3),
                  blurRadius: 14,
                  spreadRadius: 0.5,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(house.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 3),
          Text(
            house.myanmarName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          Text(
            house.englishName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
          if (selected) ...[
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'YOU',
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResultFacts extends StatelessWidget {
  const _ResultFacts({required this.result});

  final MaharBoteResult result;

  @override
  Widget build(BuildContext context) {
    final weekdayIndex = _safeWeekdayIndex(result.weekday);
    final weekdayLabel =
        '${_weekdayEnglish[weekdayIndex]} • ${_weekdayMyanmar[weekdayIndex]}';

    return GlassPanel(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _FactChip(
            icon: '📅',
            label: MaterialLocalizations.of(
              context,
            ).formatFullDate(result.birthDate),
          ),
          _FactChip(icon: '🗓️', label: 'Born on $weekdayLabel'),
          _FactChip(icon: '🇲🇲', label: 'Myanmar year ${result.myanmarYear}'),
          _FactChip(icon: '➗', label: 'Remainder ${result.remainder}'),
          _FactChip(
            icon: '🧮',
            label:
                'House = (${result.myanmarYear} - ${result.weekday} - 1) % 7',
          ),
        ],
      ),
    );
  }

  int _safeWeekdayIndex(int weekday) {
    if (weekday < 1 || weekday > 7) return 0;
    return weekday - 1;
  }
}

class _FactChip extends StatelessWidget {
  const _FactChip({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.09),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Text(
        '$icon $label',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white.withValues(alpha: 0.9),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HouseInsightCard extends StatelessWidget {
  const _HouseInsightCard({required this.house});

  final MaharBoteHouse house;

  @override
  Widget build(BuildContext context) {
    final accent = Color(house.accentHex);

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(house.emoji),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Vibe Tips for ${house.englishName}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InsightRow(title: 'Energy', text: house.vibe),
          _InsightRow(title: 'Power Move', text: house.powerMove),
          _InsightRow(title: 'Playful Ritual', text: house.playfulTip),
        ],
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/saju_profile.dart';
import '../providers/saju_providers.dart';

const List<String> _elementOrder = ['Wood', 'Fire', 'Earth', 'Metal', 'Water'];

const Map<String, String> _elementKorean = {
  'Wood': '목(木)',
  'Fire': '화(火)',
  'Earth': '토(土)',
  'Metal': '금(金)',
  'Water': '수(水)',
};

const Map<String, Color> _elementColors = {
  'Wood': Color(0xFF7BD389),
  'Fire': Color(0xFFFF8FAB),
  'Earth': Color(0xFFFFD166),
  'Metal': Color(0xFFB8C0FF),
  'Water': Color(0xFF70D6FF),
};

class SajuProfileScreen extends ConsumerWidget {
  const SajuProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sajuProfileControllerProvider);
    final controller = ref.read(sajuProfileControllerProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saju Five Elements'),
        backgroundColor: Colors.transparent,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  'Saju (사주) Destiny Energy 🔮',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Use your full birth date, exact birth time, and birth city/country to calculate your 오행 profile.',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PickerField(
                        label: 'Full Birth Date',
                        icon: Icons.calendar_month_rounded,
                        accent: const Color(0xFFFF7AB6),
                        valueText: state.birthDate == null
                            ? 'Tap to select date'
                            : MaterialLocalizations.of(
                                context,
                              ).formatMediumDate(state.birthDate!),
                        onTap: () async {
                          final selected = await _pickDate(
                            context,
                            initialDate: state.birthDate,
                          );
                          if (selected != null) {
                            controller.setBirthDate(selected);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      _PickerField(
                        label: 'Exact Birth Time',
                        icon: Icons.schedule_rounded,
                        accent: const Color(0xFF57D7FF),
                        valueText: state.birthTime == null
                            ? 'Tap to select time'
                            : MaterialLocalizations.of(
                                context,
                              ).formatTimeOfDay(state.birthTime!),
                        onTap: () async {
                          final selected = await _pickTime(
                            context,
                            initialTime: state.birthTime,
                          );
                          if (selected != null) {
                            controller.setBirthTime(selected);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: controller.setBirthCity,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Birth City',
                          hintText: 'e.g., Seoul',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: controller.setBirthCountry,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Birth Country',
                          hintText: 'e.g., South Korea',
                        ),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: state.canCalculate
                            ? controller.calculate
                            : null,
                        child: const Text('Calculate My Saju ✨'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Uses Four Pillars stem/branch cycles and Five Elements weighting.',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  GlassPanel(
                    child: Text(
                      state.errorMessage!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFFFC9D9),
                      ),
                    ),
                  ),
                ],
                if (state.profile != null) ...[
                  const SizedBox(height: 14),
                  _PillarsCard(profile: state.profile!),
                  const SizedBox(height: 12),
                  _ElementsCard(profile: state.profile!),
                  const SizedBox(height: 12),
                  _InterpretationCard(profile: state.profile!),
                  const SizedBox(height: 12),
                  _DeepDiveCard(profile: state.profile!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context, {DateTime? initialDate}) {
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
      initialDate: initialDate ?? DateTime(2000, 1, 1),
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context, {TimeOfDay? initialTime}) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? const TimeOfDay(hour: 12, minute: 0),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.icon,
    required this.accent,
    required this.valueText,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color accent;
  final String valueText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    valueText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down_rounded, color: accent),
          ],
        ),
      ),
    );
  }
}

class _PillarsCard extends StatelessWidget {
  const _PillarsCard({required this.profile});

  final SajuProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Four Pillars (사주팔자)', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: profile.pillars.map((pillar) {
              return Container(
                width: 155,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pillar.label,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pillar.hanja,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(pillar.korean, style: textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${pillar.animal} • ${pillar.stemElement}/${pillar.branchElement}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Text(
            '${profile.birthCity}, ${profile.birthCountry} • ${profile.timeZone}',
            style: textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ElementsCard extends StatelessWidget {
  const _ElementsCard({required this.profile});

  final SajuProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final maxValue = profile.elementCounts.values.fold<int>(
      1,
      (previousValue, element) =>
          element > previousValue ? element : previousValue,
    );
    final weakLabel = profile.weakElements
        .map((value) => _elementKorean[value] ?? value)
        .join(', ');

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Five Elements Balance (오행)', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          ..._elementOrder.map((element) {
            final value = profile.elementCounts[element] ?? 0;
            final progress = value / maxValue;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(_elementKorean[element] ?? element),
                      const Spacer(),
                      Text('$value'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 9,
                      value: progress,
                      backgroundColor: Colors.white.withValues(alpha: 0.13),
                      valueColor: AlwaysStoppedAnimation(
                        _elementColors[element] ?? const Color(0xFF8B7CFF),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 2),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: Text(
                  'Dominant: ${_elementKorean[profile.dominantElement] ?? profile.dominantElement}',
                ),
              ),
              Chip(label: Text('Balance Focus: $weakLabel')),
            ],
          ),
        ],
      ),
    );
  }
}

class _InterpretationCard extends StatelessWidget {
  const _InterpretationCard({required this.profile});

  final SajuProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Destiny Energy Interpretation', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            profile.energySummary,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            profile.destinyInterpretation,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            profile.englishOverview,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE8EEFF),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text('Personalized Advice', style: textTheme.titleMedium),
          const SizedBox(height: 6),
          ...profile.personalizedAdvice.map((tip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.auto_awesome, size: 14),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: profile.notes.map((note) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '• $note',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeepDiveCard extends StatelessWidget {
  const _DeepDiveCard({required this.profile});

  final SajuProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('English Deep Dive (Detailed)', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          Text(
            'Pillar-by-pillar and element-by-element reading in English.',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Text('Pillar-by-Pillar Insight', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          ...profile.pillarInsights.map((insight) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.label,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 2),
                  Text(insight.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    insight.englishBlend,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    insight.summary,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...insight.strengths.map((line) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '• $line',
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFE5ECFF),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Text(
                    'Growth focus: ${insight.growthTip}',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFF1F5FF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          Text('Element-by-Element Reading', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          ...profile.elementInsights.map((insight) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        insight.korean,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Score ${insight.score} • ${insight.status}',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(insight.title, style: textTheme.bodyLarge),
                  const SizedBox(height: 6),
                  _detailLine('Summary', insight.summary, textTheme),
                  _detailLine('Strength', insight.strengths, textTheme),
                  _detailLine('When low', insight.lowState, textTheme),
                  _detailLine('Habits', insight.habitFocus, textTheme),
                  _detailLine(
                    'Relationship',
                    insight.relationshipTip,
                    textTheme,
                  ),
                  _detailLine('Career', insight.careerTip, textTheme),
                  _detailLine(
                    'Balance action',
                    insight.balanceAction,
                    textTheme,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _detailLine(String label, String body, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodySmall?.copyWith(color: Colors.white70),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Color(0xFFF2F6FF),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: body),
          ],
        ),
      ),
    );
  }
}

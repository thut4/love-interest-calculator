import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../providers/palm_reading_providers.dart';

class PalmReadingScreen extends ConsumerWidget {
  const PalmReadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(palmReadingControllerProvider);
    final controller = ref.read(palmReadingControllerProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Palm Reading'),
        backgroundColor: Colors.transparent,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share your palm photo',
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload a clear photo of your palm. If the image is not a palm, the reading will be skipped.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _ImagePanel(image: state.image),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: state.isLoading
                            ? null
                            : () async {
                                final file = await _pickImage(
                                  source: ImageSource.camera,
                                );
                                await controller.setImage(file);
                              },
                        icon: const Icon(Icons.photo_camera_outlined),
                        label: const Text('Camera'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: state.isLoading
                            ? null
                            : () async {
                                final file = await _pickImage(
                                  source: ImageSource.gallery,
                                );
                                await controller.setImage(file);
                              },
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('Gallery'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: state.isLoading || state.image == null
                      ? null
                      : controller.readPalm,
                  child: state.isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Read My Palm'),
                ),
                if (state.error != null) ...[
                  const SizedBox(height: 12),
                  _StatusPanel(
                    title: 'Palm reading issue',
                    message: state.error!,
                    accent: const Color(0xFFFF7A7A),
                  ),
                ],
                if (state.error != null && state.rawJson != null) ...[
                  const SizedBox(height: 12),
                  _RawResponsePanel(raw: state.rawJson!),
                ],
                if (state.hasResult) ...[
                  const SizedBox(height: 12),
                  _ReadingPanel(result: state.result!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<XFile?> _pickImage({required ImageSource source}) {
    return ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1600,
    );
  }

}

class _ImagePanel extends StatelessWidget {
  const _ImagePanel({required this.image});

  final XFile? image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (image == null) {
      return GlassPanel(
        child: Column(
          children: [
            const Icon(Icons.pan_tool_alt_outlined, size: 48),
            const SizedBox(height: 10),
            Text('No palm photo yet', style: textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Pick a clear image with visible lines.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    return GlassPanel(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(image!.path),
          height: 240,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.title,
    required this.message,
    required this.accent,
  });

  final String title;
  final String message;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium?.copyWith(color: accent)),
          const SizedBox(height: 6),
          Text(
            message,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ReadingPanel extends StatelessWidget {
  const _ReadingPanel({required this.result});

  final Map<String, dynamic> result;

  @override
  Widget build(BuildContext context) {
    if (_hasStructuredSchema(result)) {
      return _StructuredReadingView(result: result);
    }

    final textTheme = Theme.of(context).textTheme;
    final sections = _buildSections(result);

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your palm reading', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          ...sections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (section.title.isNotEmpty) ...[
                    Text(
                      section.title,
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    section.body,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.84),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasStructuredSchema(Map<String, dynamic> data) {
    return data.containsKey('overall_energy') &&
        data.containsKey('hand_type') &&
        data.containsKey('life_areas');
  }

  List<_ReadingSection> _buildSections(Map<String, dynamic> data) {
    // Handle "awaiting_image" style responses gracefully.
    final status = _string(data['status']).toLowerCase();
    if (status == 'awaiting_image') {
      final message = _string(data['message']);
      final philosophy = data['philosophy'];
      final expected = data['expected_structure'];
      final items = StringBuffer();
      if (message.isNotEmpty) items.writeln(message);
      if (philosophy is Map<String, dynamic>) {
        items.writeln();
        items.writeln('Influences:');
        philosophy.forEach((k, v) {
          final line = '${_labelize(k)}: ${_string(v)}'.trim();
          if (line.isNotEmpty) items.writeln('- $line');
        });
      }
      if (expected is Map<String, dynamic>) {
        items.writeln();
        items.writeln('What I will share:');
        expected.forEach((k, v) {
          final line = '${_labelize(k)}: ${_string(v)}'.trim();
          if (line.isNotEmpty) items.writeln('- $line');
        });
      }
      return [
        _ReadingSection(
          title: 'Ready for your palm',
          body: items.toString().trim(),
        ),
      ];
    }

    // Custom formatter for the provided palm reading schema (aura_and_elements, etc.)
    final hasAura = data.containsKey('aura_and_elements');
    final hasLines = data.containsKey('the_vitality_arc') ||
        data.containsKey('the_emotional_tides') ||
        data.containsKey('the_path_of_wisdom') ||
        data.containsKey('the_destiny_current');
    final hasMounts = data.containsKey('planetary_mounts');
    if (hasAura || hasLines || hasMounts) {
      final sections = <_ReadingSection>[];

      final aura = data['aura_and_elements'];
      if (aura is Map<String, dynamic>) {
        final element = _string(aura['elemental_type']);
        final desc = _string(aura['description']);
        final body = [if (element.isNotEmpty) element, if (desc.isNotEmpty) desc]
            .join('\n');
        if (body.isNotEmpty) {
          sections.add(_ReadingSection(title: 'Aura & Elements', body: body));
        }
      }

      void addLine(String key, String title) {
        final item = data[key];
        if (item is! Map<String, dynamic>) return;
        final quality = _string(item['line_quality']);
        final reading = _string(item['reading']);
        final body = [
          if (quality.isNotEmpty) 'Quality: $quality',
          if (reading.isNotEmpty) reading,
        ].join('\n');
        if (body.isNotEmpty) {
          sections.add(_ReadingSection(title: title, body: body));
        }
      }

      addLine('the_vitality_arc', 'Life line');
      addLine('the_emotional_tides', 'Heart line');
      addLine('the_path_of_wisdom', 'Head line');
      addLine('the_destiny_current', 'Fate line');

      final mounts = data['planetary_mounts'];
      if (mounts is Map<String, dynamic>) {
        final prominent = _string(mounts['prominent_mounts']);
        final reading = _string(mounts['reading']);
        final body = [
          if (prominent.isNotEmpty) 'Prominent: $prominent',
          if (reading.isNotEmpty) reading,
        ].join('\n');
        if (body.isNotEmpty) {
          sections.add(_ReadingSection(title: 'Planetary mounts', body: body));
        }
      }

      final synthesis = data['mystical_synthesis'];
      if (synthesis is Map<String, dynamic>) {
        final guidance = _string(synthesis['guidance']);
        if (guidance.isNotEmpty) {
          sections.add(
            _ReadingSection(title: 'Mystical synthesis', body: guidance),
          );
        }
      }

      if (sections.isNotEmpty) return sections;
    }

    // Fallback: generic flatten of any JSON map into readable text.
    final sections = <_ReadingSection>[];

    data.forEach((key, value) {
      final title = _labelize(key);
      final body = _formatValue(value);
      if (body.isNotEmpty) {
        sections.add(_ReadingSection(title: title, body: body));
      }
    });

    return sections;
  }

  String _string(dynamic value) {
    if (value == null) return '';
    final text = value.toString().trim();
    return text;
  }

  String _labelize(String key) {
    if (key.isEmpty) return key;
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map((part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}')
        .join(' ');
  }

  String _formatValue(dynamic value, {int depth = 0}) {
    if (value == null) return '';
    if (value is String) return value.trim();
    if (value is num || value is bool) return value.toString();
    if (value is List) {
      final items = value
          .map((v) => _formatValue(v, depth: depth + 1))
          .where((t) => t.isNotEmpty)
          .toList();
      return items.isEmpty ? '' : items.map((e) => '- $e').join('\n');
    }
    if (value is Map) {
      final buffer = StringBuffer();
      value.forEach((k, v) {
        final line = _formatValue(v, depth: depth + 1);
        if (line.isNotEmpty) {
          buffer.writeln('${_labelize(k)}: $line');
        }
      });
      return buffer.toString().trim();
    }
    return value.toString();
  }
}

class _StructuredReadingView extends StatelessWidget {
  const _StructuredReadingView({required this.result});

  final Map<String, dynamic> result;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final handType = result['hand_type'] is Map<String, dynamic>
        ? result['hand_type'] as Map<String, dynamic>
        : const <String, dynamic>{};
    final lines = result['lines'] is List
        ? (result['lines'] as List).whereType<Map<String, dynamic>>().toList()
        : const <Map<String, dynamic>>[];
    final mounts = result['mounts'] is List
        ? (result['mounts'] as List).whereType<Map<String, dynamic>>().toList()
        : const <Map<String, dynamic>>[];
    final lifeAreas = result['life_areas'] is Map<String, dynamic>
        ? result['life_areas'] as Map<String, dynamic>
        : const <String, dynamic>{};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AuraHeroCard(
          energy: _string(result['overall_energy']),
          element: _string(handType['element']),
          handDescription: _string(handType['description']),
        ),
        const SizedBox(height: 14),
        if (lines.isNotEmpty) ...[
          _SectionHeader(
            title: 'Major Lines',
            subtitle: 'The strongest paths etched across your palm',
          ),
          const SizedBox(height: 10),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InsightCard(
                title: _string(line['name']),
                badge: _string(line['trait']),
                meta: _string(line['visibility']),
                body: _string(line['reading']),
                accent: _lineAccent(_string(line['name'])),
                icon: _lineIcon(_string(line['name'])),
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
        if (mounts.isNotEmpty) ...[
          _SectionHeader(
            title: 'Planetary Mounts',
            subtitle: 'The quiet strengths gathered beneath the skin',
          ),
          const SizedBox(height: 10),
          ...mounts.map(
            (mount) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InsightCard(
                title: _string(mount['name']),
                badge: _string(mount['prominence']),
                body: _string(mount['reading']),
                accent: const Color(0xFFFFA56E),
                icon: Icons.auto_awesome_rounded,
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
        if (lifeAreas.isNotEmpty) ...[
          _SectionHeader(
            title: 'Life Areas',
            subtitle: 'Where this reading meets daily life',
          ),
          const SizedBox(height: 10),
          _LifeAreaGrid(lifeAreas: lifeAreas),
          const SizedBox(height: 14),
        ],
        if (_string(result['special_markings']).isNotEmpty) ...[
          _HighlightCard(
            title: 'Special Markings',
            body: _string(result['special_markings']),
            accent: const Color(0xFF57D7FF),
            icon: Icons.stars_rounded,
          ),
          const SizedBox(height: 12),
        ],
        if (_string(result['closing_message']).isNotEmpty) ...[
          _HighlightCard(
            title: 'Closing Message',
            body: _string(result['closing_message']),
            accent: const Color(0xFFFF7AB6),
            icon: Icons.favorite_rounded,
            emphasize: true,
          ),
          const SizedBox(height: 12),
        ],
        if (_string(result['confidence_note']).isNotEmpty)
          GlassPanel(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.shield_moon_outlined,
                  color: Colors.white.withValues(alpha: 0.74),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _string(result['confidence_note']),
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static String _string(dynamic value) => value?.toString().trim() ?? '';

  static Color _lineAccent(String name) {
    switch (name.toLowerCase()) {
      case 'heart line':
        return const Color(0xFFFF7AB6);
      case 'head line':
        return const Color(0xFF57D7FF);
      case 'life line':
        return const Color(0xFF8DFFCC);
      case 'fate line':
        return const Color(0xFFFFC56E);
      default:
        return const Color(0xFF8B7CFF);
    }
  }

  static IconData _lineIcon(String name) {
    switch (name.toLowerCase()) {
      case 'heart line':
        return Icons.favorite_border_rounded;
      case 'head line':
        return Icons.psychology_alt_outlined;
      case 'life line':
        return Icons.spa_outlined;
      case 'fate line':
        return Icons.explore_outlined;
      default:
        return Icons.timeline_rounded;
    }
  }
}

class _AuraHeroCard extends StatelessWidget {
  const _AuraHeroCard({
    required this.energy,
    required this.element,
    required this.handDescription,
  });

  final String energy;
  final String element;
  final String handDescription;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF7AB6).withValues(alpha: 0.22),
              const Color(0xFF8B7CFF).withValues(alpha: 0.18),
              const Color(0xFF57D7FF).withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.22),
                      ),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aura Reading',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (element.isNotEmpty)
                          Text(
                            element,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.78),
                              letterSpacing: 0.4,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                energy,
                style: textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (handDescription.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.black.withValues(alpha: 0.16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Text(
                    handDescription,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.68),
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.title,
    required this.body,
    required this.accent,
    required this.icon,
    this.badge = '',
    this.meta = '',
  });

  final String title;
  final String body;
  final Color accent;
  final IconData icon;
  final String badge;
  final String meta;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.18),
              Colors.white.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: accent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: textTheme.titleMedium),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (meta.isNotEmpty) _MiniTag(label: meta, color: accent),
                            if (badge.isNotEmpty)
                              _MiniTag(
                                label: badge,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                body,
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Colors.white.withValues(alpha: 0.84),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  const _MiniTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _LifeAreaGrid extends StatelessWidget {
  const _LifeAreaGrid({required this.lifeAreas});

  final Map<String, dynamic> lifeAreas;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: 'Love',
        body: lifeAreas['love']?.toString().trim() ?? '',
        color: const Color(0xFFFF7AB6),
        icon: Icons.favorite_border_rounded,
      ),
      (
        title: 'Career',
        body: lifeAreas['career']?.toString().trim() ?? '',
        color: const Color(0xFF57D7FF),
        icon: Icons.work_outline_rounded,
      ),
      (
        title: 'Health',
        body: lifeAreas['health']?.toString().trim() ?? '',
        color: const Color(0xFF8DFFCC),
        icon: Icons.self_improvement_rounded,
      ),
      (
        title: 'Destiny',
        body: lifeAreas['destiny']?.toString().trim() ?? '',
        color: const Color(0xFFFFC56E),
        icon: Icons.nightlight_round,
      ),
    ].where((item) => item.body.isNotEmpty).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 560;
        final width = wide
            ? (constraints.maxWidth - 12) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items
              .map(
                (item) => SizedBox(
                  width: width,
                  child: _HighlightCard(
                    title: item.title,
                    body: item.body,
                    accent: item.color,
                    icon: item.icon,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.title,
    required this.body,
    required this.accent,
    required this.icon,
    this.emphasize = false,
  });

  final String title;
  final String body;
  final Color accent;
  final IconData icon;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: emphasize ? 0.22 : 0.15),
              Colors.white.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: accent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: emphasize ? Colors.white : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                body,
                style: textTheme.bodyMedium?.copyWith(
                  height: emphasize ? 1.6 : 1.5,
                  fontSize: emphasize ? 15 : 14,
                  color: Colors.white.withValues(alpha: emphasize ? 0.92 : 0.84),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RawResponsePanel extends StatelessWidget {
  const _RawResponsePanel({required this.raw});

  final String raw;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Raw response', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          SelectableText(
            raw,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadingSection {
  const _ReadingSection({required this.title, required this.body});

  final String title;
  final String body;
}

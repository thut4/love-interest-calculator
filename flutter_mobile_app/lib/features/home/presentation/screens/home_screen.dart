import 'package:flutter/material.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../love_interest/presentation/screens/love_quiz_screen.dart';
import '../../../palm_reading/presentation/screens/palm_reading_screen.dart';
import '../../../zodiac/presentation/screens/zodiac_compatibility_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Love & Zodiac Studio', style: textTheme.headlineMedium),
                const SizedBox(height: 10),
                Text(
                  'Playful insights for romance signals and zodiac compatibility.',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _FeatureCard(
                        emoji: '💘',
                        title: 'Love Interest Analyzer',
                        description:
                            'Answer quick behavior-based questions and get a score, red flags, and next move advice.',
                        accent: const Color(0xFFFF7AB6),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LoveQuizScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _FeatureCard(
                        emoji: '🌙',
                        title: 'Zodiac Compatibility',
                        description:
                            'Enter two exact dates of birth to reveal both signs and a modern compatibility summary.',
                        accent: const Color(0xFF57D7FF),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ZodiacCompatibilityScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _FeatureCard(
                        emoji: '🖐️',
                        title: 'Palm Reading',
                        description:
                            'Upload a clear palm photo and receive a warm, mystical reading powered by Gemini.',
                        accent: const Color(0xFF8B7CFF),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PalmReadingScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      GlassPanel(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('✨', style: TextStyle(fontSize: 22)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'For entertainment and self-reflection. Trust your values, communication, and boundaries most.',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.84),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.accent,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(title, style: textTheme.titleLarge)),
                  Icon(Icons.arrow_forward_rounded, color: accent),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.25)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

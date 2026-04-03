# Flutter Mobile App

Playful mobile companion app for this project, built with:

- Flutter
- Riverpod (`flutter_riverpod`)
- Feature-first clean architecture (`domain`, `data`, `presentation`)

## Features

1. Love Interest Analyzer
- Multi-step quiz
- Score + level + confidence explanation
- Red flags and next-move actions

2. Zodiac Compatibility
- Two exact DoB selectors
- Sun sign resolution for both people
- Compatibility score, level, chemistry/challenge insights
- Sign-level behaviors and habits

3. Saju Five Elements Profile
- Full birth date + exact birth time + birth city/country inputs
- Four Pillars (사주팔자) calculation
- Korean Five Elements (오행) balance with dominant/weak energy
- Destiny energy interpretation and personalized advice

## Architecture

`lib/` is organized by feature and layers:

- `core/`
  - Shared theme and UI building blocks (`GlassPanel`, `CosmicBackground`)
- `features/home/`
  - Entry screen with navigation cards
- `features/love_interest/`
  - `domain`: entities, repository contract, use case
  - `data`: repository implementation + scoring logic
  - `presentation`: Riverpod providers, state/controller, quiz/result screen
- `features/zodiac/`
  - `domain`: entities, repository contract, use case
  - `data`: sign data + compatibility logic
  - `presentation`: Riverpod providers, state/controller, compatibility screen
- `features/saju/`
  - `domain`: Saju entities, repository contract, use case
  - `data`: stem/branch cycles, pillar calculation, elements/advice logic
  - `presentation`: Riverpod providers, state/controller, Saju profile screen

## Run

```bash
cd flutter_mobile_app
flutter pub get
flutter run
```

## Quality Checks

```bash
flutter analyze
flutter test
```

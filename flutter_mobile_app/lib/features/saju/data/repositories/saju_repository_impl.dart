import '../../domain/entities/saju_profile.dart';
import '../../domain/repositories/saju_repository.dart';

class SajuRepositoryImpl implements SajuRepository {
  static const List<String> _elementOrder = [
    'Wood',
    'Fire',
    'Earth',
    'Metal',
    'Water',
  ];

  static const Map<String, String> _elementKorean = {
    'Wood': '목(木)',
    'Fire': '화(火)',
    'Earth': '토(土)',
    'Metal': '금(金)',
    'Water': '수(水)',
  };

  static const List<_Stem> _stems = [
    _Stem(hanja: '甲', korean: '갑', element: 'Wood'),
    _Stem(hanja: '乙', korean: '을', element: 'Wood'),
    _Stem(hanja: '丙', korean: '병', element: 'Fire'),
    _Stem(hanja: '丁', korean: '정', element: 'Fire'),
    _Stem(hanja: '戊', korean: '무', element: 'Earth'),
    _Stem(hanja: '己', korean: '기', element: 'Earth'),
    _Stem(hanja: '庚', korean: '경', element: 'Metal'),
    _Stem(hanja: '辛', korean: '신', element: 'Metal'),
    _Stem(hanja: '壬', korean: '임', element: 'Water'),
    _Stem(hanja: '癸', korean: '계', element: 'Water'),
  ];

  static const List<_Branch> _branches = [
    _Branch(hanja: '子', korean: '자', animal: 'Rat', element: 'Water'),
    _Branch(hanja: '丑', korean: '축', animal: 'Ox', element: 'Earth'),
    _Branch(hanja: '寅', korean: '인', animal: 'Tiger', element: 'Wood'),
    _Branch(hanja: '卯', korean: '묘', animal: 'Rabbit', element: 'Wood'),
    _Branch(hanja: '辰', korean: '진', animal: 'Dragon', element: 'Earth'),
    _Branch(hanja: '巳', korean: '사', animal: 'Snake', element: 'Fire'),
    _Branch(hanja: '午', korean: '오', animal: 'Horse', element: 'Fire'),
    _Branch(hanja: '未', korean: '미', animal: 'Goat', element: 'Earth'),
    _Branch(hanja: '申', korean: '신', animal: 'Monkey', element: 'Metal'),
    _Branch(hanja: '酉', korean: '유', animal: 'Rooster', element: 'Metal'),
    _Branch(hanja: '戌', korean: '술', animal: 'Dog', element: 'Earth'),
    _Branch(hanja: '亥', korean: '해', animal: 'Pig', element: 'Water'),
  ];

  static const Map<String, String> _destinyInterpretations = {
    'Wood':
        'Your destiny energy grows through expansion, learning, and purpose. Build long-view momentum.',
    'Fire':
        'Your destiny energy shines through expression and inspiration. Lead with warmth, avoid burnout.',
    'Earth':
        'Your destiny energy stabilizes through consistency and trust. Ground your goals in routine.',
    'Metal':
        'Your destiny energy refines through structure and boundaries. Precision creates timing luck.',
    'Water':
        'Your destiny energy flows through intuition and adaptability. Reflection keeps your direction clear.',
  };

  static const Map<String, List<String>> _elementAdvice = {
    'Wood': [
      'Add weekly growth rituals: studying, mentoring, and long-term planning.',
      'Review goals monthly so momentum stays aligned with purpose.',
    ],
    'Fire': [
      'Use creative expression to release emotional heat and renew motivation.',
      'Protect rest after high-output periods to prevent burnout.',
    ],
    'Earth': [
      'Anchor your energy with stable routines for sleep, food, and movement.',
      'Choose consistent environments that support emotional safety.',
    ],
    'Metal': [
      'Sharpen boundaries around time, attention, and commitments.',
      'Simplify decisions with a clear yes/no standard.',
    ],
    'Water': [
      'Create quiet reflection time to strengthen intuition.',
      'Balance flexibility with one non-negotiable grounding habit.',
    ],
  };

  static const Map<String, _PillarDiveSeed> _pillarDeepDive = {
    'Year Pillar': _PillarDiveSeed(
      title: 'Outer Destiny and Early Environment',
      summary:
          'Year Pillar describes inherited energy, social identity, and the tone of your early life foundation.',
      strengths: [
        'Shows the type of circles and environments where your luck opens fastest.',
        'Reveals natural social style and how others first read your energy.',
      ],
      growthTip:
          'Strengthen your Year Pillar by choosing communities that match your values, not only your ambitions.',
    ),
    'Month Pillar': _PillarDiveSeed(
      title: 'Career Rhythm and Productive Energy',
      summary:
          'Month Pillar reflects work style, discipline, and the energetic climate of your prime growth years.',
      strengths: [
        'Highlights where your effort compounds most in study, career, and skill-building.',
        'Shows how to pace effort so success is sustainable instead of exhausting.',
      ],
      growthTip:
          'Build a repeatable weekly structure. Consistent rhythm stabilizes long-term fortune.',
    ),
    'Day Pillar': _PillarDiveSeed(
      title: 'Core Self and Relationship Pattern',
      summary:
          'Day Pillar is the heart of the chart, tied to identity, emotional needs, and one-to-one partnership patterns.',
      strengths: [
        'Points to your authentic emotional style and trust language.',
        'Reveals the qualities you need in close relationships for mutual growth.',
      ],
      growthTip:
          'Use direct emotional communication. Clear needs create better partnership timing.',
    ),
    'Hour Pillar': _PillarDiveSeed(
      title: 'Future Vision and Inner Creative Potential',
      summary:
          'Hour Pillar represents long-range dreams, private motivations, and the legacy energy you cultivate over time.',
      strengths: [
        'Shows your hidden strengths that mature later in life.',
        'Indicates how your intuition and future planning should work together.',
      ],
      growthTip:
          'Protect deep-focus time. Quiet refinement unlocks your most meaningful outcomes.',
    ),
  };

  static const Map<String, _ElementDiveSeed> _elementDeepDive = {
    'Wood': _ElementDiveSeed(
      title: 'Growth Driver',
      essence: 'Expansion, strategy, creativity, and long-view direction.',
      strengths: 'You build momentum through learning, vision, and initiative.',
      lowState:
          'When low, direction feels unclear and growth stalls into hesitation.',
      habitFocus:
          'Plan in seasons: one major growth goal each quarter with weekly checkpoints.',
      relationshipTip:
          'Share future plans with loved ones so your growth path feels collaborative.',
      careerTip:
          'Roles involving planning, coaching, product building, or innovation fit Wood energy.',
      balanceAction:
          'Add movement in nature and journaling to refresh perspective.',
    ),
    'Fire': _ElementDiveSeed(
      title: 'Expression Driver',
      essence: 'Visibility, charisma, passion, and emotional animation.',
      strengths:
          'You inspire others through presence, warmth, and expressive leadership.',
      lowState: 'When low, motivation drops and self-expression gets muted.',
      habitFocus:
          'Use daily creative release: voice notes, writing, art, or speaking practice.',
      relationshipTip:
          'Celebrate small wins openly; appreciation keeps emotional intimacy alive.',
      careerTip:
          'Fire thrives in roles with performance, storytelling, leadership, or public influence.',
      balanceAction: 'Protect sleep and recovery so passion stays sustainable.',
    ),
    'Earth': _ElementDiveSeed(
      title: 'Stability Driver',
      essence: 'Grounding, trust, responsibility, and practical care.',
      strengths:
          'You create safety through consistency, reliability, and calm decision-making.',
      lowState:
          'When low, routines become unstable and stress spreads across priorities.',
      habitFocus:
          'Anchor your day with fixed wake/sleep windows and meal timing.',
      relationshipTip:
          'Offer and request clear commitments. Earth energy bonds through reliability.',
      careerTip:
          'Operations, management, counseling, and long-cycle projects fit Earth well.',
      balanceAction:
          'Simplify schedule overload and return to one stable baseline routine.',
    ),
    'Metal': _ElementDiveSeed(
      title: 'Precision Driver',
      essence: 'Structure, standards, boundaries, and refined judgment.',
      strengths:
          'You excel by filtering noise and focusing on what truly matters.',
      lowState:
          'When low, boundaries blur and choices become scattered or delayed.',
      habitFocus:
          'Run a weekly declutter ritual for calendar, inbox, and commitments.',
      relationshipTip:
          'Practice respectful boundaries early; clarity protects harmony.',
      careerTip:
          'Metal energy suits analysis, finance, strategy, compliance, and systems design.',
      balanceAction: 'Use clear decision frameworks and stop overcommitting.',
    ),
    'Water': _ElementDiveSeed(
      title: 'Wisdom Driver',
      essence: 'Intuition, adaptability, depth, and reflective intelligence.',
      strengths:
          'You sense subtle patterns and navigate change with flexibility.',
      lowState:
          'When low, emotional fog and indecision can replace intuitive clarity.',
      habitFocus:
          'Schedule quiet reflection blocks for thinking, prayer, or meditation.',
      relationshipTip:
          'Share feelings before they overflow; vulnerability turns depth into connection.',
      careerTip:
          'Water supports research, design, healing, strategy, and adaptive leadership.',
      balanceAction:
          'Pair reflection with one concrete daily action to stay grounded.',
    ),
  };

  static const Map<String, String> _cityTimezoneOverrides = {
    'seoul': 'Asia/Seoul',
    'busan': 'Asia/Seoul',
    'tokyo': 'Asia/Tokyo',
    'osaka': 'Asia/Tokyo',
    'beijing': 'Asia/Shanghai',
    'shanghai': 'Asia/Shanghai',
    'singapore': 'Asia/Singapore',
    'bangkok': 'Asia/Bangkok',
    'yangon': 'Asia/Yangon',
    'mumbai': 'Asia/Kolkata',
    'delhi': 'Asia/Kolkata',
    'london': 'Europe/London',
    'paris': 'Europe/Paris',
    'berlin': 'Europe/Berlin',
    'sydney': 'Australia/Sydney',
    'melbourne': 'Australia/Melbourne',
    'newyork': 'America/New_York',
    'losangeles': 'America/Los_Angeles',
    'chicago': 'America/Chicago',
    'toronto': 'America/Toronto',
    'vancouver': 'America/Vancouver',
  };

  static const Map<String, String> _countryDefaultTimezone = {
    'south korea': 'Asia/Seoul',
    'korea': 'Asia/Seoul',
    'japan': 'Asia/Tokyo',
    'china': 'Asia/Shanghai',
    'singapore': 'Asia/Singapore',
    'thailand': 'Asia/Bangkok',
    'myanmar': 'Asia/Yangon',
    'india': 'Asia/Kolkata',
    'uk': 'Europe/London',
    'united kingdom': 'Europe/London',
    'france': 'Europe/Paris',
    'germany': 'Europe/Berlin',
    'australia': 'Australia/Sydney',
    'usa': 'America/New_York',
    'united states': 'America/New_York',
    'canada': 'America/Toronto',
  };

  static final DateTime _baseJiaZi = DateTime.utc(1984, 2, 2);

  @override
  SajuProfile calculateProfile({
    required DateTime birthDate,
    required int birthHour,
    required int birthMinute,
    required String birthCity,
    required String birthCountry,
  }) {
    final year = birthDate.year;
    final month = birthDate.month;
    final day = birthDate.day;

    final timeZone = _inferTimeZone(birthCity, birthCountry);

    final adjustedYear = _adjustedYear(year, month, day);
    final yearStemIndex = _mod(adjustedYear - 4, 10);
    final yearBranchIndex = _mod(adjustedYear - 4, 12);

    final monthBranchIndex = _seasonalMonthBranchIndex(month, day);
    final firstMonthStemIndex = _mod(((yearStemIndex % 5) * 2) + 2, 10);
    final monthOffset = _mod(monthBranchIndex - 2, 12);
    final monthStemIndex = _mod(firstMonthStemIndex + monthOffset, 10);

    final dayCycleIndex = _dayCycleIndex(year, month, day);
    final dayStemIndex = dayCycleIndex % 10;
    final dayBranchIndex = dayCycleIndex % 12;

    final hourBranchIndex = _hourBranchIndex(birthHour, birthMinute);
    final hourStemStart = _mod((dayStemIndex % 5) * 2, 10);
    final hourStemIndex = _mod(hourStemStart + hourBranchIndex, 10);

    final pillars = [
      _pillar('Year Pillar', yearStemIndex, yearBranchIndex),
      _pillar('Month Pillar', monthStemIndex, monthBranchIndex),
      _pillar('Day Pillar', dayStemIndex, dayBranchIndex),
      _pillar('Hour Pillar', hourStemIndex, hourBranchIndex),
    ];

    final elementCounts = _buildElementCounts(pillars);

    final sorted = [..._elementOrder]
      ..sort((a, b) => elementCounts[b]!.compareTo(elementCounts[a]!));

    final dominantElement = sorted.first;
    final maxValue = elementCounts[dominantElement]!;
    final minValue = elementCounts[sorted.last]!;
    final weakElements = sorted
        .where((item) => elementCounts[item] == minValue)
        .toList();

    final advice = _buildAdvice(dominantElement, weakElements);
    final pillarInsights = _buildPillarInsights(pillars);
    final elementInsights = _buildElementInsights(
      elementCounts: elementCounts,
      maxValue: maxValue,
      minValue: minValue,
    );
    final weakKorean = weakElements
        .map((item) => _elementKorean[item]!)
        .join(', ');

    return SajuProfile(
      birthCity: birthCity.trim(),
      birthCountry: birthCountry.trim(),
      timeZone: timeZone,
      pillars: pillars,
      elementCounts: elementCounts,
      dominantElement: dominantElement,
      weakElements: weakElements,
      energySummary:
          '${_elementKorean[dominantElement]} energy is strongest. Balance focus: $weakKorean.',
      englishOverview:
          'Your chart is led by $dominantElement energy. The key balancing lesson is ${weakElements.join(', ')} integration through daily habits.',
      destinyInterpretation: _destinyInterpretations[dominantElement]!,
      personalizedAdvice: advice,
      pillarInsights: pillarInsights,
      elementInsights: elementInsights,
      notes: const [
        'Month pillar is calculated with seasonal solar-term boundaries (입춘 기준) approximation.',
        'Birth city/country is used to infer timezone context for interpretation.',
      ],
    );
  }

  int _mod(int value, int divisor) {
    return ((value % divisor) + divisor) % divisor;
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[.,]'), '')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  String _normalizeCompact(String value) {
    return _normalize(value).replaceAll(' ', '');
  }

  String _inferTimeZone(String city, String country) {
    final cityNormalized = _normalize(city);
    final cityCompact = _normalizeCompact(city);
    final countryNormalized = _normalize(country);

    if (_cityTimezoneOverrides.containsKey(cityNormalized)) {
      return _cityTimezoneOverrides[cityNormalized]!;
    }
    if (_cityTimezoneOverrides.containsKey(cityCompact)) {
      return _cityTimezoneOverrides[cityCompact]!;
    }
    if (_countryDefaultTimezone.containsKey(countryNormalized)) {
      return _countryDefaultTimezone[countryNormalized]!;
    }

    return 'UTC';
  }

  int _seasonalMonthBranchIndex(int month, int day) {
    final mmdd = month * 100 + day;

    if (mmdd >= 1207 || mmdd <= 105) return 0;
    if (mmdd >= 106 && mmdd <= 203) return 1;
    if (mmdd >= 204 && mmdd <= 305) return 2;
    if (mmdd >= 306 && mmdd <= 404) return 3;
    if (mmdd >= 405 && mmdd <= 505) return 4;
    if (mmdd >= 506 && mmdd <= 605) return 5;
    if (mmdd >= 606 && mmdd <= 706) return 6;
    if (mmdd >= 707 && mmdd <= 807) return 7;
    if (mmdd >= 808 && mmdd <= 907) return 8;
    if (mmdd >= 908 && mmdd <= 1007) return 9;
    if (mmdd >= 1008 && mmdd <= 1106) return 10;
    return 11;
  }

  int _adjustedYear(int year, int month, int day) {
    if (month < 2) return year - 1;
    if (month == 2 && day < 4) return year - 1;
    return year;
  }

  int _dayCycleIndex(int year, int month, int day) {
    final target = DateTime.utc(year, month, day);
    final diff = target.difference(_baseJiaZi).inDays;
    return _mod(diff, 60);
  }

  int _hourBranchIndex(int hour, int minute) {
    final normalizedHour = hour + (minute / 60);
    final branchBucket = ((normalizedHour + 1) / 2).floor();
    return _mod(branchBucket, 12);
  }

  SajuPillar _pillar(String label, int stemIndex, int branchIndex) {
    final stem = _stems[stemIndex];
    final branch = _branches[branchIndex];

    return SajuPillar(
      label: label,
      hanja: '${stem.hanja}${branch.hanja}',
      korean: '${stem.korean}${branch.korean}',
      animal: branch.animal,
      stemElement: stem.element,
      branchElement: branch.element,
    );
  }

  Map<String, int> _buildElementCounts(List<SajuPillar> pillars) {
    final map = <String, int>{for (final item in _elementOrder) item: 0};

    for (final pillar in pillars) {
      map[pillar.stemElement] = map[pillar.stemElement]! + 2;
      map[pillar.branchElement] = map[pillar.branchElement]! + 1;
    }

    return map;
  }

  List<String> _buildAdvice(String dominantElement, List<String> weakElements) {
    final list = <String>[];

    list.add(
      'Your strongest energy is ${_elementKorean[dominantElement]}. Lean into its natural gifts with intention.',
    );

    final dominantTip = _elementAdvice[dominantElement]?.first;
    if (dominantTip != null) {
      list.add(dominantTip);
    }

    for (final element in weakElements) {
      final tip = _elementAdvice[element]?.first;
      if (tip != null) {
        list.add('Balance weak ${_elementKorean[element]} energy: $tip');
      }
    }

    list.add(
      'For Saju-based timing, review your progress monthly and adjust rhythms consistently.',
    );

    return list;
  }

  List<SajuPillarInsight> _buildPillarInsights(List<SajuPillar> pillars) {
    return pillars.map((pillar) {
      final base = _pillarDeepDive[pillar.label];

      return SajuPillarInsight(
        label: pillar.label,
        title: base?.title ?? 'Pillar Insight',
        summary:
            base?.summary ??
            'This pillar describes a meaningful life domain in your Saju chart.',
        strengths:
            base?.strengths ??
            const [
              'Shows where your natural momentum can open.',
              'Highlights a life area to refine with intention.',
            ],
        growthTip:
            base?.growthTip ??
            'Use this pillar consciously through routines and reflection.',
        englishBlend:
            '${pillar.stemElement} stem + ${pillar.branchElement} branch (${pillar.animal})',
      );
    }).toList();
  }

  List<SajuElementInsight> _buildElementInsights({
    required Map<String, int> elementCounts,
    required int maxValue,
    required int minValue,
  }) {
    return _elementOrder.map((element) {
      final score = elementCounts[element]!;
      final seed = _elementDeepDive[element]!;
      final status = _statusLabel(score, maxValue, minValue);

      final dynamicSummary = switch (status) {
        'Strong' =>
          '${seed.essence} This element currently leads your chart, so its gifts are easier to access.',
        'Low' =>
          '${seed.essence} This element is underrepresented, so conscious strengthening brings better balance.',
        _ =>
          '${seed.essence} This element is moderate, supporting flexible and stable expression.',
      };

      return SajuElementInsight(
        element: element,
        korean: _elementKorean[element]!,
        score: score,
        status: status,
        title: seed.title,
        summary: dynamicSummary,
        strengths: seed.strengths,
        lowState: seed.lowState,
        habitFocus: seed.habitFocus,
        relationshipTip: seed.relationshipTip,
        careerTip: seed.careerTip,
        balanceAction: seed.balanceAction,
      );
    }).toList();
  }

  String _statusLabel(int score, int maxValue, int minValue) {
    if (score == maxValue) return 'Strong';
    if (score == minValue) return 'Low';
    return 'Balanced';
  }
}

class _Stem {
  const _Stem({
    required this.hanja,
    required this.korean,
    required this.element,
  });

  final String hanja;
  final String korean;
  final String element;
}

class _Branch {
  const _Branch({
    required this.hanja,
    required this.korean,
    required this.animal,
    required this.element,
  });

  final String hanja;
  final String korean;
  final String animal;
  final String element;
}

class _PillarDiveSeed {
  const _PillarDiveSeed({
    required this.title,
    required this.summary,
    required this.strengths,
    required this.growthTip,
  });

  final String title;
  final String summary;
  final List<String> strengths;
  final String growthTip;
}

class _ElementDiveSeed {
  const _ElementDiveSeed({
    required this.title,
    required this.essence,
    required this.strengths,
    required this.lowState,
    required this.habitFocus,
    required this.relationshipTip,
    required this.careerTip,
    required this.balanceAction,
  });

  final String title;
  final String essence;
  final String strengths;
  final String lowState;
  final String habitFocus;
  final String relationshipTip;
  final String careerTip;
  final String balanceAction;
}

class SajuPillar {
  const SajuPillar({
    required this.label,
    required this.hanja,
    required this.korean,
    required this.animal,
    required this.stemElement,
    required this.branchElement,
  });

  final String label;
  final String hanja;
  final String korean;
  final String animal;
  final String stemElement;
  final String branchElement;
}

class SajuPillarInsight {
  const SajuPillarInsight({
    required this.label,
    required this.title,
    required this.summary,
    required this.strengths,
    required this.growthTip,
    required this.englishBlend,
  });

  final String label;
  final String title;
  final String summary;
  final List<String> strengths;
  final String growthTip;
  final String englishBlend;
}

class SajuElementInsight {
  const SajuElementInsight({
    required this.element,
    required this.korean,
    required this.score,
    required this.status,
    required this.title,
    required this.summary,
    required this.strengths,
    required this.lowState,
    required this.habitFocus,
    required this.relationshipTip,
    required this.careerTip,
    required this.balanceAction,
  });

  final String element;
  final String korean;
  final int score;
  final String status;
  final String title;
  final String summary;
  final String strengths;
  final String lowState;
  final String habitFocus;
  final String relationshipTip;
  final String careerTip;
  final String balanceAction;
}

class SajuProfile {
  const SajuProfile({
    required this.birthCity,
    required this.birthCountry,
    required this.timeZone,
    required this.pillars,
    required this.elementCounts,
    required this.dominantElement,
    required this.weakElements,
    required this.energySummary,
    required this.englishOverview,
    required this.destinyInterpretation,
    required this.personalizedAdvice,
    required this.pillarInsights,
    required this.elementInsights,
    required this.notes,
  });

  final String birthCity;
  final String birthCountry;
  final String timeZone;
  final List<SajuPillar> pillars;
  final Map<String, int> elementCounts;
  final String dominantElement;
  final List<String> weakElements;
  final String energySummary;
  final String englishOverview;
  final String destinyInterpretation;
  final List<String> personalizedAdvice;
  final List<SajuPillarInsight> pillarInsights;
  final List<SajuElementInsight> elementInsights;
  final List<String> notes;
}

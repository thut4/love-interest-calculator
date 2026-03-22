/**
 * Western tropical zodiac data + resolver helpers.
 * Date ranges are month/day based and intentionally ignore birth year.
 */
export const ZODIAC_SIGNS = [
  {
    id: 'aries',
    name: 'Aries',
    symbol: '♈',
    emoji: '🐏',
    dateRangeLabel: 'March 21 - April 19',
    start: { month: 3, day: 21 },
    end: { month: 4, day: 19 },
    element: 'Fire',
    modality: 'Cardinal',
    rulingPlanet: 'Mars',
    accent: '#ff6b6b',
    glow: 'rgba(255, 107, 107, 0.3)',
    behaviors: [
      'Bold, direct, and quick to take the lead when something exciting begins.',
      'Prefers action over overthinking and usually makes decisions fast.',
      'Shows affection through encouragement, honesty, and energetic support.',
    ],
    habits: [
      'Starts passion projects spontaneously when inspiration strikes.',
      'Keeps momentum with movement, challenges, and active routines.',
      'Learns quickly through trial, error, and immediate feedback.',
    ],
    cosmicTip: 'Aries thrives when goals feel fresh, brave, and a little competitive.',
  },
  {
    id: 'taurus',
    name: 'Taurus',
    symbol: '♉',
    emoji: '🐂',
    dateRangeLabel: 'April 20 - May 20',
    start: { month: 4, day: 20 },
    end: { month: 5, day: 20 },
    element: 'Earth',
    modality: 'Fixed',
    rulingPlanet: 'Venus',
    accent: '#63b26d',
    glow: 'rgba(99, 178, 109, 0.28)',
    behaviors: [
      'Grounded and steady, with a calm style that values consistency.',
      'Builds trust slowly and prefers reliable people, plans, and environments.',
      'Expresses care through loyalty, quality time, and practical support.',
    ],
    habits: [
      'Creates comforting routines around food, rest, and familiar spaces.',
      'Takes time before big changes and usually sticks with long-term choices.',
      'Invests patiently in goals that promise lasting stability.',
    ],
    cosmicTip: 'Taurus glows brightest in peaceful spaces with beautiful details.',
  },
  {
    id: 'gemini',
    name: 'Gemini',
    symbol: '♊',
    emoji: '🦋',
    dateRangeLabel: 'May 21 - June 20',
    start: { month: 5, day: 21 },
    end: { month: 6, day: 20 },
    element: 'Air',
    modality: 'Mutable',
    rulingPlanet: 'Mercury',
    accent: '#4dabf7',
    glow: 'rgba(77, 171, 247, 0.28)',
    behaviors: [
      'Curious, social, and mentally agile in fast-changing situations.',
      'Enjoys variety, playful conversation, and collecting new ideas.',
      'Connects with others by asking questions and sharing information.',
    ],
    habits: [
      'Multitasks naturally and rotates between interests throughout the day.',
      'Keeps notes, tabs, and chats active to stay mentally stimulated.',
      'Recharges through short adventures, learning, and social check-ins.',
    ],
    cosmicTip: 'Gemini stays happiest when life includes novelty and conversation.',
  },
  {
    id: 'cancer',
    name: 'Cancer',
    symbol: '♋',
    emoji: '🦀',
    dateRangeLabel: 'June 21 - July 22',
    start: { month: 6, day: 21 },
    end: { month: 7, day: 22 },
    element: 'Water',
    modality: 'Cardinal',
    rulingPlanet: 'Moon',
    accent: '#74c0fc',
    glow: 'rgba(116, 192, 252, 0.28)',
    behaviors: [
      'Emotionally intuitive and protective with people they care about.',
      'Notices subtle moods quickly and responds with empathy.',
      'Values emotional safety, trust, and meaningful bonds.',
    ],
    habits: [
      'Builds cozy routines around home, family, and comfort rituals.',
      'Processes feelings privately before opening up fully.',
      'Keeps sentimental memories, photos, and symbolic keepsakes.',
    ],
    cosmicTip: 'Cancer flourishes when heart, home, and boundaries feel secure.',
  },
  {
    id: 'leo',
    name: 'Leo',
    symbol: '♌',
    emoji: '🦁',
    dateRangeLabel: 'July 23 - August 22',
    start: { month: 7, day: 23 },
    end: { month: 8, day: 22 },
    element: 'Fire',
    modality: 'Fixed',
    rulingPlanet: 'Sun',
    accent: '#ff922b',
    glow: 'rgba(255, 146, 43, 0.3)',
    behaviors: [
      'Warm, expressive, and naturally drawn to creative self-expression.',
      'Brings confidence and heart to group settings and shared goals.',
      'Shows affection generously and appreciates genuine appreciation back.',
    ],
    habits: [
      'Turns ordinary moments into celebrations with style and flair.',
      'Protects loved ones fiercely and takes pride in uplifting friends.',
      'Performs best when recognized for effort and authenticity.',
    ],
    cosmicTip: 'Leo shines most when creativity and confidence are both welcomed.',
  },
  {
    id: 'virgo',
    name: 'Virgo',
    symbol: '♍',
    emoji: '🌾',
    dateRangeLabel: 'August 23 - September 22',
    start: { month: 8, day: 23 },
    end: { month: 9, day: 22 },
    element: 'Earth',
    modality: 'Mutable',
    rulingPlanet: 'Mercury',
    accent: '#66c2a5',
    glow: 'rgba(102, 194, 165, 0.28)',
    behaviors: [
      'Detail-oriented, thoughtful, and motivated by practical improvement.',
      'Observes patterns quickly and notices what needs refining.',
      'Shows care through service, consistency, and thoughtful planning.',
    ],
    habits: [
      'Builds checklists, systems, and healthy routines for daily life.',
      'Researches deeply before making decisions or commitments.',
      'Relaxes best when surroundings feel organized and functional.',
    ],
    cosmicTip: 'Virgo feels best when life is intentional, useful, and well-paced.',
  },
  {
    id: 'libra',
    name: 'Libra',
    symbol: '♎',
    emoji: '⚖️',
    dateRangeLabel: 'September 23 - October 22',
    start: { month: 9, day: 23 },
    end: { month: 10, day: 22 },
    element: 'Air',
    modality: 'Cardinal',
    rulingPlanet: 'Venus',
    accent: '#f783ac',
    glow: 'rgba(247, 131, 172, 0.3)',
    behaviors: [
      'Diplomatic and relationship-oriented with a strong fairness instinct.',
      'Naturally balances perspectives and avoids unnecessary conflict.',
      'Communicates with charm, tact, and social intelligence.',
    ],
    habits: [
      'Curates beautiful spaces, outfits, and aesthetically pleasing routines.',
      'Checks multiple viewpoints before final decisions.',
      'Prefers collaborative plans and emotionally balanced environments.',
    ],
    cosmicTip: 'Libra thrives in kind partnerships and well-balanced rhythms.',
  },
  {
    id: 'scorpio',
    name: 'Scorpio',
    symbol: '♏',
    emoji: '🦂',
    dateRangeLabel: 'October 23 - November 21',
    start: { month: 10, day: 23 },
    end: { month: 11, day: 21 },
    element: 'Water',
    modality: 'Fixed',
    rulingPlanet: 'Pluto (traditional: Mars)',
    accent: '#845ef7',
    glow: 'rgba(132, 94, 247, 0.3)',
    behaviors: [
      'Intense, perceptive, and emotionally deep beneath a calm exterior.',
      'Values loyalty, privacy, and trust earned through consistency.',
      'Approaches challenges with strategic focus and resilience.',
    ],
    habits: [
      'Keeps personal life selective and shares deeply with trusted people.',
      'Researches motivations and reads between the lines naturally.',
      'Works in focused bursts when fully committed to a goal.',
    ],
    cosmicTip: 'Scorpio transforms fastest when honesty and depth are welcomed.',
  },
  {
    id: 'sagittarius',
    name: 'Sagittarius',
    symbol: '♐',
    emoji: '🏹',
    dateRangeLabel: 'November 22 - December 21',
    start: { month: 11, day: 22 },
    end: { month: 12, day: 21 },
    element: 'Fire',
    modality: 'Mutable',
    rulingPlanet: 'Jupiter',
    accent: '#ff8787',
    glow: 'rgba(255, 135, 135, 0.28)',
    behaviors: [
      'Optimistic, adventurous, and motivated by freedom and discovery.',
      'Seeks meaning through exploration, learning, and honest dialogue.',
      'Brings playful humor and a big-picture perspective to groups.',
    ],
    habits: [
      'Plans spontaneous outings, trips, or new learning challenges.',
      'Prefers flexible structures over strict daily routines.',
      'Recharges through movement, open spaces, and future-focused goals.',
    ],
    cosmicTip: 'Sagittarius sparkles when curiosity stays bigger than fear.',
  },
  {
    id: 'capricorn',
    name: 'Capricorn',
    symbol: '♑',
    emoji: '🐐',
    dateRangeLabel: 'December 22 - January 19',
    start: { month: 12, day: 22 },
    end: { month: 1, day: 19 },
    element: 'Earth',
    modality: 'Cardinal',
    rulingPlanet: 'Saturn',
    accent: '#868e96',
    glow: 'rgba(134, 142, 150, 0.28)',
    behaviors: [
      'Disciplined, dependable, and focused on long-term progress.',
      'Approaches goals with patience, structure, and realism.',
      'Shows love through commitment, reliability, and steady effort.',
    ],
    habits: [
      'Sets measurable targets and tracks progress carefully.',
      'Builds routines that support career, health, and responsibility.',
      'Protects time for productive deep work and future planning.',
    ],
    cosmicTip: 'Capricorn grows strongest when ambition meets healthy rest.',
  },
  {
    id: 'aquarius',
    name: 'Aquarius',
    symbol: '♒',
    emoji: '🌊',
    dateRangeLabel: 'January 20 - February 18',
    start: { month: 1, day: 20 },
    end: { month: 2, day: 18 },
    element: 'Air',
    modality: 'Fixed',
    rulingPlanet: 'Uranus (traditional: Saturn)',
    accent: '#3bc9db',
    glow: 'rgba(59, 201, 219, 0.28)',
    behaviors: [
      'Independent, inventive, and future-oriented in thought and values.',
      'Questions norms and prefers authentic, unconventional expression.',
      'Builds friendships through shared ideals and intellectual connection.',
    ],
    habits: [
      'Experiments with new tools, ideas, and creative systems.',
      'Alternates social energy with intentional personal space.',
      'Invests in communities, causes, or projects with social impact.',
    ],
    cosmicTip: 'Aquarius thrives where originality and purpose can coexist.',
  },
  {
    id: 'pisces',
    name: 'Pisces',
    symbol: '♓',
    emoji: '🐟',
    dateRangeLabel: 'February 19 - March 20',
    start: { month: 2, day: 19 },
    end: { month: 3, day: 20 },
    element: 'Water',
    modality: 'Mutable',
    rulingPlanet: 'Neptune (traditional: Jupiter)',
    accent: '#748ffc',
    glow: 'rgba(116, 143, 252, 0.3)',
    behaviors: [
      'Compassionate, imaginative, and emotionally receptive to others.',
      'Moves between intuition and creativity with natural fluidity.',
      'Feels deeply and often communicates through art, tone, or symbolism.',
    ],
    habits: [
      'Uses music, journaling, or creative hobbies to process emotions.',
      'Needs quiet recharge time after intense social environments.',
      'Dreams big and benefits from gentle structure to stay grounded.',
    ],
    cosmicTip: 'Pisces blossoms when intuition is balanced with clear boundaries.',
  },
];

const ELEMENT_COMPATIBILITY_SCORES = {
  'Air|Air': 79,
  'Air|Earth': 60,
  'Air|Fire': 88,
  'Air|Water': 58,
  'Earth|Earth': 82,
  'Earth|Fire': 61,
  'Earth|Water': 87,
  'Fire|Fire': 81,
  'Fire|Water': 56,
  'Water|Water': 83,
};

const ELEMENT_PAIR_INSIGHTS = {
  'Air|Air': {
    chemistry: 'You connect quickly through ideas, humor, and nonstop conversation.',
    challenge: 'Emotional topics may be postponed while you stay in your heads.',
    tip: 'Schedule regular heart-to-heart check-ins, not only playful chats.',
  },
  'Air|Earth': {
    chemistry: 'Air brings fresh ideas while Earth offers practical grounding.',
    challenge: 'One may move fast mentally while the other prefers steady planning.',
    tip: 'Blend brainstorming with realistic timelines to satisfy both styles.',
  },
  'Air|Fire': {
    chemistry: 'This is a lively, adventurous pairing with natural excitement.',
    challenge: 'Both can jump ahead quickly and skip slower emotional repair moments.',
    tip: 'Pause after conflicts and clarify feelings before the next adventure.',
  },
  'Air|Water': {
    chemistry: 'Air adds perspective while Water brings empathy and emotional depth.',
    challenge: 'Different communication pace can cause mixed signals.',
    tip: 'Use gentle language and active listening to translate head and heart.',
  },
  'Earth|Earth': {
    chemistry: 'You build trust through loyalty, reliability, and shared routines.',
    challenge: 'Comfort zones can become too predictable or emotionally quiet.',
    tip: 'Add new experiences occasionally so growth stays alive.',
  },
  'Earth|Fire': {
    chemistry: 'Fire energizes Earth, and Earth helps Fire stay focused.',
    challenge: 'Spontaneity vs structure can become a recurring friction point.',
    tip: 'Keep one flexible day and one structured day each week.',
  },
  'Earth|Water': {
    chemistry: 'A nurturing and stable match with strong long-term potential.',
    challenge: 'You may avoid difficult conversations to keep the peace.',
    tip: 'Talk through worries early before they quietly build up.',
  },
  'Fire|Fire': {
    chemistry: 'High passion, bold chemistry, and shared enthusiasm for life.',
    challenge: 'Strong personalities can escalate conflict quickly.',
    tip: 'Choose repair rituals after arguments to protect the bond.',
  },
  'Fire|Water': {
    chemistry: 'Magnetic contrast: passion meets emotional intuition.',
    challenge: 'Intensity levels can feel mismatched in conflict moments.',
    tip: 'Respect cooling-off time and return with reassurance.',
  },
  'Water|Water': {
    chemistry: 'Deep emotional bonding and intuitive understanding come naturally.',
    challenge: 'Mood cycles can amplify each other if boundaries are unclear.',
    tip: 'Balance closeness with solo recharge time for emotional clarity.',
  },
};

const MODALITY_COMPATIBILITY_BONUS = {
  'Cardinal|Cardinal': 1,
  'Cardinal|Fixed': 3,
  'Cardinal|Mutable': 5,
  'Fixed|Fixed': -3,
  'Fixed|Mutable': 4,
  'Mutable|Mutable': 2,
};

const MODALITY_INSIGHTS = {
  'Cardinal|Cardinal': 'You both initiate fast, so shared leadership works best with clear role-splitting.',
  'Cardinal|Fixed': 'One starts momentum while the other sustains it, creating strong follow-through.',
  'Cardinal|Mutable': 'Excellent flexibility: one kicks things off and the other adapts beautifully.',
  'Fixed|Fixed': 'Powerful loyalty, but compromise is essential so stubbornness does not stall growth.',
  'Fixed|Mutable': 'Steady structure plus adaptability can balance the relationship well.',
  'Mutable|Mutable': 'You flow naturally together, though consistency habits keep plans on track.',
};

const POLARITY_OPPOSITE_PAIRS = new Set([
  'aries|libra',
  'taurus|scorpio',
  'gemini|sagittarius',
  'cancer|capricorn',
  'leo|aquarius',
  'pisces|virgo',
]);

function createPairKey(firstValue, secondValue) {
  return [firstValue, secondValue].sort().join('|');
}

function clampValue(value, min, max) {
  return Math.min(Math.max(value, min), max);
}

function getCompatibilityLevel(score) {
  if (score >= 86) {
    return {
      label: 'Cosmic Sync',
      emoji: '💞',
      description: 'Very high natural alignment. Keep it intentional and this can feel effortless.',
    };
  }

  if (score >= 74) {
    return {
      label: 'Strong Spark',
      emoji: '✨',
      description: 'Great core chemistry with strong long-term potential through good communication.',
    };
  }

  if (score >= 62) {
    return {
      label: 'Balanced & Growing',
      emoji: '🌱',
      description: 'Different styles can complement each other when both partners stay intentional.',
    };
  }

  return {
    label: 'Opposites in Orbit',
    emoji: '🪐',
    description: 'This match needs extra emotional skills, but growth can be powerful together.',
  };
}

export function getZodiacCompatibilityReport(firstSign, secondSign) {
  if (!firstSign || !secondSign) return null;

  const elementKey = createPairKey(firstSign.element, secondSign.element);
  const modalityKey = createPairKey(firstSign.modality, secondSign.modality);
  const signKey = createPairKey(firstSign.id, secondSign.id);

  const baseScore = ELEMENT_COMPATIBILITY_SCORES[elementKey] ?? 65;
  const modalityBonus = MODALITY_COMPATIBILITY_BONUS[modalityKey] ?? 0;
  const sameSignBonus = firstSign.id === secondSign.id ? 6 : 0;
  const oppositePolarityBonus = POLARITY_OPPOSITE_PAIRS.has(signKey) ? 3 : 0;

  const score = clampValue(
    Math.round(baseScore + modalityBonus + sameSignBonus + oppositePolarityBonus),
    35,
    98,
  );

  const level = getCompatibilityLevel(score);
  const elementInsight = ELEMENT_PAIR_INSIGHTS[elementKey] || {
    chemistry: 'This pair can complement each other with communication and mutual respect.',
    challenge: 'Different rhythms may need extra patience during stressful moments.',
    tip: 'Create clear habits that support both emotional and practical needs.',
  };

  return {
    score,
    level,
    elementSummary: `${firstSign.element} + ${secondSign.element}`,
    modalitySummary: `${firstSign.modality} + ${secondSign.modality}`,
    chemistry: elementInsight.chemistry,
    challenge: elementInsight.challenge,
    habitTip: elementInsight.tip,
    modalityInsight: MODALITY_INSIGHTS[modalityKey]
      || 'Shared routines and clear communication help this match thrive.',
    isSameSign: firstSign.id === secondSign.id,
    isOppositePair: POLARITY_OPPOSITE_PAIRS.has(signKey),
  };
}

function parseISODate(dateOfBirth) {
  if (typeof dateOfBirth !== 'string') return null;

  const match = dateOfBirth.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (!match) return null;

  const year = Number(match[1]);
  const month = Number(match[2]);
  const day = Number(match[3]);

  const date = new Date(year, month - 1, day);
  if (
    Number.isNaN(date.getTime())
    || date.getFullYear() !== year
    || date.getMonth() !== month - 1
    || date.getDate() !== day
  ) {
    return null;
  }

  return { year, month, day, date };
}

function isMonthDayInRange(month, day, start, end) {
  const value = month * 100 + day;
  const startValue = start.month * 100 + start.day;
  const endValue = end.month * 100 + end.day;

  if (startValue <= endValue) {
    return value >= startValue && value <= endValue;
  }

  return value >= startValue || value <= endValue;
}

function getSignByDateParts(month, day) {
  return ZODIAC_SIGNS.find((sign) => {
    return isMonthDayInRange(month, day, sign.start, sign.end);
  }) || null;
}

function getTodayDateOnly() {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate());
}

export function getTodayAsISODate() {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

export function getZodiacProfileFromDob(dateOfBirth) {
  const parsed = parseISODate(dateOfBirth);
  if (!parsed) {
    return { error: 'invalid_date' };
  }

  if (parsed.date > getTodayDateOnly()) {
    return { error: 'future_date' };
  }

  const sign = getSignByDateParts(parsed.month, parsed.day);
  if (!sign) {
    return { error: 'sign_not_found' };
  }

  const formattedBirthDate = new Intl.DateTimeFormat(undefined, {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(parsed.date);

  return {
    sign,
    formattedBirthDate,
    dateParts: {
      year: parsed.year,
      month: parsed.month,
      day: parsed.day,
    },
  };
}

export function getZodiacCompatibilityFromDob(firstDob, secondDob) {
  const firstProfile = getZodiacProfileFromDob(firstDob);
  if (firstProfile.error) {
    return { error: `first_${firstProfile.error}` };
  }

  const secondProfile = getZodiacProfileFromDob(secondDob);
  if (secondProfile.error) {
    return { error: `second_${secondProfile.error}` };
  }

  const compatibility = getZodiacCompatibilityReport(firstProfile.sign, secondProfile.sign);

  return {
    firstProfile,
    secondProfile,
    compatibility,
  };
}

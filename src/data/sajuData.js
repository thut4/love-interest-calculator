export const ELEMENT_ORDER = ['Wood', 'Fire', 'Earth', 'Metal', 'Water'];

export const ELEMENT_META = {
  Wood: {
    korean: '목(木)',
    color: '#7bd389',
    traits: 'growth, vision, creativity',
  },
  Fire: {
    korean: '화(火)',
    color: '#ff8fab',
    traits: 'passion, expression, motivation',
  },
  Earth: {
    korean: '토(土)',
    color: '#ffd166',
    traits: 'stability, trust, grounding',
  },
  Metal: {
    korean: '금(金)',
    color: '#b8c0ff',
    traits: 'discipline, precision, boundaries',
  },
  Water: {
    korean: '수(水)',
    color: '#70d6ff',
    traits: 'intuition, adaptability, wisdom',
  },
};

export const HEAVENLY_STEMS = [
  { hanja: '甲', korean: '갑', element: 'Wood', yinYang: 'Yang' },
  { hanja: '乙', korean: '을', element: 'Wood', yinYang: 'Yin' },
  { hanja: '丙', korean: '병', element: 'Fire', yinYang: 'Yang' },
  { hanja: '丁', korean: '정', element: 'Fire', yinYang: 'Yin' },
  { hanja: '戊', korean: '무', element: 'Earth', yinYang: 'Yang' },
  { hanja: '己', korean: '기', element: 'Earth', yinYang: 'Yin' },
  { hanja: '庚', korean: '경', element: 'Metal', yinYang: 'Yang' },
  { hanja: '辛', korean: '신', element: 'Metal', yinYang: 'Yin' },
  { hanja: '壬', korean: '임', element: 'Water', yinYang: 'Yang' },
  { hanja: '癸', korean: '계', element: 'Water', yinYang: 'Yin' },
];

export const EARTHLY_BRANCHES = [
  { hanja: '子', korean: '자', animal: 'Rat', element: 'Water', yinYang: 'Yang' },
  { hanja: '丑', korean: '축', animal: 'Ox', element: 'Earth', yinYang: 'Yin' },
  { hanja: '寅', korean: '인', animal: 'Tiger', element: 'Wood', yinYang: 'Yang' },
  { hanja: '卯', korean: '묘', animal: 'Rabbit', element: 'Wood', yinYang: 'Yin' },
  { hanja: '辰', korean: '진', animal: 'Dragon', element: 'Earth', yinYang: 'Yang' },
  { hanja: '巳', korean: '사', animal: 'Snake', element: 'Fire', yinYang: 'Yin' },
  { hanja: '午', korean: '오', animal: 'Horse', element: 'Fire', yinYang: 'Yang' },
  { hanja: '未', korean: '미', animal: 'Goat', element: 'Earth', yinYang: 'Yin' },
  { hanja: '申', korean: '신', animal: 'Monkey', element: 'Metal', yinYang: 'Yang' },
  { hanja: '酉', korean: '유', animal: 'Rooster', element: 'Metal', yinYang: 'Yin' },
  { hanja: '戌', korean: '술', animal: 'Dog', element: 'Earth', yinYang: 'Yang' },
  { hanja: '亥', korean: '해', animal: 'Pig', element: 'Water', yinYang: 'Yin' },
];

export const DESTINY_INTERPRETATIONS = {
  Wood: 'Your destiny energy grows through expansion, learning, and purposeful movement. Build life around steady growth and long-view goals.',
  Fire: 'Your destiny energy shines through expression, warmth, and inspiration. Lead with heart, but protect your energy from burnout.',
  Earth: 'Your destiny energy stabilizes through consistency, care, and trust-building. You thrive when your routines support your values.',
  Metal: 'Your destiny energy refines through clarity, standards, and strategy. Boundaries and disciplined decisions unlock your best timing.',
  Water: 'Your destiny energy flows through intuition, insight, and adaptability. Quiet reflection and emotional intelligence are your superpower.',
};

export const ELEMENT_ADVICE = {
  Wood: [
    'Add growth rituals: reading, mentoring, or skill-building each week.',
    'Protect long-term vision with monthly planning and review.',
  ],
  Fire: [
    'Use creative output (voice, writing, art) to release stagnant emotion.',
    'Schedule recovery after intense social or work periods.',
  ],
  Earth: [
    'Anchor your week with repeatable routines for sleep, meals, and movement.',
    'Choose environments and relationships that feel emotionally safe.',
  ],
  Metal: [
    'Refine boundaries in time, money, and communication.',
    'Declutter decisions with a clear “yes/no” checklist.',
  ],
  Water: [
    'Create quiet reflection time for intuition to stay clear.',
    'Balance flexibility with one non-negotiable grounding habit.',
  ],
};

export const PILLAR_DEEP_DIVE = {
  'Year Pillar': {
    title: 'Outer Destiny and Early Environment',
    summary:
      'Year Pillar describes inherited energy, social identity, and the tone of your early life foundation.',
    strengths: [
      'Shows the type of circles and environments where your luck opens fastest.',
      'Reveals natural social style and how others first read your energy.',
    ],
    growthTip:
      'Strengthen your Year Pillar by choosing communities that match your values, not only your ambitions.',
  },
  'Month Pillar': {
    title: 'Career Rhythm and Productive Energy',
    summary:
      'Month Pillar reflects work style, discipline, and the energetic climate of your prime growth years.',
    strengths: [
      'Highlights where your effort compounds most in study, career, and skill-building.',
      'Shows how to pace effort so success is sustainable instead of exhausting.',
    ],
    growthTip:
      'Build a repeatable weekly structure. Consistent rhythm stabilizes long-term fortune.',
  },
  'Day Pillar': {
    title: 'Core Self and Relationship Pattern',
    summary:
      'Day Pillar is the heart of the chart, tied to identity, emotional needs, and one-to-one partnership patterns.',
    strengths: [
      'Points to your authentic emotional style and trust language.',
      'Reveals the qualities you need in close relationships for mutual growth.',
    ],
    growthTip:
      'Use direct emotional communication. Clear needs create better partnership timing.',
  },
  'Hour Pillar': {
    title: 'Future Vision and Inner Creative Potential',
    summary:
      'Hour Pillar represents long-range dreams, private motivations, and the legacy energy you cultivate over time.',
    strengths: [
      'Shows your hidden strengths that mature later in life.',
      'Indicates how your intuition and future planning should work together.',
    ],
    growthTip:
      'Protect deep-focus time. Quiet refinement unlocks your most meaningful outcomes.',
  },
};

export const ELEMENT_DEEP_DIVE = {
  Wood: {
    title: 'Growth Driver',
    essence: 'Expansion, strategy, creativity, and long-view direction.',
    strengths:
      'You build momentum through learning, vision, and initiative.',
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
  },
  Fire: {
    title: 'Expression Driver',
    essence: 'Visibility, charisma, passion, and emotional animation.',
    strengths:
      'You inspire others through presence, warmth, and expressive leadership.',
    lowState:
      'When low, motivation drops and self-expression gets muted.',
    habitFocus:
      'Use daily creative release: voice notes, writing, art, or speaking practice.',
    relationshipTip:
      'Celebrate small wins openly; appreciation keeps emotional intimacy alive.',
    careerTip:
      'Fire thrives in roles with performance, storytelling, leadership, or public influence.',
    balanceAction:
      'Protect sleep and recovery so passion stays sustainable.',
  },
  Earth: {
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
  },
  Metal: {
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
    balanceAction:
      'Use clear decision frameworks and stop overcommitting.',
  },
  Water: {
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
  },
};

export const CITY_TIMEZONE_OVERRIDES = {
  seoul: 'Asia/Seoul',
  busan: 'Asia/Seoul',
  incheon: 'Asia/Seoul',
  tokyo: 'Asia/Tokyo',
  osaka: 'Asia/Tokyo',
  beijing: 'Asia/Shanghai',
  shanghai: 'Asia/Shanghai',
  hongkong: 'Asia/Hong_Kong',
  singapore: 'Asia/Singapore',
  bangkok: 'Asia/Bangkok',
  yangon: 'Asia/Yangon',
  mumbai: 'Asia/Kolkata',
  delhi: 'Asia/Kolkata',
  london: 'Europe/London',
  paris: 'Europe/Paris',
  berlin: 'Europe/Berlin',
  madrid: 'Europe/Madrid',
  rome: 'Europe/Rome',
  sydney: 'Australia/Sydney',
  melbourne: 'Australia/Melbourne',
  auckland: 'Pacific/Auckland',
  newyork: 'America/New_York',
  losangeles: 'America/Los_Angeles',
  chicago: 'America/Chicago',
  toronto: 'America/Toronto',
  vancouver: 'America/Vancouver',
  mexico: 'America/Mexico_City',
  'sao paulo': 'America/Sao_Paulo',
  'buenos aires': 'America/Argentina/Buenos_Aires',
  dubai: 'Asia/Dubai',
  istanbul: 'Europe/Istanbul',
  cairo: 'Africa/Cairo',
};

export const COUNTRY_DEFAULT_TIMEZONE = {
  'south korea': 'Asia/Seoul',
  korea: 'Asia/Seoul',
  japan: 'Asia/Tokyo',
  china: 'Asia/Shanghai',
  taiwan: 'Asia/Taipei',
  'hong kong': 'Asia/Hong_Kong',
  singapore: 'Asia/Singapore',
  thailand: 'Asia/Bangkok',
  myanmar: 'Asia/Yangon',
  india: 'Asia/Kolkata',
  uk: 'Europe/London',
  'united kingdom': 'Europe/London',
  france: 'Europe/Paris',
  germany: 'Europe/Berlin',
  spain: 'Europe/Madrid',
  italy: 'Europe/Rome',
  australia: 'Australia/Sydney',
  'new zealand': 'Pacific/Auckland',
  usa: 'America/New_York',
  'united states': 'America/New_York',
  canada: 'America/Toronto',
  mexico: 'America/Mexico_City',
  brazil: 'America/Sao_Paulo',
  argentina: 'America/Argentina/Buenos_Aires',
  'united arab emirates': 'Asia/Dubai',
  turkey: 'Europe/Istanbul',
  egypt: 'Africa/Cairo',
};

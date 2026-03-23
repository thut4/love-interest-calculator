import {
  CITY_TIMEZONE_OVERRIDES,
  COUNTRY_DEFAULT_TIMEZONE,
  DESTINY_INTERPRETATIONS,
  EARTHLY_BRANCHES,
  ELEMENT_ADVICE,
  ELEMENT_DEEP_DIVE,
  ELEMENT_META,
  ELEMENT_ORDER,
  HEAVENLY_STEMS,
  PILLAR_DEEP_DIVE,
} from '../data/sajuData';

const BASE_JIAZI_UTC = Date.UTC(1984, 1, 2); // 1984-02-02 (甲子 day reference)

function mod(value, divisor) {
  return ((value % divisor) + divisor) % divisor;
}

function normalizeLocationText(value) {
  return (value || '')
    .toLowerCase()
    .trim()
    .replace(/[.,]/g, '')
    .replace(/\s+/g, ' ');
}

function normalizeCompactKey(value) {
  return normalizeLocationText(value).replace(/\s+/g, '');
}

export function inferTimeZone(city, country) {
  const cityNormalized = normalizeLocationText(city);
  const cityCompact = normalizeCompactKey(city);
  const countryNormalized = normalizeLocationText(country);

  if (CITY_TIMEZONE_OVERRIDES[cityNormalized]) return CITY_TIMEZONE_OVERRIDES[cityNormalized];
  if (CITY_TIMEZONE_OVERRIDES[cityCompact]) return CITY_TIMEZONE_OVERRIDES[cityCompact];
  if (COUNTRY_DEFAULT_TIMEZONE[countryNormalized]) return COUNTRY_DEFAULT_TIMEZONE[countryNormalized];

  return Intl.DateTimeFormat().resolvedOptions().timeZone || 'UTC';
}

function getSeasonalMonthBranchIndex(month, day) {
  const mmdd = month * 100 + day;

  if (mmdd >= 1207 || mmdd <= 105) return 0; // Rat month
  if (mmdd >= 106 && mmdd <= 203) return 1; // Ox month
  if (mmdd >= 204 && mmdd <= 305) return 2; // Tiger month
  if (mmdd >= 306 && mmdd <= 404) return 3; // Rabbit month
  if (mmdd >= 405 && mmdd <= 505) return 4; // Dragon month
  if (mmdd >= 506 && mmdd <= 605) return 5; // Snake month
  if (mmdd >= 606 && mmdd <= 706) return 6; // Horse month
  if (mmdd >= 707 && mmdd <= 807) return 7; // Goat month
  if (mmdd >= 808 && mmdd <= 907) return 8; // Monkey month
  if (mmdd >= 908 && mmdd <= 1007) return 9; // Rooster month
  if (mmdd >= 1008 && mmdd <= 1106) return 10; // Dog month
  return 11; // Pig month (1107 - 1206)
}

function getAdjustedYearForSaju(year, month, day) {
  if (month < 2) return year - 1;
  if (month === 2 && day < 4) return year - 1;
  return year;
}

function getDayPillar(year, month, day) {
  const targetUtc = Date.UTC(year, month - 1, day);
  const dayDiff = Math.floor((targetUtc - BASE_JIAZI_UTC) / 86400000);
  const cycleIndex = mod(dayDiff, 60);

  return {
    stemIndex: cycleIndex % 10,
    branchIndex: cycleIndex % 12,
  };
}

function getHourBranchIndex(hour, minute) {
  const normalizedHour = hour + (minute / 60);
  return mod(Math.floor((normalizedHour + 1) / 2), 12);
}

function createPillar(label, stemIndex, branchIndex) {
  const stem = HEAVENLY_STEMS[stemIndex];
  const branch = EARTHLY_BRANCHES[branchIndex];

  return {
    label,
    stem,
    branch,
    hanja: `${stem.hanja}${branch.hanja}`,
    korean: `${stem.korean}${branch.korean}`,
    animal: branch.animal,
  };
}

function buildElementCounts(pillars) {
  const counts = ELEMENT_ORDER.reduce((acc, element) => {
    acc[element] = 0;
    return acc;
  }, {});

  pillars.forEach((pillar) => {
    counts[pillar.stem.element] += 2;
    counts[pillar.branch.element] += 1;
  });

  return counts;
}

function buildPersonalizedAdvice(dominantElement, weakElements) {
  const suggestions = [];

  suggestions.push(`Your strongest energy is ${ELEMENT_META[dominantElement].korean}. Lead with its strength: ${ELEMENT_META[dominantElement].traits}.`);

  (ELEMENT_ADVICE[dominantElement] || []).slice(0, 1).forEach((tip) => {
    suggestions.push(tip);
  });

  weakElements.forEach((element) => {
    const firstTip = ELEMENT_ADVICE[element]?.[0];
    if (firstTip) {
      suggestions.push(`Balance weak ${ELEMENT_META[element].korean} energy: ${firstTip}`);
    }
  });

  suggestions.push('Saju timing works best with consistency. Review your goals every lunar month and adjust with awareness, not fear.');

  return suggestions;
}

function buildPillarDeepDive(pillars) {
  return pillars.map((pillar) => {
    const base = PILLAR_DEEP_DIVE[pillar.label];

    return {
      label: pillar.label,
      title: base?.title || 'Pillar Insight',
      summary: base?.summary || 'This pillar describes a meaningful life domain in your Saju chart.',
      strengths: base?.strengths || [],
      growthTip: base?.growthTip || 'Use this pillar consciously through routines and reflection.',
      englishBlend: `${pillar.stem.element} stem + ${pillar.branch.element} branch (${pillar.animal})`,
      hanja: pillar.hanja,
      korean: pillar.korean,
    };
  });
}

function getElementStatus({ score, maxValue, minValue }) {
  if (score === maxValue) return 'Strong';
  if (score === minValue) return 'Low';
  return 'Balanced';
}

function buildElementDeepDive({ elementCounts, maxValue, minValue }) {
  return ELEMENT_ORDER.map((element) => {
    const score = elementCounts[element];
    const data = ELEMENT_DEEP_DIVE[element];
    const status = getElementStatus({ score, maxValue, minValue });

    const dynamicSummary = status === 'Strong'
      ? `${data.essence} This element currently leads your chart, so its gifts are easier to access.`
      : status === 'Low'
        ? `${data.essence} This element is underrepresented, so conscious strengthening brings better balance.`
        : `${data.essence} This element is moderate, supporting flexible and stable expression.`;

    return {
      element,
      korean: ELEMENT_META[element].korean,
      score,
      status,
      title: data.title,
      summary: dynamicSummary,
      strengths: data.strengths,
      lowState: data.lowState,
      habitFocus: data.habitFocus,
      relationshipTip: data.relationshipTip,
      careerTip: data.careerTip,
      balanceAction: data.balanceAction,
    };
  });
}

function parseBirthInput(birthDate, birthTime) {
  const dateMatch = typeof birthDate === 'string'
    ? birthDate.match(/^(\d{4})-(\d{2})-(\d{2})$/)
    : null;
  const timeMatch = typeof birthTime === 'string'
    ? birthTime.match(/^(\d{2}):(\d{2})$/)
    : null;

  if (!dateMatch || !timeMatch) return null;

  const year = Number(dateMatch[1]);
  const month = Number(dateMatch[2]);
  const day = Number(dateMatch[3]);
  const hour = Number(timeMatch[1]);
  const minute = Number(timeMatch[2]);

  if (month < 1 || month > 12 || day < 1 || day > 31) return null;
  if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

  const date = new Date(year, month - 1, day);
  if (
    Number.isNaN(date.getTime())
    || date.getFullYear() !== year
    || date.getMonth() !== month - 1
    || date.getDate() !== day
  ) {
    return null;
  }

  return { year, month, day, hour, minute };
}

export function calculateSajuProfile({
  birthDate,
  birthTime,
  birthCity,
  birthCountry,
}) {
  const parsed = parseBirthInput(birthDate, birthTime);
  if (!parsed) {
    return { error: 'invalid_birth_input' };
  }

  if (!birthCity?.trim() || !birthCountry?.trim()) {
    return { error: 'missing_location' };
  }

  const today = new Date();
  const birthValue = new Date(parsed.year, parsed.month - 1, parsed.day, parsed.hour, parsed.minute);
  if (birthValue > today) {
    return { error: 'future_birth' };
  }

  const timezone = inferTimeZone(birthCity, birthCountry);

  const adjustedYear = getAdjustedYearForSaju(parsed.year, parsed.month, parsed.day);
  const yearStemIndex = mod(adjustedYear - 4, 10);
  const yearBranchIndex = mod(adjustedYear - 4, 12);

  const monthBranchIndex = getSeasonalMonthBranchIndex(parsed.month, parsed.day);
  const firstMonthStemIndex = mod(((yearStemIndex % 5) * 2) + 2, 10); // Tiger month stem
  const monthOffset = mod(monthBranchIndex - 2, 12); // Tiger branch index is 2
  const monthStemIndex = mod(firstMonthStemIndex + monthOffset, 10);

  const dayPillar = getDayPillar(parsed.year, parsed.month, parsed.day);

  const hourBranchIndex = getHourBranchIndex(parsed.hour, parsed.minute);
  const hourStemStart = mod((dayPillar.stemIndex % 5) * 2, 10);
  const hourStemIndex = mod(hourStemStart + hourBranchIndex, 10);

  const pillars = [
    createPillar('Year Pillar', yearStemIndex, yearBranchIndex),
    createPillar('Month Pillar', monthStemIndex, monthBranchIndex),
    createPillar('Day Pillar', dayPillar.stemIndex, dayPillar.branchIndex),
    createPillar('Hour Pillar', hourStemIndex, hourBranchIndex),
  ];

  const elementCounts = buildElementCounts(pillars);

  const sortedElements = [...ELEMENT_ORDER].sort((a, b) => {
    return elementCounts[b] - elementCounts[a];
  });

  const dominantElement = sortedElements[0];
  const maxValue = elementCounts[dominantElement];
  const minValue = elementCounts[sortedElements[sortedElements.length - 1]];
  const weakElements = sortedElements.filter((element) => elementCounts[element] === minValue);

  const destinyInterpretation = DESTINY_INTERPRETATIONS[dominantElement];
  const personalizedAdvice = buildPersonalizedAdvice(dominantElement, weakElements);
  const pillarDeepDive = buildPillarDeepDive(pillars);
  const elementDeepDive = buildElementDeepDive({
    elementCounts,
    maxValue,
    minValue,
  });

  const energySummary = `${ELEMENT_META[dominantElement].korean} energy is strongest in your chart. `
    + `Your balance focus is ${weakElements.map((element) => ELEMENT_META[element].korean).join(', ')}.`;
  const englishOverview = `Your chart is led by ${dominantElement} energy. `
    + `The key balancing lesson is ${weakElements.join(', ')} integration through daily habits.`;

  return {
    timezone,
    birthLocation: {
      city: birthCity.trim(),
      country: birthCountry.trim(),
    },
    parsedBirth: parsed,
    pillars,
    elementCounts,
    dominantElement,
    weakElements,
    destinyInterpretation,
    personalizedAdvice,
    energySummary,
    englishOverview,
    pillarDeepDive,
    elementDeepDive,
    notes: [
      'Month pillar uses seasonal solar-term boundaries (입춘 기준) approximation.',
      'Location is used for timezone context based on city/country inference.',
    ],
  };
}

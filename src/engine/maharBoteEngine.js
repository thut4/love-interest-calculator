import { MAHAR_BOTE_HOUSES } from '../data/maharBoteData';

/**
 * Returns a positive remainder for modulo operations (matching Dart `%`)
 * @param {number} value
 * @param {number} divisor
 * @returns {number}
 */
function positiveMod(value, divisor) {
  const remainder = value % divisor;
  return remainder < 0 ? remainder + divisor : remainder;
}

/**
 * Calculates the Myanmar year from a Gregorian date.
 * Typically it's year - 638, but month < April (month index < 3) means it's year - 637.
 * @param {Date} date
 * @returns {number}
 */
export function toMyanmarYear(date) {
  let myanmarYear = date.getFullYear() - 638;
  if (date.getMonth() < 3) {
    myanmarYear = date.getFullYear() - 637; // Jan, Feb, Mar belong to previous Myanmar year logic
  }
  return myanmarYear;
}

/**
 * Gets ISO week day. 1 = Monday ... 7 = Sunday
 * @param {Date} date
 * @returns {number}
 */
function getIsoWeekday(date) {
  const jsDay = date.getDay(); // 0 is Sunday, 1 is Monday ...
  return jsDay === 0 ? 7 : jsDay;
}

/**
 * Calculates the Mahar Bote house based on birth date.
 * @param {string} birthDateString (YYYY-MM-DD)
 * @returns {Object} { birthDate, weekday, myanmarYear, remainder, house }
 */
export function calculateMaharBote(birthDateString) {
  if (!birthDateString) {
    return { error: 'invalid_birth_input' };
  }

  // Use local timezone interpretation by splitting the input string
  const [year, month, day] = birthDateString.split('-').map(Number);
  const date = new Date(year, month - 1, day);

  if (isNaN(date.valueOf())) {
    return { error: 'invalid_birth_input' };
  }

  const myanmarYear = toMyanmarYear(date);
  const remainder = positiveMod(myanmarYear, 7);
  const isoWeekday = getIsoWeekday(date);

  // According to Dart code logic:
  // houseIndex = _positiveMod(myanmarYear - normalized.weekday - 1, _houseCycle.length)
  const houseIndex = positiveMod(myanmarYear - isoWeekday - 1, MAHAR_BOTE_HOUSES.length);
  const house = MAHAR_BOTE_HOUSES[houseIndex];

  return {
    birthDate: date,
    isoWeekday: isoWeekday,
    myanmarYear,
    remainder,
    house,
  };
}

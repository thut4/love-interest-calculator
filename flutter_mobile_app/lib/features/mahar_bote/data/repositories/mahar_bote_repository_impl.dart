import '../../domain/entities/mahar_bote_house.dart';
import '../../domain/entities/mahar_bote_result.dart';
import '../../domain/repositories/mahar_bote_repository.dart';

class MaharBoteRepositoryImpl implements MaharBoteRepository {
  static const List<MaharBoteHouse> _houseCycle = [
    MaharBoteHouse(
      id: 'marana',
      englishName: 'Marana',
      myanmarName: 'မရဏ',
      emoji: '🌙',
      accentHex: 0xFF8DA2FF,
      vibe:
          'Quiet strategist energy. You do your best work after observing the full picture.',
      powerMove: 'Protect deep-focus time before making major moves.',
      playfulTip:
          'Night walks, calm playlists, and journaling boost your luck.',
    ),
    MaharBoteHouse(
      id: 'binga',
      englishName: 'Binga',
      myanmarName: 'ဘင်္ဂ',
      emoji: '🌊',
      accentHex: 0xFF58D8D4,
      vibe:
          'Adaptive flow energy. You can pivot quickly and spot hidden opportunities.',
      powerMove: 'Keep one flexible backup plan in your pocket.',
      playfulTip:
          'Add water rituals: tea time, hydration goals, or river sunsets.',
    ),
    MaharBoteHouse(
      id: 'puti',
      englishName: 'Puti',
      myanmarName: 'ပုတ်',
      emoji: '🔥',
      accentHex: 0xFFFF8B8B,
      vibe:
          'Bold spark energy. You create momentum by acting fast and inspiring others.',
      powerMove: 'Channel passion into one clear daily priority.',
      playfulTip: 'Start your mornings with a mini victory to stay lit.',
    ),
    MaharBoteHouse(
      id: 'atun',
      englishName: 'Atun',
      myanmarName: 'အထွန်း',
      emoji: '✨',
      accentHex: 0xFFFFC46B,
      vibe:
          'Shining growth energy. You rise when your creativity and confidence are visible.',
      powerMove: 'Say yes to opportunities where your voice can be heard.',
      playfulTip: 'Wear bright colors on key days for a confidence boost.',
    ),
    MaharBoteHouse(
      id: 'thike',
      englishName: 'Thike',
      myanmarName: 'သိုက်',
      emoji: '💎',
      accentHex: 0xFF80B7FF,
      vibe:
          'Treasure-keeper energy. You naturally build long-term value and trust.',
      powerMove: 'Invest in consistency over intensity.',
      playfulTip: 'Tiny savings and tiny habits stack up into big wins.',
    ),
    MaharBoteHouse(
      id: 'yaza',
      englishName: 'Yaza',
      myanmarName: 'ရာဇ',
      emoji: '👑',
      accentHex: 0xFFFF7CB7,
      vibe:
          'Leader aura energy. You thrive when you take responsibility with kindness.',
      powerMove: 'Lead by example, then invite collaboration.',
      playfulTip: 'Celebrate progress with your team, not only outcomes.',
    ),
    MaharBoteHouse(
      id: 'adipati',
      englishName: 'Adipati',
      myanmarName: 'အဓိပတိ',
      emoji: '🦋',
      accentHex: 0xFF9D93FF,
      vibe:
          'Guiding heart energy. You influence people through empathy and clarity.',
      powerMove: 'Set boundaries early so your generosity stays balanced.',
      playfulTip:
          'One mindful reset break each day keeps your intuition sharp.',
    ),
  ];

  @override
  MaharBoteResult calculate(DateTime birthDate) {
    final normalized = DateTime(birthDate.year, birthDate.month, birthDate.day);
    final myanmarYear = _toMyanmarYear(normalized);
    final remainder = _positiveMod(myanmarYear, 7);

    final houseIndex = _positiveMod(
      myanmarYear - normalized.weekday - 1,
      _houseCycle.length,
    );
    final house = _houseCycle[houseIndex];

    return MaharBoteResult(
      birthDate: normalized,
      weekday: normalized.weekday,
      myanmarYear: myanmarYear,
      remainder: remainder,
      house: house,
    );
  }

  @override
  List<MaharBoteHouse> getHouseCycle() => _houseCycle;

  int _toMyanmarYear(DateTime birthDate) {
    // Ported from the reference app's formula with the month branch applied.
    var myanmarYear = birthDate.year - 638;
    if (birthDate.month < 4) {
      myanmarYear = birthDate.year - 637;
    }
    return myanmarYear;
  }

  int _positiveMod(int value, int divisor) {
    final remainder = value % divisor;
    return remainder < 0 ? remainder + divisor : remainder;
  }
}

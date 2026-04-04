import React, { useState, useMemo } from 'react';
import { BOARD_LAYOUT, MAHAR_BOTE_HOUSES } from '../data/maharBoteData';
import { calculateMaharBote } from '../engine/maharBoteEngine';

const WEEKDAYS = {
  1: { en: 'Monday', my: 'တနင်္လာ' },
  2: { en: 'Tuesday', my: 'အင်္ဂါ' },
  3: { en: 'Wednesday', my: 'ဗုဒ္ဓဟူး' },
  4: { en: 'Thursday', my: 'ကြာသပတေး' },
  5: { en: 'Friday', my: 'သောကြာ' },
  6: { en: 'Saturday', my: 'စနေ' },
  7: { en: 'Sunday', my: 'တနင်္ဂနွေ' },
};

export default function MaharBoteChecker({ onBack }) {
  const [birthDate, setBirthDate] = useState('');
  const [result, setResult] = useState(null);
  const [error, setError] = useState('');

  const handleCalculate = (e) => {
    e.preventDefault();
    if (!birthDate) return;

    const res = calculateMaharBote(birthDate);
    if (res.error) {
      setError('Please provide a valid date.');
      setResult(null);
      return;
    }

    setError('');
    setResult(res);
  };

  const handleReset = () => {
    setBirthDate('');
    setResult(null);
    setError('');
  };

  const formatDate = (dateStr) => {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    return date.toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' });
  };

  return (
    <section className="glass-card p-6 sm:p-8 animate-fade-in-up w-full">
      <div className="flex items-center justify-between gap-3 flex-wrap">
        <span className="inline-block px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-widest text-[#FF7AB6] bg-[#FF7AB6]/10 border border-[#FF7AB6]/20 shadow-sm">
          New Feature · မဟာဘုတ် ✨
        </span>
        <button className="btn-secondary px-4 py-2 text-sm transition-transform hover:-translate-y-0.5" onClick={onBack}>
          ← Back to Home
        </button>
      </div>

      <h2 className="text-2xl sm:text-3xl font-black mt-5" style={{ color: '#f8f9ff' }}>
        Mahar Bote Baydin
      </h2>
      <p className="text-sm sm:text-base mt-2 max-w-3xl leading-relaxed" style={{ color: '#b8c2e2' }}>
        Pick your birth date to reveal your Myanmar Baydin house with a playful cosmic snapshot.
      </p>

      {!result ? (
        <form className="mt-8 space-y-6 max-w-sm" onSubmit={handleCalculate}>
          <label className="block" htmlFor="mb-birth-date">
            <span className="block text-sm font-semibold mb-2" style={{ color: '#f1f3f9' }}>Your Birthday</span>
            <input
              id="mb-birth-date"
              className="w-full bg-[#0a0f25]/50 border border-white/10 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-[#4DEEAA] focus:ring-1 focus:ring-[#4DEEAA] transition-all"
              type="date"
              value={birthDate}
              onChange={(e) => {
                setBirthDate(e.target.value);
                if (error) setError('');
              }}
              required
            />
          </label>

          <div className="flex flex-wrap gap-3">
            <button type="submit" className="btn-primary flex-1 shadow-lg shadow-[#4DEEAA]/20 hover:shadow-[#4DEEAA]/40">
              Reveal House 🔮
            </button>
          </div>

          {error && <p className="text-red-400 text-sm mt-2 font-medium">{error}</p>}
        </form>
      ) : (
        <div className="mt-8 space-y-8 animate-fade-in-up">
          {/* Result Hero Card */}
          <div 
            className="rounded-3xl p-6 sm:p-8 relative overflow-hidden backdrop-blur-md"
            style={{ 
              background: `linear-gradient(135deg, ${result.house.accentHex}40, #FF7AB625, #57D7FF20)`,
              border: `1px solid ${result.house.accentHex}60`,
              boxShadow: `0 10px 40px -10px ${result.house.accentHex}40`
            }}
          >
            <div className="relative z-10 flex flex-col items-center text-center">
              <span className="text-sm font-bold uppercase tracking-widest opacity-80 mb-4" style={{ color: '#ffffff' }}>Your Mahar Bote House</span>
              <div className="text-6xl mb-4 animate-float filter drop-shadow-xl">{result.house.emoji}</div>
              <h3 className="text-3xl sm:text-4xl font-black mb-3 text-white drop-shadow-md">
                {result.house.englishName} • <span className="font-normal opacity-90">{result.house.myanmarName}</span>
              </h3>
              <p className="text-base sm:text-lg max-w-xl text-white/90 leading-relaxed font-medium">
                {result.house.vibe}
              </p>
            </div>
            {/* Subtle background glow */}
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full h-full bg-gradient-to-t from-black/20 to-transparent pointer-events-none rounded-3xl" />
          </div>

          {/* Facts Pills */}
          <div className="flex flex-wrap gap-2">
            {[
              { icon: '📅', label: formatDate(birthDate) },
              { icon: '🗓️', label: `Born on ${WEEKDAYS[result.isoWeekday].en} • ${WEEKDAYS[result.isoWeekday].my}` },
              { icon: '🇲🇲', label: `Myanmar Year ${result.myanmarYear}` },
              { icon: '➗', label: `Remainder ${result.remainder}` },
              { icon: '🧮', label: `House = (${result.myanmarYear} - ${result.isoWeekday} - 1) % 7` },
            ].map((fact, idx) => (
              <div key={idx} className="flex items-center gap-2 px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm text-white/90 shadow-sm backdrop-blur-sm transition-colors hover:bg-white/10">
                <span>{fact.icon}</span>
                <span className="font-medium">{fact.label}</span>
              </div>
            ))}
          </div>

          {/* Board & Tips Grid */}
          <div className="grid md:grid-cols-2 gap-6">
            
            {/* Board */}
            <div className="glass-card-light p-5 rounded-2xl border border-white/5 relative overflow-hidden">
              <h4 className="font-bold text-lg text-white mb-1">Mahar Bote Board</h4>
              <p className="text-xs text-white/50 mb-4">Traditional house layout referencing the planetary cycle.</p>
              
              <div className="grid grid-cols-3 gap-2">
                {BOARD_LAYOUT.map((houseId, idx) => {
                  if (!houseId) return <div key={idx} className="rounded-xl border border-white/5 bg-black/10 aspect-[1.1]" />;
                  const house = MAHAR_BOTE_HOUSES.find(h => h.id === houseId);
                  const isSelected = result.house.id === houseId;
                  
                  return (
                    <div 
                      key={idx} 
                      className={`relative flex flex-col items-center justify-center rounded-xl transition-all duration-300 aspect-[1.1] ${isSelected ? 'scale-105 shadow-lg z-10' : 'bg-white/5 hover:bg-white/10'}`}
                      style={{ 
                        border: isSelected ? `2px solid ${house.accentHex}` : '1px solid rgba(255,255,255,0.1)',
                        background: isSelected ? `linear-gradient(135deg, ${house.accentHex}40, ${house.accentHex}10)` : undefined,
                        boxShadow: isSelected ? `0 0 20px ${house.accentHex}50` : undefined
                      }}
                    >
                      <span className="text-2xl drop-shadow-md mb-1">{house.emoji}</span>
                      <span className="text-[11px] font-bold text-white tracking-wide">{house.myanmarName}</span>
                      <span className="text-[9px] text-white/70 uppercase">{house.englishName}</span>
                      
                      {isSelected && (
                        <div className="absolute -top-2 -right-2 bg-white text-black text-[9px] font-black px-2 py-0.5 rounded-full shadow-md">
                          YOU
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Insight Tips */}
            <div className="glass-card-light p-5 rounded-2xl border border-white/5">
              <div className="flex items-center gap-3 mb-5">
                <div 
                  className="w-10 h-10 rounded-xl flex items-center justify-center text-xl shadow-inner"
                  style={{ backgroundColor: `${result.house.accentHex}30` }}
                >
                  {result.house.emoji}
                </div>
                <h4 className="font-bold text-lg" style={{ color: result.house.accentHex }}>
                  Vibe Tips for {result.house.englishName}
                </h4>
              </div>

              <div className="space-y-4">
                <div>
                  <h5 className="font-bold text-sm text-white mb-1 tracking-wide">Energy</h5>
                  <p className="text-sm text-white/70 leading-relaxed">{result.house.vibe}</p>
                </div>
                <div>
                  <h5 className="font-bold text-sm text-white mb-1 tracking-wide">Power Move</h5>
                  <p className="text-sm text-white/70 leading-relaxed">{result.house.powerMove}</p>
                </div>
                <div>
                  <h5 className="font-bold text-sm text-white mb-1 tracking-wide">Playful Ritual</h5>
                  <p className="text-sm text-white/70 leading-relaxed">{result.house.playfulTip}</p>
                </div>
              </div>
            </div>

          </div>

          <div className="pt-4 flex justify-start">
            <button
              type="button"
              className="btn-secondary flex items-center gap-2 group transition-all"
              onClick={handleReset}
            >
              <span className="group-hover:-rotate-180 transition-transform duration-500 block">↻</span> Try Another Birthday
            </button>
          </div>
        </div>
      )}
    </section>
  );
}

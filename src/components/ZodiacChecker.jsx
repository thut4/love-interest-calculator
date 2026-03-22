import React, { useState } from 'react';
import {
  getTodayAsISODate,
  getZodiacCompatibilityFromDob,
} from '../data/zodiacData';

const ERROR_MESSAGES = {
  first_invalid_date: 'Person A: please pick a valid date of birth.',
  first_future_date: 'Person A: date of birth cannot be in the future.',
  first_sign_not_found: 'Person A: zodiac sign could not be resolved from that date.',
  second_invalid_date: 'Person B: please pick a valid date of birth.',
  second_future_date: 'Person B: date of birth cannot be in the future.',
  second_sign_not_found: 'Person B: zodiac sign could not be resolved from that date.',
};

function ZodiacPersonCard({ label, profile }) {
  return (
    <article
      className="zodiac-result-card zodiac-person-card animate-fade-in-scale"
      style={{
        '--zodiac-accent': profile.sign.accent,
        '--zodiac-glow': profile.sign.glow,
      }}
    >
      <div className="zodiac-card-orb" aria-hidden="true" />

      <div className="zodiac-result-header">
        <div>
          <p className="zodiac-kicker">{label} · Born on {profile.formattedBirthDate}</p>
          <h3 className="text-2xl font-black" style={{ color: '#ffffff' }}>
            {profile.sign.symbol} {profile.sign.name}
          </h3>
          <p className="zodiac-date-range">{profile.sign.dateRangeLabel}</p>
        </div>

        <span className="zodiac-emoji-pill" aria-label={`${profile.sign.name} icon`}>
          {profile.sign.emoji}
        </span>
      </div>

      <div className="zodiac-stat-grid">
        <div className="zodiac-stat-pill">
          <span>Element</span>
          <strong>{profile.sign.element}</strong>
        </div>
        <div className="zodiac-stat-pill">
          <span>Modality</span>
          <strong>{profile.sign.modality}</strong>
        </div>
        <div className="zodiac-stat-pill">
          <span>Ruling Planet</span>
          <strong>{profile.sign.rulingPlanet}</strong>
        </div>
      </div>

      <div className="zodiac-copy-grid">
        <div>
          <h4 className="zodiac-section-title">General Behavior</h4>
          <ul className="zodiac-list">
            {profile.sign.behaviors.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        </div>

        <div>
          <h4 className="zodiac-section-title">Common Habits</h4>
          <ul className="zodiac-list">
            {profile.sign.habits.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        </div>
      </div>

      <p className="zodiac-cosmic-tip">
        <span>Cosmic note:</span> {profile.sign.cosmicTip}
      </p>
    </article>
  );
}

export default function ZodiacChecker({ onBack }) {
  const [firstDateOfBirth, setFirstDateOfBirth] = useState('');
  const [secondDateOfBirth, setSecondDateOfBirth] = useState('');
  const [matchResult, setMatchResult] = useState(null);
  const [error, setError] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();

    const result = getZodiacCompatibilityFromDob(firstDateOfBirth, secondDateOfBirth);
    if (result.error) {
      setMatchResult(null);
      setError(ERROR_MESSAGES[result.error] || 'Unable to calculate compatibility from those dates.');
      return;
    }

    setError('');
    setMatchResult(result);
  };

  const clearError = () => {
    if (error) setError('');
  };

  return (
    <section className="zodiac-panel glass-card p-6 sm:p-8 animate-fade-in-up">
      <div className="flex items-center justify-between gap-3 flex-wrap">
        <span className="zodiac-mini-tag">Zodiac Sign ✨</span>
        <button className="btn-secondary px-4 py-2 text-sm" onClick={onBack}>
          ← Back to Home
        </button>
      </div>

      <h2 className="text-2xl sm:text-3xl font-black mt-5" style={{ color: '#f8f9ff' }}>
        🌙 Zodiac Compatibility Checker
      </h2>
      <p className="text-sm sm:text-base mt-2 max-w-2xl" style={{ color: '#b8c2e2' }}>
        Enter both exact dates of birth to reveal each Sun sign, then view your astrological
        compatibility vibe with strengths, challenges, and habits guidance.
      </p>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit}>
        <div className="zodiac-input-grid">
          <label htmlFor="zodiac-dob-first" className="zodiac-input-wrap">
            <span className="zodiac-input-label">Your Date of Birth</span>
            <input
              id="zodiac-dob-first"
              className="zodiac-date-input"
              type="date"
              value={firstDateOfBirth}
              onChange={(event) => {
                clearError();
                setFirstDateOfBirth(event.target.value);
              }}
              max={getTodayAsISODate()}
              required
            />
          </label>

          <label htmlFor="zodiac-dob-second" className="zodiac-input-wrap">
            <span className="zodiac-input-label">Your Partner's Date of Birth</span>
            <input
              id="zodiac-dob-second"
              className="zodiac-date-input"
              type="date"
              value={secondDateOfBirth}
              onChange={(event) => {
                clearError();
                setSecondDateOfBirth(event.target.value);
              }}
              max={getTodayAsISODate()}
              required
            />
          </label>
        </div>

        <button type="submit" className="btn-primary whitespace-nowrap">
          Check Compatibility 💘
        </button>

        <p className="text-xs" style={{ color: '#9aa4c7' }}>
          Uses Western tropical zodiac date ranges, elemental pairings, and modality dynamics.
        </p>

        {error && (
          <p className="zodiac-error" role="alert">
            {error}
          </p>
        )}
      </form>

      {matchResult && (
        <div className="mt-7 space-y-6">
          <article className="zodiac-compat-card animate-fade-in-scale">
            <div className="zodiac-match-head">
              <span className="zodiac-pair-pill">
                {matchResult.firstProfile.sign.symbol} {matchResult.firstProfile.sign.name} {matchResult.firstProfile.sign.emoji}
              </span>
              <span className="zodiac-heart-link">💞</span>
              <span className="zodiac-pair-pill">
                {matchResult.secondProfile.sign.symbol} {matchResult.secondProfile.sign.name} {matchResult.secondProfile.sign.emoji}
              </span>
            </div>

            <p className="zodiac-compat-score">{matchResult.compatibility.score}%</p>
            <div className="zodiac-compat-meter" aria-label="compatibility score meter">
              <span style={{ width: `${matchResult.compatibility.score}%` }} />
            </div>

            <h3 className="zodiac-compat-title">
              {matchResult.compatibility.level.emoji} {matchResult.compatibility.level.label}
            </h3>
            <p className="zodiac-compat-description">{matchResult.compatibility.level.description}</p>

            <div className="zodiac-compat-tags">
              <span>{matchResult.compatibility.elementSummary}</span>
              <span>{matchResult.compatibility.modalitySummary}</span>
              {matchResult.compatibility.isOppositePair && <span>Opposite-sign axis</span>}
              {matchResult.compatibility.isSameSign && <span>Same-sign mirror</span>}
            </div>

            <div className="zodiac-compat-grid">
              <div className="zodiac-compat-block">
                <h4>Core Chemistry</h4>
                <p>{matchResult.compatibility.chemistry}</p>
              </div>
              <div className="zodiac-compat-block">
                <h4>Possible Challenge</h4>
                <p>{matchResult.compatibility.challenge}</p>
              </div>
              <div className="zodiac-compat-block">
                <h4>Habits Tip</h4>
                <p>{matchResult.compatibility.habitTip}</p>
              </div>
              <div className="zodiac-compat-block">
                <h4>Modality Insight</h4>
                <p>{matchResult.compatibility.modalityInsight}</p>
              </div>
            </div>
          </article>

          <div className="zodiac-duo-grid">
            <ZodiacPersonCard label="Person A" profile={matchResult.firstProfile} />
            <ZodiacPersonCard label="Person B" profile={matchResult.secondProfile} />
          </div>
        </div>
      )}
    </section>
  );
}

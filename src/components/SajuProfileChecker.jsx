import React, { useEffect, useMemo, useState } from 'react';
import { ELEMENT_META, ELEMENT_ORDER } from '../data/sajuData';
import { calculateSajuProfile } from '../engine/sajuEngine';

const ERROR_MESSAGES = {
  invalid_birth_input: 'Please provide a valid birth date and exact birth time.',
  missing_location: 'Please enter both birth city and birth country.',
  future_birth: 'Birth information cannot be in the future.',
};

const INITIAL_FORM = {
  birthDate: '',
  birthTime: '',
  birthCity: '',
  birthCountry: '',
};

const SAJU_FORM_STORAGE_KEY = 'saju-form-v1';

function loadSavedForm() {
  if (typeof window === 'undefined') return INITIAL_FORM;

  try {
    const raw = window.localStorage.getItem(SAJU_FORM_STORAGE_KEY);
    if (!raw) return INITIAL_FORM;

    const parsed = JSON.parse(raw);
    return {
      birthDate: typeof parsed.birthDate === 'string' ? parsed.birthDate : '',
      birthTime: typeof parsed.birthTime === 'string' ? parsed.birthTime : '',
      birthCity: typeof parsed.birthCity === 'string' ? parsed.birthCity : '',
      birthCountry: typeof parsed.birthCountry === 'string' ? parsed.birthCountry : '',
    };
  } catch {
    return INITIAL_FORM;
  }
}

export default function SajuProfileChecker({ onBack }) {
  const [form, setForm] = useState(loadSavedForm);
  const [profile, setProfile] = useState(null);
  const [error, setError] = useState('');

  const handleChange = (field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    if (error) setError('');
  };

  const handleSubmit = (event) => {
    event.preventDefault();

    const result = calculateSajuProfile(form);
    if (result.error) {
      setProfile(null);
      setError(ERROR_MESSAGES[result.error] || 'Unable to calculate Saju profile.');
      return;
    }

    setError('');
    setProfile(result);
  };

  const maxElementValue = useMemo(() => {
    if (!profile) return 1;
    return Math.max(...Object.values(profile.elementCounts), 1);
  }, [profile]);

  const hasAnyInput = useMemo(() => {
    return Object.values(form).some((value) => value.trim().length > 0) || Boolean(profile);
  }, [form, profile]);

  useEffect(() => {
    if (typeof window === 'undefined') return;
    window.localStorage.setItem(SAJU_FORM_STORAGE_KEY, JSON.stringify(form));
  }, [form]);

  const handleStartNew = () => {
    setForm(INITIAL_FORM);
    setProfile(null);
    setError('');
    if (typeof window !== 'undefined') {
      window.localStorage.removeItem(SAJU_FORM_STORAGE_KEY);
    }
  };

  return (
    <section className="saju-panel glass-card p-6 sm:p-8 animate-fade-in-up">
      <div className="flex items-center justify-between gap-3 flex-wrap">
        <span className="saju-mini-tag">New Feature · 사주 ✨</span>
        <button className="btn-secondary px-4 py-2 text-sm" onClick={onBack}>
          ← Back to Home
        </button>
      </div>

      <h2 className="text-2xl sm:text-3xl font-black mt-5" style={{ color: '#f8f9ff' }}>
        오행 Destiny Energy Profile
      </h2>
      <p className="text-sm sm:text-base mt-2 max-w-3xl" style={{ color: '#b8c2e2' }}>
        Enter your full birth date, exact birth time, and birth city/country to calculate your
        Saju (사주) pillars and Korean Five Elements (오행) balance.
      </p>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit}>
        <div className="saju-form-grid">
          <label className="saju-input-wrap" htmlFor="saju-birth-date">
            <span className="saju-input-label">Full Birth Date</span>
            <input
              id="saju-birth-date"
              className="saju-input"
              type="date"
              value={form.birthDate}
              onChange={(event) => handleChange('birthDate', event.target.value)}
              required
            />
          </label>

          <label className="saju-input-wrap" htmlFor="saju-birth-time">
            <span className="saju-input-label">Exact Birth Time</span>
            <input
              id="saju-birth-time"
              className="saju-input"
              type="time"
              value={form.birthTime}
              onChange={(event) => handleChange('birthTime', event.target.value)}
              required
            />
          </label>

          <label className="saju-input-wrap" htmlFor="saju-birth-city">
            <span className="saju-input-label">Birth City</span>
            <input
              id="saju-birth-city"
              className="saju-input"
              type="text"
              placeholder="e.g., Seoul"
              value={form.birthCity}
              onChange={(event) => handleChange('birthCity', event.target.value)}
              required
            />
          </label>

          <label className="saju-input-wrap" htmlFor="saju-birth-country">
            <span className="saju-input-label">Birth Country</span>
            <input
              id="saju-birth-country"
              className="saju-input"
              type="text"
              placeholder="e.g., South Korea"
              value={form.birthCountry}
              onChange={(event) => handleChange('birthCountry', event.target.value)}
              required
            />
          </label>
        </div>

        <div className="flex flex-wrap gap-3">
          <button type="submit" className="btn-primary">
            Calculate My Saju 🔮
          </button>
          <button
            type="button"
            className="btn-secondary"
            onClick={handleStartNew}
            disabled={!hasAnyInput}
            style={{ opacity: hasAnyInput ? 1 : 0.45 }}
          >
            Start New Reading
          </button>
        </div>

        {error && (
          <p className="saju-error" role="alert">
            {error}
          </p>
        )}
      </form>

      {profile && (
        <div className="mt-8 space-y-6">
          <article className="saju-result-card animate-fade-in-scale">
            <h3 className="saju-section-title">Four Pillars (사주팔자)</h3>
            <div className="saju-pillars-grid">
              {profile.pillars.map((pillar) => (
                <div key={pillar.label} className="saju-pillar-card">
                  <p className="saju-pillar-label">{pillar.label}</p>
                  <p className="saju-pillar-hanja">{pillar.hanja}</p>
                  <p className="saju-pillar-korean">{pillar.korean}</p>
                  <p className="saju-pillar-meta">{pillar.animal} · {pillar.stem.element}/{pillar.branch.element}</p>
                </div>
              ))}
            </div>

            <div className="saju-location-meta">
              {profile.birthLocation.city}, {profile.birthLocation.country} · {profile.timezone}
            </div>
          </article>

          <article className="saju-result-card animate-fade-in-scale">
            <h3 className="saju-section-title">Five Elements Balance (오행)</h3>
            <div className="saju-elements-list">
              {ELEMENT_ORDER.map((element) => {
                const value = profile.elementCounts[element];
                const percent = Math.round((value / maxElementValue) * 100);

                return (
                  <div key={element} className="saju-element-row">
                    <div className="saju-element-head">
                      <span>{ELEMENT_META[element].korean}</span>
                      <span>{value}</span>
                    </div>
                    <div className="saju-element-track">
                      <div
                        className="saju-element-fill"
                        style={{
                          width: `${percent}%`,
                          backgroundColor: ELEMENT_META[element].color,
                        }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>

            <div className="saju-tags-wrap">
              <span className="saju-tag saju-tag-strong">
                Dominant: {ELEMENT_META[profile.dominantElement].korean}
              </span>
              <span className="saju-tag saju-tag-weak">
                Balance Focus: {profile.weakElements.map((item) => ELEMENT_META[item].korean).join(', ')}
              </span>
            </div>
          </article>

          <article className="saju-result-card animate-fade-in-scale">
            <h3 className="saju-section-title">Destiny Energy Interpretation</h3>
            <p className="saju-energy-summary">{profile.energySummary}</p>
            <p className="saju-destiny-copy">{profile.destinyInterpretation}</p>

            <h4 className="saju-advice-title">Personalized Saju Advice</h4>
            <ul className="saju-advice-list">
              {profile.personalizedAdvice.map((tip) => (
                <li key={tip}>{tip}</li>
              ))}
            </ul>

            <div className="saju-note-wrap">
              {profile.notes.map((note) => (
                <p key={note}>{note}</p>
              ))}
            </div>
          </article>

          <article className="saju-result-card animate-fade-in-scale">
            <h3 className="saju-section-title">English Deep Dive (Detailed)</h3>
            <p className="saju-deep-overview">{profile.englishOverview}</p>

            <h4 className="saju-advice-title">Pillar-by-Pillar Insight</h4>
            <div className="saju-deep-grid">
              {profile.pillarDeepDive.map((item) => (
                <div key={item.label} className="saju-deep-card">
                  <p className="saju-deep-label">{item.label}</p>
                  <h5>{item.title}</h5>
                  <p className="saju-deep-blend">{item.hanja} · {item.korean} · {item.englishBlend}</p>
                  <p>{item.summary}</p>
                  <ul>
                    {item.strengths.map((point) => (
                      <li key={point}>{point}</li>
                    ))}
                  </ul>
                  <p className="saju-deep-tip">Growth focus: {item.growthTip}</p>
                </div>
              ))}
            </div>

            <h4 className="saju-advice-title">Element-by-Element Reading</h4>
            <div className="saju-element-deep-grid">
              {profile.elementDeepDive.map((item) => (
                <div key={item.element} className="saju-element-deep-card">
                  <div className="saju-element-deep-head">
                    <strong>{item.korean}</strong>
                    <span>Score {item.score} · {item.status}</span>
                  </div>
                  <p className="saju-element-deep-title">{item.title}</p>
                  <p>{item.summary}</p>
                  <p><span>Strength:</span> {item.strengths}</p>
                  <p><span>When low:</span> {item.lowState}</p>
                  <p><span>Habits:</span> {item.habitFocus}</p>
                  <p><span>Relationship:</span> {item.relationshipTip}</p>
                  <p><span>Career:</span> {item.careerTip}</p>
                  <p><span>Balance action:</span> {item.balanceAction}</p>
                </div>
              ))}
            </div>
          </article>
        </div>
      )}
    </section>
  );
}

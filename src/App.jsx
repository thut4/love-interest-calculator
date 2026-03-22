/**
 * ═══════════════════════════════════════════════════════════════
 *  App.jsx — Love Interest Analyzer
 * ═══════════════════════════════════════════════════════════════
 *
 *  Main orchestrator:
 *    1. Multi-step questionnaire
 *    2. Score calculation via the scoring engine
 *    3. Animated result reveal
 *    4. "Try Again" reset flow
 */
import React, { useState, useCallback, useMemo } from 'react';
import { STEPS } from './engine/scoringConstants';
import { analyzeInterest } from './engine/scoringEngine';

import ProgressBar from './components/ProgressBar';
import FormStep from './components/FormStep';
import ResultView from './components/ResultView';
import BackgroundParticles from './components/BackgroundParticles';
import ZodiacChecker from './components/ZodiacChecker';

// ─── App States ──────────────────────────────────────────────
const VIEW_LANDING = 'landing';
const VIEW_QUIZ = 'quiz';
const VIEW_RESULT = 'result';
const VIEW_ZODIAC = 'zodiac';

export default function App() {
  // Current view: landing → quiz → result
  const [view, setView] = useState(VIEW_LANDING);

  // Quiz state
  const [currentStep, setCurrentStep] = useState(0);
  const [answers, setAnswers] = useState({});
  const [result, setResult] = useState(null);

  // ─── Handlers ──────────────────────────────────────────────

  const handleStart = useCallback(() => {
    setView(VIEW_QUIZ);
    setCurrentStep(0);
    setAnswers({});
    setResult(null);
  }, []);

  const handleAnswer = useCallback((questionId, value) => {
    setAnswers((prev) => ({ ...prev, [questionId]: value }));
  }, []);

  const handleOpenZodiac = useCallback(() => {
    setView(VIEW_ZODIAC);
  }, []);

  // Check if all questions in the current step are answered
  const isStepComplete = useMemo(() => {
    if (view !== VIEW_QUIZ) return false;
    const step = STEPS[currentStep];
    return step.questions.every((q) => answers[q.id] !== undefined);
  }, [view, currentStep, answers]);

  const handleNext = useCallback(() => {
    if (currentStep < STEPS.length - 1) {
      setCurrentStep((s) => s + 1);
    } else {
      // Last step — calculate results
      const analysisResult = analyzeInterest(answers);
      setResult(analysisResult);
      setView(VIEW_RESULT);
    }
  }, [currentStep, answers]);

  const handlePrev = useCallback(() => {
    if (currentStep > 0) {
      setCurrentStep((s) => s - 1);
    }
  }, [currentStep]);

  const handleReset = useCallback(() => {
    setView(VIEW_LANDING);
    setCurrentStep(0);
    setAnswers({});
    setResult(null);
  }, []);

  const subtitle = useMemo(() => {
    if (view === VIEW_ZODIAC) return 'Find zodiac compatibility from two exact dates of birth.';
    if (view !== VIEW_LANDING) return 'Decode the signals. Know where you stand.';
    return '';
  }, [view]);

  // ─── Render ────────────────────────────────────────────────

  return (
    <div className="relative min-h-screen flex flex-col">
      <BackgroundParticles />

      {/* Header */}
      <header className="relative z-10 pt-8 pb-4 px-4 text-center">
        <h1
          className="text-2xl sm:text-3xl font-black tracking-tight"
          style={{
            background: 'linear-gradient(135deg, #bac8ff 0%, #9775fa 50%, #f06595 100%)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
          }}
        >
          💘 Love Interest Analyzer
        </h1>
        {view !== VIEW_LANDING && (
          <p className="text-xs mt-1" style={{ color: '#6b7280' }}>
            {subtitle}
          </p>
        )}
      </header>

      {/* Main Content */}
      <main className="relative z-10 flex-1 flex items-start justify-center px-4 pb-12">
        <div className={`w-full ${view === VIEW_ZODIAC ? 'max-w-5xl' : 'max-w-xl'}`}>

          {/* ── LANDING ─────────────────────────────────── */}
          {view === VIEW_LANDING && (
            <div className="text-center mt-12 sm:mt-20 animate-fade-in-up">
              <div className="text-6xl mb-6 animate-float">💘</div>
              <h2 className="text-3xl sm:text-4xl font-black mb-4" style={{ color: '#f1f3f9' }}>
                Are they into you?
              </h2>
              <p className="text-base sm:text-lg mb-2 max-w-md mx-auto" style={{ color: '#8b95b3' }}>
                Turn confusing relationship signals into clear, actionable insights.
              </p>
              <p className="text-sm mb-10 max-w-sm mx-auto" style={{ color: '#5c6378' }}>
                Answer 15 quick questions about their behavior and get your personalized analysis.
              </p>

              <div className="flex flex-col sm:flex-row gap-3 justify-center">
                <button className="btn-primary text-lg px-10 py-4" onClick={handleStart}>
                  Start Analysis ✨
                </button>
                <button className="btn-secondary text-lg px-10 py-4" onClick={handleOpenZodiac}>
                  Zodiac Vibes 🌙
                </button>
              </div>

              {/* Feature highlights */}
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-14 max-w-2xl mx-auto">
                {[
                  { icon: '📊', label: 'Interest Score' },
                  { icon: '🚩', label: 'Red Flags' },
                  { icon: '💡', label: 'Next Move' },
                  { icon: '♈', label: 'Zodiac Traits' },
                ].map((f) => (
                  <div key={f.label} className="glass-card-light p-4 text-center">
                    <span className="text-2xl block mb-1">{f.icon}</span>
                    <span className="text-[11px] font-medium" style={{ color: '#8b95b3' }}>
                      {f.label}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* ── QUIZ ────────────────────────────────────── */}
          {view === VIEW_QUIZ && (
            <div className="mt-4">
              <div className="flex justify-between items-center mb-4">
                <button className="btn-secondary px-4 py-2 text-sm" onClick={handleReset}>
                  ← Back to Home
                </button>
              </div>
              <ProgressBar
                currentStep={currentStep}
                totalSteps={STEPS.length}
                steps={STEPS}
              />

              <div className="glass-card p-6 sm:p-8">
                <FormStep
                  key={STEPS[currentStep].id}
                  step={STEPS[currentStep]}
                  answers={answers}
                  onChange={handleAnswer}
                />

                {/* Navigation */}
                <div className="flex justify-between items-center mt-8 pt-6" style={{ borderTop: '1px solid rgba(255,255,255,0.06)' }}>
                  <button
                    className="btn-secondary px-6 py-3 text-sm"
                    onClick={handlePrev}
                    disabled={currentStep === 0}
                    style={{ opacity: currentStep === 0 ? 0.3 : 1 }}
                  >
                    ← Back
                  </button>
                  <button
                    className="btn-primary px-8 py-3 text-sm"
                    onClick={handleNext}
                    disabled={!isStepComplete}
                  >
                    {currentStep === STEPS.length - 1 ? 'See Results 🎯' : 'Next →'}
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* ── RESULT ──────────────────────────────────── */}
          {view === VIEW_RESULT && result && (
            <div className="mt-4">
              <ResultView result={result} onReset={handleReset} />
            </div>
          )}

          {/* ── ZODIAC ──────────────────────────────────── */}
          {view === VIEW_ZODIAC && (
            <div className="mt-4">
              <ZodiacChecker onBack={handleReset} />
            </div>
          )}
        </div>
      </main>

      {/* Footer */}
      <footer className="relative z-10 text-center py-6 text-xs" style={{ color: '#3d4663' }}>
        Built with 💜 — For entertainment purposes only
      </footer>
    </div>
  );
}

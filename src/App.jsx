import React, { useState, useCallback, useMemo } from 'react';
import { STEPS } from './engine/scoringConstants';
import { analyzeInterest } from './engine/scoringEngine';

import ProgressBar from './components/ProgressBar';
import FormStep from './components/FormStep';
import ResultView from './components/ResultView';
import BackgroundParticles from './components/BackgroundParticles';
import ZodiacChecker from './components/ZodiacChecker';
import SajuProfileChecker from './components/SajuProfileChecker';
import MaharBoteChecker from './components/MaharBoteChecker';

const VIEW_LANDING = 'landing';
const VIEW_QUIZ = 'quiz';
const VIEW_RESULT = 'result';
const VIEW_ZODIAC = 'zodiac';
const VIEW_SAJU = 'saju';
const VIEW_MAHAR_BOTE = 'mahar_bote';

export default function App() {
  const [view, setView] = useState(VIEW_LANDING);
  const [currentStep, setCurrentStep] = useState(0);
  const [answers, setAnswers] = useState({});
  const [result, setResult] = useState(null);

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

  const handleOpenSaju = useCallback(() => {
    setView(VIEW_SAJU);
  }, []);

  const handleOpenMaharBote = useCallback(() => {
    setView(VIEW_MAHAR_BOTE);
  }, []);

  const isStepComplete = useMemo(() => {
    if (view !== VIEW_QUIZ) return false;
    const step = STEPS[currentStep];
    return step.questions.every((q) => answers[q.id] !== undefined);
  }, [view, currentStep, answers]);

  const handleNext = useCallback(() => {
    if (currentStep < STEPS.length - 1) {
      setCurrentStep((s) => s + 1);
      return;
    }

    const analysisResult = analyzeInterest(answers);
    setResult(analysisResult);
    setView(VIEW_RESULT);
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
    if (view === VIEW_SAJU) return 'Calculate your Saju pillars and Five Elements destiny energy.';
    if (view === VIEW_MAHAR_BOTE) return 'Reveal your Myanmar Baydin house with a playful cosmic snapshot.';
    if (view !== VIEW_LANDING) return 'Decode the signals. Know where you stand.';
    return '';
  }, [view]);

  const containerClass = useMemo(() => {
    if (view === VIEW_SAJU) return 'w-full max-w-5xl';
    if (view === VIEW_ZODIAC || view === VIEW_MAHAR_BOTE) return 'w-full max-w-4xl';
    return 'w-full max-w-xl';
  }, [view]);

  return (
    <div className="relative min-h-screen flex flex-col">
      <BackgroundParticles />

      <header className="relative z-10 pt-8 pb-4 px-4 text-center">
        <h1
          className="text-2xl sm:text-3xl font-black tracking-tight"
          style={{
            background: 'linear-gradient(135deg, #bac8ff 0%, #9775fa 50%, #f06595 100%)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
          }}
        >
          Love Interest Analyzer
        </h1>
        {view !== VIEW_LANDING && (
          <p className="text-xs mt-1" style={{ color: '#6b7280' }}>
            {subtitle}
          </p>
        )}
      </header>

      <main className="relative z-10 flex-1 flex items-start justify-center px-4 pb-12">
        <div className={containerClass}>
          {view === VIEW_LANDING && (
            <div className="text-center mt-12 sm:mt-20 animate-fade-in-up">
              <div className="text-6xl mb-6 animate-float">Love</div>
              <h2 className="text-3xl sm:text-4xl font-black mb-4" style={{ color: '#f1f3f9' }}>
                Choose your love reading
              </h2>
              <p className="text-base sm:text-lg mb-2 max-w-2xl mx-auto" style={{ color: '#8b95b3' }}>
                Explore relationship signals, zodiac chemistry, or Saju destiny energy in one place.
              </p>
              <p className="text-sm mb-10 max-w-2xl mx-auto" style={{ color: '#5c6378' }}>
                Pick the reading that fits your question and get a more personal, guided view of your connection.
              </p>

              <div className="grid gap-4 sm:grid-cols-3 max-w-5xl mx-auto">
                <div className="glass-card-light p-4 sm:p-5 text-left">
                  <button className="btn-primary text-lg px-6 py-4 w-full" onClick={handleStart}>
                    Start Analysis
                  </button>
                  <p className="text-sm mt-4 leading-6" style={{ color: '#8b95b3' }}>
                    Answer 15 quick questions about their behavior and get a personalized analysis of attraction,
                    mixed signals, red flags, and your best next move.
                  </p>
                </div>

                <div className="glass-card-light p-4 sm:p-5 text-left">
                  <button className="btn-secondary text-lg px-6 py-4 w-full" onClick={handleOpenZodiac}>
                    Zodiac Vibes
                  </button>
                  <p className="text-sm mt-4 leading-6" style={{ color: '#8b95b3' }}>
                    Compare two birth dates to discover romantic compatibility, natural chemistry, emotional style,
                    and the strengths and friction points in your zodiac match.
                  </p>
                </div>

                <div className="glass-card-light p-4 sm:p-5 text-left">
                  <button className="btn-secondary text-lg px-6 py-4 w-full" onClick={handleOpenSaju}>
                    Saju Energy
                  </button>
                  <p className="text-sm mt-4 leading-6" style={{ color: '#8b95b3' }}>
                    Enter birth date, time, and place to explore Four Pillars energy, Five Elements balance, destiny
                    patterns, and the deeper timing around your connection.
                  </p>
                </div>

                <div className="glass-card-light p-4 sm:p-5 text-left">
                  <button className="btn-secondary text-lg px-6 py-4 w-full border-[#4DEEAA]/20 hover:border-[#4DEEAA]/50 focus:ring-[#4DEEAA]/50" style={{ color: '#4DEEAA' }} onClick={handleOpenMaharBote}>
                    Mahar Bote
                  </button>
                  <p className="text-sm mt-4 leading-6" style={{ color: '#8b95b3' }}>
                    Pick your birth date to reveal your Myanmar Baydin house, find your cosmic vibe, and discover dynamic planetary influences.
                  </p>
                </div>
              </div>

              <div className="grid grid-cols-2 sm:grid-cols-6 gap-4 mt-14 max-w-5xl mx-auto">
                {[
                  { icon: 'Score', label: 'Interest Score' },
                  { icon: 'Flags', label: 'Red Flags' },
                  { icon: 'Hints', label: 'Next Move' },
                  { icon: 'Star', label: 'Zodiac Traits' },
                  { icon: 'Saju', label: 'Saju Energy' },
                  { icon: 'Mahar', label: 'Mahar Bote' },
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

          {view === VIEW_QUIZ && (
            <div className="mt-4">
              <div className="flex justify-between items-center mb-4">
                <button className="btn-secondary px-4 py-2 text-sm" onClick={handleReset}>
                  Back to Home
                </button>
              </div>

              <ProgressBar currentStep={currentStep} totalSteps={STEPS.length} steps={STEPS} />

              <div className="glass-card p-6 sm:p-8">
                <FormStep
                  key={STEPS[currentStep].id}
                  step={STEPS[currentStep]}
                  answers={answers}
                  onChange={handleAnswer}
                />

                <div
                  className="flex justify-between items-center mt-8 pt-6"
                  style={{ borderTop: '1px solid rgba(255,255,255,0.06)' }}
                >
                  <button
                    className="btn-secondary px-6 py-3 text-sm"
                    onClick={handlePrev}
                    disabled={currentStep === 0}
                    style={{ opacity: currentStep === 0 ? 0.3 : 1 }}
                  >
                    Back
                  </button>
                  <button className="btn-primary px-8 py-3 text-sm" onClick={handleNext} disabled={!isStepComplete}>
                    {currentStep === STEPS.length - 1 ? 'See Results' : 'Next'}
                  </button>
                </div>
              </div>
            </div>
          )}

          {view === VIEW_RESULT && result && (
            <div className="mt-4">
              <ResultView result={result} onReset={handleReset} />
            </div>
          )}

          {view === VIEW_ZODIAC && (
            <div className="mt-4">
              <ZodiacChecker onBack={handleReset} />
            </div>
          )}

          {view === VIEW_SAJU && (
            <div className="mt-4">
              <SajuProfileChecker onBack={handleReset} />
            </div>
          )}

          {view === VIEW_MAHAR_BOTE && (
            <div className="mt-4">
              <MaharBoteChecker onBack={handleReset} />
            </div>
          )}
        </div>
      </main>

      <footer className="relative z-10 text-center py-6 text-xs" style={{ color: '#3d4663' }}>
        Built with care - For entertainment purposes only
      </footer>
    </div>
  );
}

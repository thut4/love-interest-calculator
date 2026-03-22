/**
 * ResultView — Full results display with score, explanation, red flags, and next move.
 *
 * Props:
 *   result     {Object}  — output from analyzeInterest()
 *   onReset    {fn}      — callback to restart the quiz
 */
import React, { useState, useEffect } from 'react';
import ScoreReveal from './ScoreReveal';

export default function ResultView({ result, onReset }) {
    const { score, interest, redFlags, nextMove, confidence } = result;

    // Stagger section reveals
    const [showDetails, setShowDetails] = useState(false);
    useEffect(() => {
        const timer = setTimeout(() => setShowDetails(true), 2200);
        return () => clearTimeout(timer);
    }, []);

    // Copy result to clipboard for sharing
    const handleShare = async () => {
        const text = [
            `💘 Love Interest Analyzer Result`,
            `Score: ${score}/100 — ${interest.label}`,
            ``,
            `${confidence}`,
            ``,
            redFlags.length > 0 ? `🚩 Red Flags:\n${redFlags.map(f => `  • ${f}`).join('\n')}` : '✅ No red flags detected!',
            ``,
            `💡 Next Move: ${nextMove.title}`,
            nextMove.advice,
        ].join('\n');

        try {
            await navigator.clipboard.writeText(text);
            alert('Result copied to clipboard! 📋');
        } catch {
            // Fallback: select-all on a textarea
            const ta = document.createElement('textarea');
            ta.value = text;
            document.body.appendChild(ta);
            ta.select();
            document.execCommand('copy');
            document.body.removeChild(ta);
            alert('Result copied to clipboard! 📋');
        }
    };

    return (
        <div className="max-w-2xl mx-auto px-4">
            {/* Score Circle */}
            <div className="flex justify-center mb-8">
                <ScoreReveal score={score} level={interest.level} />
            </div>

            {/* Interest Badge */}
            <div className="text-center mb-8 animate-fade-in-up" style={{ animationDelay: '1.5s', animationFillMode: 'both' }}>
                <span className={`inline-block px-5 py-2 rounded-full text-sm font-bold badge-${interest.level}`}>
                    {interest.emoji} {interest.label}
                </span>
                <p className="text-sm mt-3" style={{ color: '#a0aec0' }}>
                    {interest.description}
                </p>
            </div>

            {/* Detailed sections — revealed after count-up finishes */}
            {showDetails && (
                <div className="space-y-6">
                    {/* Confidence Explanation */}
                    <div className="glass-card p-6 animate-fade-in-up" style={{ animationDelay: '0ms' }}>
                        <h3 className="text-base font-bold mb-2 flex items-center gap-2" style={{ color: '#dbe4ff' }}>
                            <span>🔍</span> Why this result?
                        </h3>
                        <p className="text-sm leading-relaxed" style={{ color: '#a0aec0' }}>
                            {confidence}
                        </p>
                    </div>

                    {/* Red Flags */}
                    <div className="glass-card p-6 animate-fade-in-up" style={{ animationDelay: '120ms', animationFillMode: 'both' }}>
                        <h3 className="text-base font-bold mb-3 flex items-center gap-2" style={{ color: '#dbe4ff' }}>
                            <span>🚩</span> Red Flags ({redFlags.length})
                        </h3>
                        {redFlags.length === 0 ? (
                            <p className="text-sm" style={{ color: '#51cf66' }}>
                                ✅ No red flags detected — great sign!
                            </p>
                        ) : (
                            <div className="space-y-2">
                                {redFlags.map((flag, idx) => (
                                    <div key={idx} className="red-flag-item animate-fade-in-up" style={{ animationDelay: `${idx * 80}ms`, animationFillMode: 'both' }}>
                                        <span style={{ color: '#ff6b6b', flexShrink: 0 }}>⚠️</span>
                                        <span>{flag}</span>
                                    </div>
                                ))}
                            </div>
                        )}
                    </div>

                    {/* Next Move */}
                    <div className="glass-card p-6 animate-fade-in-up" style={{ animationDelay: '240ms', animationFillMode: 'both' }}>
                        <h3 className="text-base font-bold mb-2 flex items-center gap-2" style={{ color: '#dbe4ff' }}>
                            <span>💡</span> {nextMove.title}
                        </h3>
                        <p className="text-sm mb-4 leading-relaxed" style={{ color: '#a0aec0' }}>
                            {nextMove.advice}
                        </p>
                        <ul className="space-y-2">
                            {nextMove.actions.map((action, idx) => (
                                <li key={idx} className="flex items-start gap-2 text-sm" style={{ color: '#bac8ff' }}>
                                    <span style={{ color: interest.color, flexShrink: 0 }}>→</span>
                                    {action}
                                </li>
                            ))}
                        </ul>
                    </div>

                    {/* Action Buttons */}
                    <div className="flex flex-col sm:flex-row gap-3 justify-center pt-4 pb-8 animate-fade-in-up" style={{ animationDelay: '360ms', animationFillMode: 'both' }}>
                        <button className="btn-secondary" onClick={onReset}>
                            Back to Home
                        </button>
                        <button className="btn-primary" onClick={onReset}>
                            🔄 Try Again
                        </button>
                        <button className="btn-secondary" onClick={handleShare}>
                            📋 Share Result
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

import React, { useEffect, useMemo, useRef, useState } from 'react';
import Editor from '@monaco-editor/react';
import '../styles/ChapterPracticeLab.css';

const PYODIDE_CDN = 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/pyodide.js';

const defaultInstructions = [
'Write a few lines of Python to practice what you just learned.',
'Use the Run button to execute your code. Output appears in the console.',
'Reset restores the starter code if you want a clean slate.',
];

const sanitizeCodeForEmbedding = (code) =>
code
    .split('\n')
    .map((line) => `        ${line}`)
    .join('\n');

const successCelebrations = [
    '🌼 The garden bloomed with your logic!',
    '🌿 Lovely work — the sprouts responded perfectly!',
    '🍃 Your code just unlocked a fresh gust of forest air!',
    '🌸 Another blossom appears thanks to your Python magic!',
    '🪴 Great shot! The seedlings are cheering you on!',
];

const oopsEncouragements = [
    '🛠️ Every gardener makes a few pruning mistakes — try trimming and rerunning.',
    '💧 A little more watering (aka debugging) and this will flourish.',
    '🌱 The soil shifted, but your idea is strong. Adjust and grow again!',
    '🍂 That one fell off the branch. Shake it out and plant a new attempt!',
];

const ChapterPracticeLab = ({
    instructions = defaultInstructions,
    starterCode = 'print("Hello from Code Garden!")',
    language = 'python',
    title = 'Code Garden Lab',
    collapsedInitially = true,
}) => {
    const [code, setCode] = useState(starterCode);
    const [output, setOutput] = useState('');
    const [isRunning, setIsRunning] = useState(false);
    const [pyodideReady, setPyodideReady] = useState(false);
    const [pyodideError, setPyodideError] = useState(null);
    const [loadingPyodide, setLoadingPyodide] = useState(false);
    const [runHistory, setRunHistory] = useState([]);
    const [lastRunStatus, setLastRunStatus] = useState('idle');
    const [isExpanded, setIsExpanded] = useState(!collapsedInitially);
    const isMountedRef = useRef(true);

useEffect(() => {
    isMountedRef.current = true;
    return () => {
    isMountedRef.current = false;
    };
}, []);

useEffect(() => {
    setCode(starterCode);
}, [starterCode]);

useEffect(() => {
    setIsExpanded(!collapsedInitially);
}, [collapsedInitially]);

useEffect(() => {
    let cancelled = false;

    async function ensurePyodide() {
    if (!isExpanded) {
        return;
    }
    if (language !== 'python') {
        return;
    }

    if (window.__pyodideInstance) {
        setPyodideReady(true);
        return;
    }

    if (loadingPyodide) {
        return;
    }

    try {
        setLoadingPyodide(true);
        setPyodideError(null);

        if (!window.loadPyodide) {
        await new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = PYODIDE_CDN;
            script.async = true;
            script.onload = resolve;
            script.onerror = () => reject(new Error('Failed to load Pyodide script.'));
            document.body.appendChild(script);
        });
        }

        const instance = await window.loadPyodide({
        indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/',
        });

        if (!cancelled) {
        window.__pyodideInstance = instance;
        setPyodideReady(true);
        }
    } catch (error) {
        if (!cancelled) {
        console.error('Failed to initialize Pyodide:', error);
        setPyodideError(error);
        }
    } finally {
        if (!cancelled) {
        setLoadingPyodide(false);
        }
    }
    }

    ensurePyodide();

    return () => {
    cancelled = true;
    };
}, [language, loadingPyodide, isExpanded]);

const editorLanguage = useMemo(() => {
    if (language === 'python' || language === 'py') {
    return 'python';
    }
    if (language === 'javascript' || language === 'js') {
    return 'javascript';
    }
    return 'python';
}, [language]);

const codeStats = useMemo(() => {
    const lines = code.split('\n');
    const activeLines = lines.filter((line) => line.trim().length > 0).length;
    const characters = code.length;
    return {
        lines: lines.length,
        activeLines,
        characters,
    };
}, [code]);

const formatTimestamp = (date) =>
    date.toLocaleTimeString([], {
        hour: '2-digit',
        minute: '2-digit',
    });

const pushRunHistory = (entry) => {
    setRunHistory((prev) => {
        const next = [entry, ...prev];
        return next.slice(0, 5);
    });
};

const handleRun = async () => {
    if (language !== 'python') {
    setOutput("⚙️ Only Python execution is currently supported in the Code Garden Lab.");
    return;
    }

    if (!window.__pyodideInstance) {
    setOutput('⏳ Loading the Python runtime. Please try again in a few moments.');
    return;
    }

    setIsRunning(true);
    setOutput('🌿 Running your code...');
    setLastRunStatus('running');

    try {
    const pyodide = window.__pyodideInstance;
    const wrappedCode = `
import sys, io
from contextlib import redirect_stdout, redirect_stderr

_stdout = io.StringIO()
_stderr = io.StringIO()

with redirect_stdout(_stdout):
    with redirect_stderr(_stderr):
${sanitizeCodeForEmbedding(code)}

stdout = _stdout.getvalue()
stderr = _stderr.getvalue()
(stdout, stderr)
`;

    const [stdout, stderr] = await pyodide.runPythonAsync(wrappedCode);
    if (stderr) {
        const trimmedError = stderr.trim();
        const encouragement =
        oopsEncouragements[Math.floor(Math.random() * oopsEncouragements.length)];

        setOutput(`${encouragement}\n\n${trimmedError}`);
        setLastRunStatus('error');
        pushRunHistory({
        id: Date.now(),
        timestamp: new Date(),
        status: 'error',
        message: trimmedError,
        });
    } else {
        const trimmedOutput = stdout.trim();
        const celebration =
        successCelebrations[
            Math.floor(Math.random() * successCelebrations.length)
        ];
        const text =
        trimmedOutput.length > 0
            ? `${celebration}\n\n${trimmedOutput}`
            : `${celebration}\n\n✨ Your code ran successfully, but nothing was printed.`;

        setOutput(text);
        setLastRunStatus('success');
        pushRunHistory({
        id: Date.now(),
        timestamp: new Date(),
        status: 'success',
        message: trimmedOutput.length > 0 ? trimmedOutput : 'No printed output',
        });
    }
    } catch (error) {
    console.error('Execution error:', error);
    const backupMessage =
        error.message || 'An error occurred while executing your code.';
    const encouragement =
        oopsEncouragements[Math.floor(Math.random() * oopsEncouragements.length)];

    setOutput(`${encouragement}\n\n${backupMessage}`);
    setLastRunStatus('error');
    pushRunHistory({
        id: Date.now(),
        timestamp: new Date(),
        status: 'error',
        message: backupMessage,
    });
    } finally {
    if (isMountedRef.current) {
        setIsRunning(false);
    }
    }
};

const handleReset = () => {
    setCode(starterCode);
    setOutput('');
    setLastRunStatus('idle');
};

const renderInstructions = () => {
    if (Array.isArray(instructions)) {
    return (
        <ol className="practice-lab__instruction-list">
        {instructions.map((item, index) => (
            <li key={index}>{item}</li>
        ))}
        </ol>
    );
    }
    return <p>{instructions}</p>;
};

return (
    <div className={`practice-lab ${!isExpanded ? 'is-collapsed' : ''}`}>
    {!isExpanded && (
        <div className="practice-lab__preview">
        <div className="practice-lab__preview-content">
            <div className="practice-lab__preview-glyph" aria-hidden="true">
            🌾
            </div>
            <div>
            <h3>{title}</h3>
            <p>
                Launch the Code Garden Lab when you&apos;re ready to experiment with live code.
            </p>
            <ul>
                <li>Follow the mission brief crafted for this chapter.</li>
                <li>Run Python instantly in the browser with Pyodide.</li>
                <li>Collect bonus seeds by exploring extra challenges.</li>
            </ul>
            </div>
        </div>
        <button
            type="button"
            className="practice-lab__button practice-lab__button--launch"
            onClick={() => setIsExpanded(true)}
        >
            Launch Interactive Lab
        </button>
        </div>
    )}

    {isExpanded && (
        <>
        <div className="practice-lab__hero">
            <div className="practice-lab__hero-main">
            <div className="practice-lab__glyph" aria-hidden="true">
                🌱
            </div>
            <div>
                <span className="practice-lab__eyebrow">Interactive Lab</span>
                <h3>{title}</h3>
                <p className="practice-lab__subtitle">
                Plant new skills by pairing the mission brief with real code experiments.
                </p>
            </div>
            </div>
            <div className="practice-lab__hero-info">
            <span className="practice-lab__chip">Language · {editorLanguage}</span>
            <span className="practice-lab__chip">Lines · {codeStats.lines}</span>
            <span className="practice-lab__chip">Active edits · {codeStats.activeLines}</span>
            <span className="practice-lab__chip">Characters · {codeStats.characters}</span>
            </div>
        </div>

        {language === 'python' && (
            <div
            className={`practice-lab__runtime ${
                pyodideReady ? 'is-ready' : pyodideError ? 'is-error' : ''
            }`}
            >
            <div className="practice-lab__runtime-status">
                {pyodideError
                ? '⚠️ Unable to load the Python runtime. Refresh to try again.'
                : pyodideReady
                ? '✅ Python runtime ready — powered by Pyodide.'
                : '⏳ Preparing the Python runtime…'}
            </div>
            <div className="practice-lab__runtime-meter">
                <span />
            </div>
            </div>
        )}

        <div className="practice-lab__grid">
            <aside className="practice-lab__instructions">
            <div className="practice-lab__instructions-header">
                <h4>Mission Brief</h4>
                <span className="practice-lab__difficulty">Difficulty · Bloom</span>
            </div>
            {renderInstructions()}
            <div className="practice-lab__hint">
                Try editing the code and running it again to see different results.
            </div>
            <div className="practice-lab__quests">
                <h5>Bonus Seeds</h5>
                <ul>
                <li>Add a variable and print it out.</li>
                <li>Write a function that returns a greeting.</li>
                <li>Loop three times and print a numbered message.</li>
                </ul>
            </div>
            </aside>

            <div className="practice-lab__editor">
            <Editor
                height="360px"
                language={editorLanguage}
                value={code}
                theme="vs-dark"
                onChange={(value) => setCode(value ?? '')}
                options={{
                fontSize: 14,
                minimap: { enabled: false },
                scrollBeyondLastLine: false,
                automaticLayout: true,
                }}
            />
            <div className="practice-lab__actions">
                <button
                type="button"
                className="practice-lab__button practice-lab__button--run"
                onClick={handleRun}
                disabled={isRunning || (language === 'python' && !pyodideReady)}
                >
                {isRunning ? 'Running…' : 'Run Code'}
                </button>
                <button
                type="button"
                className="practice-lab__button practice-lab__button--reset"
                onClick={handleReset}
                disabled={isRunning}
                >
                Reset
                </button>
            </div>
            </div>
        </div>

        <div
            className={`practice-lab__console ${
            lastRunStatus === 'success'
                ? 'is-success'
                : lastRunStatus === 'error'
                ? 'is-error'
                : lastRunStatus === 'running'
                ? 'is-running'
                : ''
            }`}
        >
            <div className="practice-lab__console-header">
            <span>Console Output</span>
            {lastRunStatus === 'success' && <span className="practice-lab__console-status">Success</span>}
            {lastRunStatus === 'error' && <span className="practice-lab__console-status">Needs Debugging</span>}
            {lastRunStatus === 'running' && <span className="practice-lab__console-status">Running…</span>}
            </div>
            <pre className="practice-lab__console-body">
            {output || '💡 Your results will appear here.'}
            </pre>
        </div>

        {runHistory.length > 0 && (
            <div className="practice-lab__history">
            <div className="practice-lab__history-header">
                <h4>Recent Runs</h4>
                <span>Newest first · last {runHistory.length} attempts</span>
            </div>
            <ul>
                {runHistory.map((entry) => (
                <li key={entry.id} className={`practice-lab__history-item is-${entry.status}`}>
                    <div className="practice-lab__history-meta">
                    <span className="practice-lab__history-time">
                        {formatTimestamp(entry.timestamp)}
                    </span>
                    <span className="practice-lab__history-status">
                        {entry.status === 'success' ? 'Bloomed' : 'Keep Tinkering'}
                    </span>
                    </div>
                    <p>{entry.message}</p>
                </li>
                ))}
            </ul>
            </div>
        )}
        </>
    )}
    </div>
);
};

export default ChapterPracticeLab;


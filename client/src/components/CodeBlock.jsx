import React, { useState, useEffect, useRef } from 'react';
import '../styles/CodeBlock.css';

const PYODIDE_CDN = 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/pyodide.js';

const CodeBlock = ({ language, code, title, showLineNumbers = true, allowCopy = true }) => {
  const [copied, setCopied] = useState(false);
  const [output, setOutput] = useState('');
  const [isRunning, setIsRunning] = useState(false);
  const [showOutput, setShowOutput] = useState(false);
  const [pyodideReady, setPyodideReady] = useState(false);
  const [loadingPyodide, setLoadingPyodide] = useState(false);
  const isMountedRef = useRef(true);

  useEffect(() => {
    isMountedRef.current = true;
    return () => {
      isMountedRef.current = false;
    };
  }, []);

  useEffect(() => {
    // Only load Pyodide if it's Python and not already loaded
    if (language?.toLowerCase() !== 'python' && language?.toLowerCase() !== 'py') {
      return;
    }

    if (window.__pyodideInstance) {
      setPyodideReady(true);
      return;
    }

    if (loadingPyodide) {
      return;
    }

    async function loadPyodide() {
      try {
        setLoadingPyodide(true);
        
        if (!window.loadPyodide) {
          await new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = PYODIDE_CDN;
            script.async = true;
            script.onload = resolve;
            script.onerror = () => reject(new Error('Failed to load Pyodide'));
            document.body.appendChild(script);
          });
        }

        const instance = await window.loadPyodide({
          indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/',
        });

        if (isMountedRef.current) {
          window.__pyodideInstance = instance;
          setPyodideReady(true);
        }
      } catch (error) {
        console.error('Failed to load Pyodide:', error);
        if (isMountedRef.current) {
          setOutput('⚠️ Failed to load Python runtime. Please refresh the page.');
        }
      } finally {
        if (isMountedRef.current) {
          setLoadingPyodide(false);
        }
      }
    }

    loadPyodide();
  }, [language, loadingPyodide]);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(code);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy code:', err);
    }
  };

  const handleRunCode = async () => {
    const lang = language?.toLowerCase();
    
    if (lang === 'python' || lang === 'py') {
      await runPythonCode();
    } else if (lang === 'javascript' || lang === 'js') {
      await runJavaScriptCode();
    } else {
      setOutput('⚠️ Code execution is only supported for Python and JavaScript.');
      setShowOutput(true);
    }
  };

  const runPythonCode = async () => {
    if (!window.__pyodideInstance) {
      setOutput('⏳ Loading Python runtime... Please wait a moment and try again.');
      setShowOutput(true);
      return;
    }

    setIsRunning(true);
    setOutput('🌿 Running your code...');
    setShowOutput(true);

    try {
      const pyodide = window.__pyodideInstance;
      const wrappedCode = `
import sys, io
from contextlib import redirect_stdout, redirect_stderr

_stdout = io.StringIO()
_stderr = io.StringIO()

with redirect_stdout(_stdout):
    with redirect_stderr(_stderr):
${code.split('\n').map(line => `        ${line}`).join('\n')}

stdout = _stdout.getvalue()
stderr = _stderr.getvalue()
(stdout, stderr)
`;

      const [stdout, stderr] = await pyodide.runPythonAsync(wrappedCode);
      
      if (stderr && stderr.trim()) {
        setOutput(`❌ Error:\n${stderr.trim()}`);
      } else if (stdout && stdout.trim()) {
        setOutput(`✅ Output:\n${stdout.trim()}`);
      } else {
        setOutput('✅ Code executed successfully! (No output)');
      }
    } catch (error) {
      console.error('Execution error:', error);
      setOutput(`❌ Error: ${error.message || 'An error occurred while executing your code.'}`);
    } finally {
      if (isMountedRef.current) {
        setIsRunning(false);
      }
    }
  };

  const runJavaScriptCode = async () => {
    setIsRunning(true);
    setOutput('🌿 Running your code...');
    setShowOutput(true);

    try {
      // Capture console.log output
      const logs = [];
      const originalLog = console.log;
      console.log = (...args) => {
        logs.push(args.map(arg => 
          typeof arg === 'object' ? JSON.stringify(arg, null, 2) : String(arg)
        ).join(' '));
        originalLog(...args);
      };

      // Execute the code
      eval(code);

      // Restore console.log
      console.log = originalLog;

      if (logs.length > 0) {
        setOutput(`✅ Output:\n${logs.join('\n')}`);
      } else {
        setOutput('✅ Code executed successfully! (No output)');
      }
    } catch (error) {
      console.error('Execution error:', error);
      setOutput(`❌ Error: ${error.message || 'An error occurred while executing your code.'}`);
    } finally {
      if (isMountedRef.current) {
        setIsRunning(false);
      }
    }
  };

  const formatCode = (code) => {
    return code.split('\n').map((line, index) => (
      <div key={index} className="code-line">
        {showLineNumbers && (
          <span className="line-number">{index + 1}</span>
        )}
        <span className="line-content">{line}</span>
      </div>
    ));
  };

  return (
    <div className="code-block">
      {title && (
        <div className="code-header">
          <span className="code-title">{title}</span>
          <span className="code-language">{language}</span>
        </div>
      )}
      
      <div className="code-container">
        {allowCopy && (
          <button 
            className={`copy-button ${copied ? 'copied' : ''}`}
            onClick={handleCopy}
            title="Copy code"
          >
            {copied ? '✓ Copied!' : '📋 Copy'}
          </button>
        )}
        
        <pre className={`code-content language-${language}`}>
          <code>
            {showLineNumbers ? formatCode(code) : code}
          </code>
        </pre>
      </div>
      
      <div className="code-footer">
        <button 
          className="try-it-btn"
          onClick={handleRunCode}
          disabled={isRunning || (language?.toLowerCase() === 'python' && !pyodideReady && !loadingPyodide)}
          title={language?.toLowerCase() === 'python' && !pyodideReady ? 'Loading Python runtime...' : 'Run this code'}
        >
          {isRunning ? '⏳ Running...' : loadingPyodide ? '⏳ Loading...' : '🚀 Try it Yourself'}
        </button>
        <span className="code-info">
          {language?.toUpperCase() || 'CODE'} • {code.split('\n').length} lines
        </span>
      </div>

      {showOutput && (
        <div className={`code-output ${isRunning ? 'running' : ''}`}>
          <div className="code-output-header">
            <span>Output</span>
            <button 
              className="code-output-close"
              onClick={() => setShowOutput(false)}
              title="Close output"
            >
              ✕
            </button>
          </div>
          <pre className="code-output-content">
            {output || '💡 Output will appear here...'}
          </pre>
        </div>
      )}
    </div>
  );
};

export default CodeBlock;
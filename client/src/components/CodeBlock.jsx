import React, { useState } from 'react';
import '../styles/CodeBlock.css';

const CodeBlock = ({ language, code, title, showLineNumbers = true, allowCopy = true }) => {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(code);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy code:', err);
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
        <button className="try-it-btn">
          🚀 Try it Yourself
        </button>
        <span className="code-info">
          {language.toUpperCase()} • {code.split('\n').length} lines
        </span>
      </div>
    </div>
  );
};

export default CodeBlock;
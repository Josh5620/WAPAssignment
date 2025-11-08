import React, { createContext, useContext, useState, useEffect } from 'react';

const ThemeContext = createContext();

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};

// --- NEW HIGH-CONTRAST THEMES OBJECT ---
const themes = {
  garden: {
    name: 'Garden Path',
    light: {
      bg: '#EFF1ED', // White smoke
      text: '#373D20', // Drab dark brown
      primary: '#373D20',
      primaryHover: '#717744',
      secondary: '#979A68',
      accent: '#BCBD8B',
      border: '#545A32',
      cardBg: 'rgba(188, 189, 139, 0.3)', // Transparent Sage
      muted: '#939787',
      cursor: '#717744',
      cursorInteractive: '#373D20',
    },
    dark: {
      bg: '#373D20', // Darkest Brown (Page BG)
      text: '#EFF1ED', // Lightest (Text)
      primary: '#BCBD8B', // Bright Sage (Primary Accent)
      primaryHover: '#979A68', // Moss Green
      secondary: '#717744',
      accent: '#998F6F', // Khaki
      border: '#717744', // Reseda Green (Borders)
      cardBg: '#545A32', // Dark Moss (Lighter than BG for cards)
      muted: '#939787',
      cursor: '#BCBD8B',
      cursorInteractive: '#BCBD8B',
    }
  },
  forest: {
    name: 'Deep Forest',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#545A32',
      primaryHover: '#717744',
      secondary: '#979A68',
      accent: '#BCBD8B',
      border: '#545A32',
      cardBg: 'rgba(188, 189, 139, 0.3)',
      muted: '#939787',
      cursor: '#545A32',
      cursorInteractive: '#545A32',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#979A68', // Moss Green
      primaryHover: '#BCBD8B',
      secondary: '#717744',
      accent: '#545A32',
      border: '#717744',
      cardBg: '#545A32', // Dark Moss
      muted: '#939787',
      cursor: '#979A68',
      cursorInteractive: '#979A68',
    }
  },
  sage: {
    name: 'Sage Garden',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#979A68',
      primaryHover: '#717744',
      secondary: '#BCBD8B',
      accent: '#998F6F',
      border: '#979A68',
      cardBg: 'rgba(188, 189, 139, 0.3)',
      muted: '#939787',
      cursor: '#979A68',
      cursorInteractive: '#717744',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#979A68', // Moss Green
      primaryHover: '#BCBD8B',
      secondary: '#717744',
      accent: '#545A32',
      border: '#717744',
      cardBg: '#545A32', // Dark Moss
      muted: '#939787',
      cursor: '#979A68',
      cursorInteractive: '#979A68',
    }
  },
  earth: {
    name: 'Earth Tones',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#766153',
      primaryHover: '#998F6F',
      secondary: '#939787',
      accent: '#BCBD8B',
      border: '#766153',
      cardBg: 'rgba(188, 189, 139, 0.3)',
      muted: '#939787',
      cursor: '#766153',
      cursorInteractive: '#766153',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#998F6F', // Khaki
      primaryHover: '#766153', // Umber
      secondary: '#717744',
      accent: '#545A32',
      border: '#766153',
      cardBg: '#545A32', // Dark Moss
      muted: '#939787',
      cursor: '#998F6F',
      cursorInteractive: '#998F6F',
    }
  },
  khaki: {
    name: 'Khaki Classic',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#998F6F',
      primaryHover: '#766153',
      secondary: '#BCBD8B',
      accent: '#979A68',
      border: '#998F6F',
      cardBg: 'rgba(188, 189, 139, 0.3)',
      muted: '#939787',
      cursor: '#998F6F',
      cursorInteractive: '#766153',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#998F6F', // Khaki
      primaryHover: '#BCBD8B',
      secondary: '#766153',
      accent: '#545A32',
      border: '#766153',
      cardBg: '#545A32', // Dark Moss
      muted: '#939787',
      cursor: '#998F6F',
      cursorInteractive: '#998F6F',
    }
  }
};
// --- END OF NEW THEMES OBJECT ---

export const ThemeProvider = ({ children }) => {
  // (Your existing getValidTheme function is fine)
  const getValidTheme = (themeName, mode) => {
    const validThemeName = themes[themeName] ? themeName : 'garden';
    const validMode = (mode === 'light' || mode === 'dark') ? mode : 'light';
    const themeObj = themes[validThemeName];
    if (!themeObj) {
      return themes.garden.light;
    }
    const modeObj = themeObj[validMode];
    if (!modeObj) {
      return themeObj.light || themes.garden.light;
    }
    return modeObj;
  };

  const [currentTheme, setCurrentTheme] = useState(() => {
    try {
      const saved = localStorage.getItem('theme');
      if (saved) {
        const parsed = JSON.parse(saved);
        const themeName = parsed?.theme;
        const mode = parsed?.mode;
        
        if (themes[themeName] && (mode === 'light' || mode === 'dark')) {
          return { theme: themeName, mode };
        }
        return { theme: 'garden', mode: 'light' };
      }
      return { theme: 'garden', mode: 'light' };
    } catch (error) {
      console.error('Error parsing theme from localStorage:', error);
      return { theme: 'garden', mode: 'light' };
    }
  });

  const theme = getValidTheme(currentTheme.theme, currentTheme.mode);
  
  useEffect(() => {
    const isValidTheme = themes[currentTheme.theme] && 
                        (currentTheme.mode === 'light' || currentTheme.mode === 'dark');
    if (!isValidTheme) {
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
  }, [currentTheme.theme, currentTheme.mode]); // Fixed dependency array

  useEffect(() => {
    const validTheme = theme && typeof theme === 'object' ? theme : themes.garden.light;
    
    if (!theme || typeof theme !== 'object') {
      console.error('Invalid theme object detected, resetting to default');
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
    
    try {
      const isValidTheme = themes[currentTheme.theme] && 
                          (currentTheme.mode === 'light' || currentTheme.mode === 'dark');
      if (isValidTheme) {
        localStorage.setItem('theme', JSON.stringify(currentTheme));
      }
      
      const root = document.documentElement;
      root.style.setProperty('--bg', validTheme.bg);
      root.style.setProperty('--text', validTheme.text);
      root.style.setProperty('--primary', validTheme.primary);
      root.style.setProperty('--primary-hover', validTheme.primaryHover);
      root.style.setProperty('--secondary', validTheme.secondary);
      root.style.setProperty('--accent', validTheme.accent);
      root.style.setProperty('--border', validTheme.border);
      root.style.setProperty('--card-bg', validTheme.cardBg);
      root.style.setProperty('--muted', validTheme.muted);
      root.style.setProperty('--cursor-color', validTheme.cursor);
      root.style.setProperty('--cursor-interactive', validTheme.cursorInteractive);
      
      // NEW: Set card-bg-transparent based on the cardBg
      // This is a guess; you may need to adjust the opacity
      const cardBg = validTheme.cardBg || '#BCBD8B';
      const transparentColor = cardBg.startsWith('#') ? 
        `rgba(${parseInt(cardBg.slice(1, 3), 16)}, ${parseInt(cardBg.slice(3, 5), 16)}, ${parseInt(cardBg.slice(5, 7), 16)}, 0.3)` :
        'rgba(188, 189, 139, 0.3)';
      root.style.setProperty('--card-bg-transparent', transparentColor);

      document.body.style.backgroundColor = validTheme.bg;
      document.body.style.color = validTheme.text;
      
      updateCursorStyles(validTheme);
    } catch (error) {
      console.error('Error applying theme:', error);
      // Fallback to default theme on error
      const fallbackTheme = themes.garden.light;
      const root = document.documentElement;
      // (Fallback styles...)
    }
  }, [currentTheme, theme]); // theme was missing from deps

  const changeTheme = (themeName) => {
    if (themes[themeName]) {
      setCurrentTheme(prev => ({ ...prev, theme: themeName }));
    } else {
      console.warn(`Invalid theme name: ${themeName}, using default`);
      setCurrentTheme(prev => ({ ...prev, theme: 'garden' }));
    }
  };

  const toggleMode = () => {
    setCurrentTheme(prev => ({
      ...prev,
      mode: prev.mode === 'light' ? 'dark' : 'light'
    }));
  };

  // (Your existing updateCursorStyles function is fine)
  const updateCursorStyles = (theme) => {
    const cursorColor = theme.cursor;
    const cursorInteractive = theme.cursorInteractive;
    const style = document.createElement('style');
    style.id = 'dynamic-cursor-styles';
    const oldStyle = document.getElementById('dynamic-cursor-styles');
    if (oldStyle) oldStyle.remove();
    
    style.textContent = `
      html, body {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="[http://www.w3.org/2000/svg](http://www.w3.org/2000/svg)" width="20" height="20" viewBox="0 0 20 20"><rect width="20" height="20" fill="none"/><path d="M10 18 L10 12 M8 14 L10 12 L12 14 M6 10 L10 12 L14 10 M8 8 L10 6 L12 8" stroke="${cursorColor.replace('#', '%23')}" stroke-width="2" fill="none" stroke-linecap="square"/><circle cx="10" cy="6" r="2" fill="${cursorColor.replace('#', '%23')}"/></svg>') 10 10, auto;
      }
      a, button, .clickable, [role="button"], input[type="submit"], input[type="button"], .nav-link, .nav-login, .nav-register {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="[http://www.w3.org/2000/svg](http://www.w3.org/2000/svg)" width="24" height="24" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><circle cx="12" cy="8" r="3" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="12" cy="14" r="3" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="12" cy="20" r="2" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="10" y="6" width="4" height="2" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="10" y="12" width="4" height="2" fill="${cursorInteractive.replace('#', '%23')}"/></svg>') 12 12, pointer;
      }
    `;
    
    document.head.appendChild(style);
  };

  return (
    <ThemeContext.Provider
      value={{
        theme,
        currentTheme: currentTheme.theme,
        mode: currentTheme.mode, // Keep this, as ThemeSelector uses it
        themes: Object.keys(themes),
        themeNames: Object.entries(themes).map(([key, value]) => ({
          key,
          name: value.name
        })),
        changeTheme,
        toggleMode, // Keep this, as ThemeSelector uses it
      }}
    >
      {children}
    </ThemeContext.Provider>
  );
};


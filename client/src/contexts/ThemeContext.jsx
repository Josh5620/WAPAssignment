import React, { createContext, useContext, useState, useEffect } from 'react';

const ThemeContext = createContext();

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};

const themes = {
  garden: {
    name: 'Garden Path',
    light: {
      bg: '#F5F3E6',
      text: '#3F3824',
      primary: '#67754A',
      primaryHover: '#7E8C58',
      secondary: '#9CA47A',
      accent: '#D7DDC1',
      border: '#AFB88C',
      cardBg: '#E7E3CE',
      muted: '#9C9788',
      cursor: '#67754A',
      cursorInteractive: '#3F3824',
      overlay: 'rgba(62, 67, 47, 0.35)',
    },
  },
  sage: {
    name: 'Sage Garden',
    light: {
      bg: '#F6F7F2',
      text: '#3E422D',
      primary: '#8FA67A',
      primaryHover: '#7F966B',
      secondary: '#C6D1AF',
      accent: '#E1E8D0',
      border: '#B1C194',
      cardBg: '#EEF4DE',
      muted: '#9AA18E',
      cursor: '#8FA67A',
      cursorInteractive: '#3E422D',
      overlay: 'rgba(115, 133, 96, 0.35)',
    },
  },
  earth: {
    name: 'Earth Tones',
    light: {
      bg: '#F4EFE9',
      text: '#3C2F25',
      primary: '#8B6F5B',
      primaryHover: '#9C7E67',
      secondary: '#C7A588',
      accent: '#E6D1BE',
      border: '#B5947A',
      cardBg: '#F1E1D3',
      muted: '#A8988C',
      cursor: '#8B6F5B',
      cursorInteractive: '#3C2F25',
      overlay: 'rgba(118, 90, 71, 0.35)',
    },
  },
  canopy: {
    name: 'Canopy Glow',
    light: {
      bg: '#F1F7F2',
      text: '#23312B',
      primary: '#4F7A5A',
      primaryHover: '#5E8B69',
      secondary: '#9EC8A3',
      accent: '#D0E6D4',
      border: '#7AA889',
      cardBg: '#E5F1E6',
      muted: '#8EA195',
      cursor: '#4F7A5A',
      cursorInteractive: '#23312B',
      overlay: 'rgba(63, 99, 76, 0.35)',
    },
  },
  bloom: {
    name: 'Bloom Meadow',
    light: {
      bg: '#FDF6F1',
      text: '#4A3027',
      primary: '#C37A63',
      primaryHover: '#D28870',
      secondary: '#F2C5AE',
      accent: '#F9DEC8',
      border: '#E3AF97',
      cardBg: '#FCE6D7',
      muted: '#B99B8D',
      cursor: '#C37A63',
      cursorInteractive: '#4A3027',
      overlay: 'rgba(180, 116, 95, 0.3)',
    },
  },
};

export const ThemeProvider = ({ children }) => {
  const getValidTheme = (themeName) => {
    const validThemeName = themes[themeName] ? themeName : 'garden';
    const themeObj = themes[validThemeName];
    if (!themeObj) {
      return themes.garden.light;
    }
    return themeObj.light;
  };

  const [currentTheme, setCurrentTheme] = useState(() => {
    try {
      const saved = localStorage.getItem('theme');
      if (saved) {
        const parsed = JSON.parse(saved);
        const themeName = parsed?.theme;
        
        if (themes[themeName]) {
          return { theme: themeName, mode: 'light' };
        }
        return { theme: 'garden', mode: 'light' };
      }
      return { theme: 'garden', mode: 'light' };
    } catch (error) {
      console.error('Error parsing theme from localStorage:', error);
      return { theme: 'garden', mode: 'light' };
    }
  });

  const theme = getValidTheme(currentTheme.theme);
  
  useEffect(() => {
    const isValidTheme = themes[currentTheme.theme];
    if (!isValidTheme) {
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
  }, [currentTheme.theme]);

  useEffect(() => {
    const validTheme = theme && typeof theme === 'object' ? theme : themes.garden.light;
    
    if (!theme || typeof theme !== 'object') {
      console.error('Invalid theme object detected, resetting to default');
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
    
    try {
      const isValidTheme = themes[currentTheme.theme];
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
      root.style.setProperty('--theme-overlay', validTheme.overlay || 'rgba(0,0,0,0.45)');
      
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
      const fallbackTheme = themes.garden.light;
      const root = document.documentElement;
    }
  }, [currentTheme, theme]);

  const changeTheme = (themeName) => {
    if (themes[themeName]) {
      setCurrentTheme({ theme: themeName, mode: 'light' });
    } else {
      console.warn(`Invalid theme name: ${themeName}, using default`);
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
  };

  const updateCursorStyles = (theme) => {
    const cursorColor = theme.cursor;
    const cursorInteractive = theme.cursorInteractive;
    const style = document.createElement('style');
    style.id = 'dynamic-cursor-styles';
    const oldStyle = document.getElementById('dynamic-cursor-styles');
    if (oldStyle) oldStyle.remove();
    
    style.textContent = `
      html, body {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="[http://www.w3.org/2000/svg](http://www.w3.org/2000/svg)" width="28" height="28" viewBox="0 0 28 28"><rect width="28" height="28" fill="none"/><path d="M14 26 L14 17 M11 21 L14 17 L17 21 M9 14 L14 17 L19 14 M11 10 L14 7 L17 10" stroke="${cursorColor.replace('#', '%23')}" stroke-width="2.6" fill="none" stroke-linecap="square"/><circle cx="14" cy="7" r="2.6" fill="${cursorColor.replace('#', '%23')}"/></svg>') 14 14, auto;
      }
      a, button, .clickable, [role="button"], input[type="submit"], input[type="button"], .nav-link, .nav-login, .nav-register {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="[http://www.w3.org/2000/svg](http://www.w3.org/2000/svg)" width="30" height="30" viewBox="0 0 30 30"><rect width="30" height="30" fill="none"/><circle cx="15" cy="9" r="3.5" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="15" cy="16" r="3.5" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="15" cy="23" r="2.8" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="13" y="7" width="4" height="3" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="13" y="14" width="4" height="3" fill="${cursorInteractive.replace('#', '%23')}"/></svg>') 15 15, pointer;
      }
    `;
    
    document.head.appendChild(style);
  };

  return (
    <ThemeContext.Provider
      value={{
        theme,
        currentTheme: currentTheme.theme,
        themes: Object.keys(themes),
        themeNames: Object.entries(themes).map(([key, value]) => ({
          key,
          name: value.name
        })),
        changeTheme,
      }}
    >
      {children}
    </ThemeContext.Provider>
  );
};


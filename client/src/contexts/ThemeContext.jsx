import React, { createContext, useContext, useState, useEffect } from 'react';

const ThemeContext = createContext();

export const useTheme = () => {
const context = useContext(ThemeContext);
if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
}
return context;
};

// Theme definitions based on your color palette
const themes = {
garden: {
    name: 'Garden Path',
    light: {
      bg: '#EFF1ED', // White smoke
      text: '#373D20', // Drab dark brown
      primary: '#373D20',
      primaryHover: '#717744', // Reseda green
      secondary: '#979A68', // Moss green
      accent: '#BCBD8B', // Sage
      border: '#545A32', // Dark moss green
      cardBg: '#BCBD8B',
      muted: '#939787', // Battleship gray
      cursor: '#717744', // Reseda green for contrast
      cursorInteractive: '#373D20', // Dark for buttons
    },
    dark: {
      bg: '#373D20', // Drab dark brown
      text: '#EFF1ED', // White smoke
      primary: '#BCBD8B', // Sage
      primaryHover: '#979A68', // Moss green
      secondary: '#717744', // Reseda green
      accent: '#545A32', // Dark moss green
      border: '#717744',
      cardBg: '#545A32',
      muted: '#939787',
      cursor: '#BCBD8B', // Light sage for contrast
      cursorInteractive: '#BCBD8B', // Light for buttons
    }
  },
  forest: {
    name: 'Deep Forest',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#545A32', // Dark moss green
      primaryHover: '#717744',
      secondary: '#979A68',
      accent: '#BCBD8B',
      border: '#545A32',
      cardBg: '#BCBD8B',
      muted: '#939787',
      cursor: '#545A32',
      cursorInteractive: '#545A32',
    },
    dark: {
      bg: '#545A32', // Dark moss green
      text: '#EFF1ED',
      primary: '#BCBD8B',
      primaryHover: '#979A68',
      secondary: '#717744',
      accent: '#939787',
      border: '#717744',
      cardBg: '#373D20',
      muted: '#766153',
      cursor: '#BCBD8B',
      cursorInteractive: '#BCBD8B',
    }
  },
  sage: {
    name: 'Sage Garden',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#979A68', // Moss green
      primaryHover: '#717744',
      secondary: '#BCBD8B', // Sage
      accent: '#998F6F', // Khaki
      border: '#979A68',
      cardBg: '#BCBD8B',
      muted: '#939787',
      cursor: '#979A68',
      cursorInteractive: '#717744',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#BCBD8B', // Sage
      primaryHover: '#979A68',
      secondary: '#717744',
      accent: '#545A32',
      border: '#717744',
      cardBg: '#545A32',
      muted: '#766153',
      cursor: '#BCBD8B',
      cursorInteractive: '#BCBD8B',
    }
  },
  earth: {
    name: 'Earth Tones',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#766153', // Umber
      primaryHover: '#998F6F', // Khaki
      secondary: '#939787', // Battleship gray
      accent: '#BCBD8B',
      border: '#766153',
      cardBg: '#BCBD8B',
      muted: '#939787',
      cursor: '#766153',
      cursorInteractive: '#766153',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#BCBD8B',
      primaryHover: '#998F6F',
      secondary: '#766153',
      accent: '#545A32',
      border: '#766153',
      cardBg: '#545A32',
      muted: '#939787',
      cursor: '#BCBD8B',
      cursorInteractive: '#BCBD8B',
    }
  },
  khaki: {
    name: 'Khaki Classic',
    light: {
      bg: '#EFF1ED',
      text: '#373D20',
      primary: '#998F6F', // Khaki
      primaryHover: '#766153', // Umber
      secondary: '#BCBD8B',
      accent: '#979A68',
      border: '#998F6F',
      cardBg: '#BCBD8B',
      muted: '#939787',
      cursor: '#998F6F',
      cursorInteractive: '#766153',
    },
    dark: {
      bg: '#373D20',
      text: '#EFF1ED',
      primary: '#BCBD8B',
      primaryHover: '#998F6F',
      secondary: '#766153',
      accent: '#545A32',
      border: '#766153',
      cardBg: '#545A32',
      muted: '#939787',
      cursor: '#BCBD8B',
      cursorInteractive: '#BCBD8B',
    }
  }
};

export const ThemeProvider = ({ children }) => {
  // Helper function to validate and get a safe theme configuration
  const getValidTheme = (themeName, mode) => {
    // Validate theme name exists
    const validThemeName = themes[themeName] ? themeName : 'garden';
    // Validate mode is 'light' or 'dark'
    const validMode = (mode === 'light' || mode === 'dark') ? mode : 'light';
    
    // Get theme with fallback to default
    const themeObj = themes[validThemeName];
    if (!themeObj) {
      return themes.garden.light; // Ultimate fallback
    }
    
    const modeObj = themeObj[validMode];
    if (!modeObj) {
      return themeObj.light || themes.garden.light; // Fallback to light mode
    }
    
    return modeObj;
  };

  const [currentTheme, setCurrentTheme] = useState(() => {
    try {
      const saved = localStorage.getItem('theme');
      if (saved) {
        const parsed = JSON.parse(saved);
        // Validate parsed theme
        const themeName = parsed?.theme;
        const mode = parsed?.mode;
        
        // Validate and return safe theme config
        if (themes[themeName] && (mode === 'light' || mode === 'dark')) {
          return { theme: themeName, mode };
        }
        // If invalid, return default
        return { theme: 'garden', mode: 'light' };
      }
      return { theme: 'garden', mode: 'light' };
    } catch (error) {
      console.error('Error parsing theme from localStorage:', error);
      return { theme: 'garden', mode: 'light' };
    }
  });

  // Get theme with validation - always returns a valid theme object
  const theme = getValidTheme(currentTheme.theme, currentTheme.mode);
  
  // Ensure currentTheme state is valid (fix if invalid)
  useEffect(() => {
    const isValidTheme = themes[currentTheme.theme] && 
                        (currentTheme.mode === 'light' || currentTheme.mode === 'dark');
    if (!isValidTheme) {
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
  }, []);

  useEffect(() => {
    // Safety check: ensure theme is valid before applying
    // getValidTheme always returns a valid theme, but double-check for safety
    const validTheme = theme && typeof theme === 'object' ? theme : themes.garden.light;
    
    // If theme was invalid, fix the state
    if (!theme || typeof theme !== 'object') {
      console.error('Invalid theme object detected, resetting to default');
      setCurrentTheme({ theme: 'garden', mode: 'light' });
    }
    
    try {
      // Save theme preference (only if valid)
      const isValidTheme = themes[currentTheme.theme] && 
                          (currentTheme.mode === 'light' || currentTheme.mode === 'dark');
      if (isValidTheme) {
        localStorage.setItem('theme', JSON.stringify(currentTheme));
      }
      
      // Apply CSS variables
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
      
      // Update body background
      document.body.style.backgroundColor = validTheme.bg;
      document.body.style.color = validTheme.text;
      
      // Update cursor styles dynamically
      updateCursorStyles(validTheme);
    } catch (error) {
      console.error('Error applying theme:', error);
      // Fallback to default theme on error
      const fallbackTheme = themes.garden.light;
      const root = document.documentElement;
      root.style.setProperty('--bg', fallbackTheme.bg);
      root.style.setProperty('--text', fallbackTheme.text);
      root.style.setProperty('--primary', fallbackTheme.primary);
      root.style.setProperty('--primary-hover', fallbackTheme.primaryHover);
      root.style.setProperty('--secondary', fallbackTheme.secondary);
      root.style.setProperty('--accent', fallbackTheme.accent);
      root.style.setProperty('--border', fallbackTheme.border);
      root.style.setProperty('--card-bg', fallbackTheme.cardBg);
      root.style.setProperty('--muted', fallbackTheme.muted);
      root.style.setProperty('--cursor-color', fallbackTheme.cursor);
      root.style.setProperty('--cursor-interactive', fallbackTheme.cursorInteractive);
      document.body.style.backgroundColor = fallbackTheme.bg;
      document.body.style.color = fallbackTheme.text;
    }
  }, [currentTheme, theme]);

  const changeTheme = (themeName) => {
    // Validate theme name before setting
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

  const updateCursorStyles = (theme) => {
    // Create dynamic cursor SVG with current theme colors
    const cursorColor = theme.cursor;
    const cursorInteractive = theme.cursorInteractive;
    
    // Update cursor styles via CSS custom properties
    const style = document.createElement('style');
    style.id = 'dynamic-cursor-styles';
    
    // Remove old styles if exists
    const oldStyle = document.getElementById('dynamic-cursor-styles');
    if (oldStyle) oldStyle.remove();
    
    style.textContent = `
      html, body {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"><rect width="20" height="20" fill="none"/><path d="M10 18 L10 12 M8 14 L10 12 L12 14 M6 10 L10 12 L14 10 M8 8 L10 6 L12 8" stroke="${cursorColor.replace('#', '%23')}" stroke-width="2" fill="none" stroke-linecap="square"/><circle cx="10" cy="6" r="2" fill="${cursorColor.replace('#', '%23')}"/></svg>') 10 10, auto;
      }
      a, button, .clickable, [role="button"], input[type="submit"], input[type="button"], .nav-link, .nav-login, .nav-register {
        cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><circle cx="12" cy="8" r="3" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="12" cy="14" r="3" fill="${cursorInteractive.replace('#', '%23')}"/><circle cx="12" cy="20" r="2" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="10" y="6" width="4" height="2" fill="${cursorInteractive.replace('#', '%23')}"/><rect x="10" y="12" width="4" height="2" fill="${cursorInteractive.replace('#', '%23')}"/></svg>') 12 12, pointer;
      }
    `;
    
    document.head.appendChild(style);
  };

  return (
    <ThemeContext.Provider
      value={{
        theme,
        currentTheme: currentTheme.theme,
        mode: currentTheme.mode,
        themes: Object.keys(themes),
        themeNames: Object.entries(themes).map(([key, value]) => ({
          key,
          name: value.name
        })),
        changeTheme,
        toggleMode,
      }}
    >
      {children}
    </ThemeContext.Provider>
  );
};


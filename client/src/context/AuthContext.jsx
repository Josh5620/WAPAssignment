import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { clear, getUser, setToken, setUser as persistUser } from '../utils/auth';

const AuthContext = createContext(null);

const deriveRole = (payload) => {
  if (!payload) return null;
  const source = payload.user ?? payload;
  const roleValue = source.role ?? source.Role ?? payload.role ?? payload.Role;
  return typeof roleValue === 'string' ? roleValue.toLowerCase() : null;
};

const extractProfile = (payload) => {
  if (!payload) return null;
  return payload.user ?? payload;
};

export const AuthProvider = ({ children }) => {
  const storedPayload = getUser();
  const [profile, setProfile] = useState(() => extractProfile(storedPayload));
  const [role, setRole] = useState(() => deriveRole(storedPayload));

  const syncFromStorage = useCallback(() => {
    const nextPayload = getUser();
    setProfile(extractProfile(nextPayload));
    setRole(deriveRole(nextPayload));
  }, []);

  useEffect(() => {
    window.addEventListener('storage', syncFromStorage);
    return () => window.removeEventListener('storage', syncFromStorage);
  }, [syncFromStorage]);

  const login = useCallback(
    (authPayload) => {
      if (!authPayload) {
        syncFromStorage();
        return;
      }

      const token =
        authPayload.access_token ||
        authPayload.token ||
        authPayload.accessToken ||
        authPayload.jwt ||
        null;

      if (token) {
        setToken(token);
      }

      persistUser(authPayload);
      setProfile(extractProfile(authPayload));
      setRole(deriveRole(authPayload));
    },
    [syncFromStorage],
  );

  const logout = useCallback(() => {
    clear();
    setProfile(null);
    setRole(null);
  }, []);

  const value = useMemo(
    () => ({
      user: profile,
      role,
      isLoggedIn: Boolean(profile),
      login,
      logout,
    }),
    [profile, role, login, logout],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

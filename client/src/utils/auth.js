const TOKEN_KEY = 'access_token';
const USER_KEY = 'user_profile';

export const setToken = (token) => {
  console.log('💾 auth.js setToken() called with:', token);
  if (token) {
    localStorage.setItem(TOKEN_KEY, token);
    console.log('✅ Token stored in localStorage with key:', TOKEN_KEY);
  } else {
    localStorage.removeItem(TOKEN_KEY);
    console.log('🗑️ Token removed from localStorage');
  }
};

export const getToken = () => {
  const token = localStorage.getItem(TOKEN_KEY);
  console.log('🔍 auth.js getToken() returning:', token ? `${token.substring(0, 20)}...` : 'null');
  return token;
};

export const setUser = (user) => {
  console.log('👤 auth.js setUser() called with:', user);
  if (user) {
    localStorage.setItem(USER_KEY, JSON.stringify(user));
    console.log('✅ User stored in localStorage with key:', USER_KEY);
  } else {
    localStorage.removeItem(USER_KEY);
    console.log('🗑️ User removed from localStorage');
  }
};

export const getUser = () => {
  const raw = localStorage.getItem(USER_KEY);
  if (!raw) {
    console.log('🔍 auth.js getUser() - no user in localStorage');
    return null;
  }
  try {
    const parsed = JSON.parse(raw);
    console.log('🔍 auth.js getUser() returning:', parsed);
    return parsed;
  } catch (error) {
    console.error('Failed to parse stored user', error);
    return null;
  }
};

export const clear = () => {
  localStorage.removeItem(TOKEN_KEY);
  localStorage.removeItem(USER_KEY);
};

export const isTeacher = () => {
  const user = getUser();
  const role = user?.role || user?.Role;
  return role === 'teacher' || role === 'Teacher';
};

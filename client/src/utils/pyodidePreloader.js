/**
 * Pyodide Preloader Utility
 * Preloads Pyodide in the background so it's ready when users need it
 */

const PYODIDE_CDN = 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/pyodide.js';
const PYODIDE_INDEX_URL = 'https://cdn.jsdelivr.net/pyodide/v0.23.4/full/';

let preloadPromise = null;
let isPreloading = false;

/**
 * Preload Pyodide in the background
 * Safe to call multiple times - will reuse existing promise
 */
export async function preloadPyodide() {
  // If already loaded, return immediately
  if (window.__pyodideInstance) {
    return window.__pyodideInstance;
  }

  // If already preloading, return the existing promise
  if (preloadPromise) {
    return preloadPromise;
  }

  // If already loading, wait a bit and check again
  if (isPreloading) {
    return new Promise((resolve) => {
      const checkInterval = setInterval(() => {
        if (window.__pyodideInstance) {
          clearInterval(checkInterval);
          resolve(window.__pyodideInstance);
        } else if (!isPreloading) {
          clearInterval(checkInterval);
          // Retry preloading
          preloadPyodide().then(resolve);
        }
      }, 500);
    });
  }

  isPreloading = true;

  preloadPromise = (async () => {
    try {
      // Load the Pyodide script if not already loaded
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

      // Initialize Pyodide
      const instance = await window.loadPyodide({
        indexURL: PYODIDE_INDEX_URL,
      });

      window.__pyodideInstance = instance;
      isPreloading = false;
      return instance;
    } catch (error) {
      isPreloading = false;
      preloadPromise = null; // Reset so we can retry
      console.error('Failed to preload Pyodide:', error);
      throw error;
    }
  })();

  return preloadPromise;
}

/**
 * Check if Pyodide is ready
 */
export function isPyodideReady() {
  return !!window.__pyodideInstance;
}

/**
 * Check if Pyodide is currently loading
 */
export function isPyodideLoading() {
  return isPreloading || !!preloadPromise;
}


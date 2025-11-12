import { useState, useRef, useCallback, useEffect } from 'react';

/**
 * Shared hook that manages profile editing state and interactions.
 * It encapsulates form data management, validation, feedback messaging,
 * and async save handling so student/teacher pages can reuse the logic.
 */
export const useProfileForm = (initialValues = {}) => {
  const [formData, setFormData] = useState(initialValues);
  const [editing, setEditing] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const successTimeoutRef = useRef(null);
  const defaultValuesRef = useRef(initialValues);

  const clearSuccessTimeout = useCallback(() => {
    if (successTimeoutRef.current) {
      clearTimeout(successTimeoutRef.current);
      successTimeoutRef.current = null;
    }
  }, []);

  useEffect(() => () => clearSuccessTimeout(), [clearSuccessTimeout]);

  const beginEdit = useCallback(() => {
    setEditing(true);
    setError(null);
    setSuccess(null);
  }, []);

  const handleChange = useCallback((eventOrName, value) => {
    if (eventOrName && typeof eventOrName === 'object' && 'target' in eventOrName) {
      const { name, value: inputValue } = eventOrName.target;
      setFormData(prev => ({
        ...prev,
        [name]: inputValue,
      }));
      return;
    }

    if (typeof eventOrName === 'string') {
      setFormData(prev => ({
        ...prev,
        [eventOrName]: value,
      }));
    }
  }, []);

  const setErrorMessage = useCallback((message) => {
    if (message) {
      clearSuccessTimeout();
      setSuccess(null);
    }
    setError(message);
  }, [clearSuccessTimeout]);

  const setFormValues = useCallback((values = {}) => {
    setFormData(values);
    defaultValuesRef.current = values;
    setError(null);
    clearSuccessTimeout();
    setSuccess(null);
    setEditing(false);
  }, [clearSuccessTimeout]);

  const cancelEdit = useCallback((values) => {
    setEditing(false);
    setError(null);
    clearSuccessTimeout();
    setSuccess(null);
    setFormData(values ?? defaultValuesRef.current);
  }, [clearSuccessTimeout]);

  const saveProfile = useCallback(async (submitter) => {
    if (!formData.fullName?.trim()) {
      setError('Full name is required.');
      return null;
    }

    if (!formData.email?.trim()) {
      setError('Email is required.');
      return null;
    }

    try {
      setSaving(true);
      setError(null);
      const updatedProfile = await submitter(formData);
      if (!updatedProfile) {
        return null;
      }

      clearSuccessTimeout();
      setSuccess('Profile updated successfully!');
      setEditing(false);
      successTimeoutRef.current = setTimeout(() => {
        setSuccess(null);
        successTimeoutRef.current = null;
      }, 3000);

      defaultValuesRef.current = {
        ...formData,
        ...updatedProfile,
      };
      setFormData(prev => ({
        ...prev,
        ...updatedProfile,
      }));

      return updatedProfile;
    } catch (err) {
      setError(err?.message || 'Failed to update profile. Please try again.');
      return null;
    } finally {
      setSaving(false);
    }
  }, [formData, clearSuccessTimeout]);

  return {
    editing,
    formData,
    saving,
    error,
    success,
    beginEdit,
    cancelEdit,
    handleChange,
    setFormValues,
    saveProfile,
    setErrorMessage,
  };
};

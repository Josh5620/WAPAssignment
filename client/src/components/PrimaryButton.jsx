import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/PrimaryButton.css';

/*
 * A reusable primary CTA button for the Python Garden theme.
 * It uses CSS variables from the global theme.
 */
const PrimaryButton = ({ to, children }) => {
  return (
    <Link to={to} className="btn-primary-garden">
      {children}
    </Link>
  );
};

export default PrimaryButton;

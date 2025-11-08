import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/PrimaryButton.css';

const buildClassName = ({ variant, size, fullWidth, className, disabled }) => {
  const classes = ['btn-garden', `btn-garden--${variant}`, `btn-garden--${size}`];
  if (fullWidth) classes.push('btn-garden--full');
  if (disabled) classes.push('btn-garden--disabled');
  if (className) classes.push(className);
  return classes.join(' ');
};

const PrimaryButton = ({
  to,
  onClick,
  children,
  variant = 'primary',
  size = 'md',
  fullWidth = false,
  className = '',
  type = 'button',
  disabled = false,
  ...rest
}) => {
  const buttonClassName = buildClassName({ variant, size, fullWidth, className, disabled });

  if (to) {
    return (
      <Link
        to={disabled ? '#' : to}
        className={buttonClassName}
        aria-disabled={disabled}
        onClick={(event) => {
          if (disabled) {
            event.preventDefault();
          }
          if (onClick) {
            onClick(event);
          }
        }}
        {...rest}
      >
        {children}
      </Link>
    );
  }

  return (
    <button
      type={type}
      className={buttonClassName}
      onClick={onClick}
      disabled={disabled}
      {...rest}
    >
      {children}
    </button>
  );
};

export default PrimaryButton;

import { useNavigate } from "react-router-dom";
import React from "react";
import "../styles/StartChoice.css";

const StartChoice = ({ startLoc, text }) => {
  const navigate = useNavigate();
  const handleLogin = () => {
    navigate(startLoc);
  };

  return (
    <button className="login-choice-button" onClick={handleLogin}>
      {text}
    </button>
  );
};
export default StartChoice;

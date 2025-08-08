import "../styles/ReturnHome.css";
import { useNavigate } from "react-router-dom";
const ReturnHome = () => {
  const navigate = useNavigate();   
  const handleReturnHome = () => {
    navigate("/");
  };

  return (
    <div className="return-home-container">
      <button className="return-home-button" onClick={handleReturnHome}>
        Return Home
      </button>
    </div>
  );
}
export default ReturnHome;
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./pages/Login";
import HomePage from "./pages/HomePage";
import RegisterPage from "./pages/RegisterPage";
import AdminLogin from "./pages/AdminLogin";
import AdminDashboard from "./pages/AdminDashboard";
import ChatBotPopup from "./components/ChatBotPopup";
import ExplainTest from "./pages/ExplainTest";

function App() {
    console.log("App mounted ✅");
  return (
    <>
      <Router>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/teacherLogin" element={<Login />} />
          <Route path="/studentLogin" element={<Login />} />
          <Route path="/admin" element={<AdminLogin />} />
          <Route path="/admin-dashboard" element={<AdminDashboard />} />
          <Route path="/register" element={<RegisterPage />} />
          <Route path="/explainTest" element={<ExplainTest />} />
          <Route path="/home" element={<HomePage />} />
        </Routes>
      </Router>

      <ChatBotPopup />
    </>
  );
}

export default App;

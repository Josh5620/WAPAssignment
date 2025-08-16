import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './pages/Login'
import Home from './pages/Home' 
import RegisterPage from './pages/RegisterPage'
import AdminLogin from './pages/AdminLogin'
import AdminDashboard from './pages/AdminDashboard'
import ChatBotPopup from './components/ChatBotPopup'
import ExplainTest from './pages/ExplainTest'

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route path="/teacherLogin" element={<Login />} />
        <Route path="/studentLogin" element={<Login />} />
        <Route path="/admin" element={<AdminLogin />} />
        <Route path="/admin-dashboard" element={<AdminDashboard />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/explainTest" element={<ExplainTest />} />
        <Route path="/" element={<Home/>} />
      </Routes>
    </Router>
    <ChatBotPopup></ChatBotPopup>
    </>
  )
}

export default App

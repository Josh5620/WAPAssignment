import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './pages/Login'
import HomePage from './pages/HomePage' 
import RegisterPage from './pages/RegisterPage'
import AdminLogin from './pages/AdminLogin'
import ChatBotPopup from './components/ChatBotPopup'

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route path="/teacherLogin" element={<Login />} />
        <Route path="/studentLogin" element={<Login />} />
        <Route path="/admin" element={<AdminLogin />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/" element={<HomePage/>} />
      </Routes>
    </Router>
    <ChatBotPopup></ChatBotPopup>
    </>
  )
}

export default App

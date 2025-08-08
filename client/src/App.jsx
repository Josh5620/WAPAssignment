import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './pages/Login'
import Home from './pages/Home' 
import RegisterPage from './pages/RegisterPage'
import AdminLogin from './pages/AdminLogin'

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/teacherLogin" element={<Login />} />
        <Route path="/studentLogin" element={<Login />} />
        <Route path="/admin" element={<AdminLogin />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/" element={<Home/>} />
      </Routes>
    </Router>
  )
}

export default App

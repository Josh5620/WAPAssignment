import React, { useState } from 'react';
import '../styles/ChatBotPopup.css';
import Message from './Message';

const ChatBotPopup = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState([
    { id: 1, text: "Hello! How can I help you today?", sender: "bot", timestamp: new Date() },
  ]);
  const [inputText, setInputText] = useState('');
// add it so that the first msg sends the instructions taht gets its json txt dropped. 
  const toggleChat = () => {
    setIsOpen(!isOpen);
  };

  async function fetchBotResponse(sessionid, userMessage) {
    const ret = await fetch("http://localhost:5245/api/chat/send", {
      method: 'POST',
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({ sessionId: sessionid, message: userMessage })
    });

    const data = await ret.json();
    console.log(data)
    return data;
  }


  const sendMessage = (e) => {
    e.preventDefault();
    if (inputText.trim() === '') return;


    const userMessage = {
      id: messages.length + 1,
      text: inputText,
      sender: "user",
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);

    fetchBotResponse("1", userMessage.text).then(data => {
      const botResponse = {
        id: messages.length + 2,
        text: data.reply,
        sender: "bot",
        timestamp: new Date()
      };
      setMessages(prev => [...prev, botResponse]);
    }, 1000);

    setInputText('');
  };

  return (
    <>
      {/* Chat Toggle Button */}
      <div className={`chat-toggle ${isOpen ? 'hidden' : ''}`} onClick={toggleChat}>
        <div className="chat-icon">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M20 2H4C2.9 2 2 2.9 2 4V16C2 17.1 2.9 18 4 18H18L22 22V4C22 2.9 21.1 2 20 2ZM20 17.17L18.83 16H4V4H20V17.17Z" fill="white"/>
            <circle cx="7" cy="9" r="1" fill="white"/>
            <circle cx="12" cy="9" r="1" fill="white"/>
            <circle cx="17" cy="9" r="1" fill="white"/>
          </svg>
        </div>
      </div>

      {/* Chat Window */}
      <div className={`chat-window ${isOpen ? 'open' : ''}`}>
        {/* Chat Header */}
        <div className="chat-header">
          <div className="chat-title">
            <div className="bot-avatar">🤖</div>
            <div className="chat-info">
              <h3>Chat Assistant</h3>
              <span className="status">Online</span>
            </div>
          </div>
          <button className="close-button" onClick={toggleChat}>
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 4L4 12M4 4L12 12" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
            </svg>
          </button>
        </div>

        {/* Messages Container */}
        <div className="messages-container">
          {messages.map((message) => (
            <Message key={message.id} message={message} />
          ))}
        </div>

        {/* Input Area */}
        <div className="chat-input-container">
          <form onSubmit={sendMessage} className="chat-form">
            <input
              type="text"
              value={inputText}
              onChange={(e) => setInputText(e.target.value)}
              placeholder="Type your message..."
              className="chat-input"
            />
            <button type="submit" className="send-button" disabled={!inputText.trim()}>
              <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M18 2L9 11M18 2L12 18L9 11M18 2L2 8L9 11" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </button>
          </form>
        </div>
      </div>

      {/* Overlay */}
      {isOpen && <div className="chat-overlay" onClick={toggleChat}></div>}
    </>
  );
};

export default ChatBotPopup;

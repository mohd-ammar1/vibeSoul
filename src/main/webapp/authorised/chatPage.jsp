<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0; padding: 0;
            background: #f5f5f5;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 24px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        nav a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }
        .chat-section {
            margin-top: 20px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .chat-info {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 16px;
        }
        #chatInput {
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 10px;
            resize: vertical;
        }
        #sendMessageButton, #leaveChatButton {
            padding: 8px 16px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 8px;
        }
        #leaveChatButton {
            background: #dc3545;
        }
        form {
            margin-top: 24px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <nav>
                <ul>
                    <li><a href="#">Online</a></li>
                    <li><a href="#">Chats</a></li>
                    <li><a href="#">Groups</a></li>
                </ul>
            </nav>
            <div>
                <%
                    String user = (String) session.getAttribute("username");
                %>
                <c:if test="${not empty user}">
                    Welcome, <strong>${user}</strong>!
                </c:if>
            </div>
        </div>

        <div class="chat-section">
            <div class="chat-info">
                <strong>Current Chat:</strong> <span id="currentChat">General</span>
                <button id="leaveChatButton">Leave Chat</button>
                <span id="chatStatus">Active</span>
                <span id="chatParticipants">5 participants</span>
            </div>
            <textarea id="chatInput" rows="4" cols="50" placeholder="Type your message..."></textarea>
            <button id="sendMessageButton">Send</button>
        </div>

        <form action="#" method="post">
            <!-- Form fields -->
        </form>
    </div>
</body>
</html>
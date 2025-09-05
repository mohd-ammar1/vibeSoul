<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        username = "Guest" + System.currentTimeMillis();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>VibeSoul Chat</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body, html {
    height: 100%;
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f0f2f5;
}

/* Sidebar */
#sidebar {
    background-color: #fff;
    height: 100vh;
    overflow-y: auto;
    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    transition: all 0.3s;
}
#sidebarContent .list-group-item {
    border-radius: 12px;
    margin: 5px 10px;
    cursor: pointer;
    transition: all 0.2s;
}
#sidebarContent .list-group-item:hover {
    background-color: #e0f0ff;
    transform: translateX(3px);
}

/* Chat Header */
#chatHeader {
    background-color: #075e54;
    color: white;
    padding: 15px;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Chat messages area */
#chatLog {
    background-color: #e5ddd5;
    padding: 15px;
    height: calc(100vh - 130px);
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 8px;
}

/* Chat bubbles */
.chat-bubble {
    padding: 10px 15px;
    border-radius: 20px;
    max-width: 70%;
    word-wrap: break-word;
    position: relative;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeSlide 0.3s forwards;
}
.chat-bubble.you {
    background-color: #dcf8c6;
    color: black;
    align-self: flex-end;
    border-bottom-right-radius: 5px;
}
.chat-bubble.them {
    background-color: #ffffff;
    color: black;
    align-self: flex-start;
    border-bottom-left-radius: 5px;
}
.message-time {
    font-size: 0.65rem;
    color: gray;
    margin-top: 2px;
    display: block;
    text-align: right;
}

/* Message input */
#message {
    border-radius: 50px;
}
#sendBtn {
    border-radius: 50px;
    background-color: #075e54;
    color: white;
}

/* Animations */
@keyframes fadeSlide {
    to { opacity: 1; transform: translateY(0); }
}

/* Mobile sidebar */
@media(max-width:768px){
    #sidebar {
        position: absolute;
        z-index: 1000;
        left: -260px;
        width: 260px;
        height: 100%;
    }
    #sidebar.show {
        left: 0;
    }
}
</style>

<script>
window.username = "<%= username %>";
</script>
</head>

<body class="d-flex">

<!-- Sidebar -->
<div id="sidebar" class="border-end">
    <div class="d-flex justify-content-between align-items-center p-3 border-bottom" style="background-color:#075e54; color:white;">
        <span class="fw-bold">Online Users</span>
        <button class="btn btn-light btn-sm d-md-none" onclick="toggleSidebar()">✕</button>
    </div>
    <div id="sidebarContent" class="list-group list-group-flush mt-2"></div>
</div>

<!-- Chat Area -->
<div class="flex-grow-1 d-flex flex-column">
    <!-- Chat Header -->
    <div id="chatHeader">
        <span>Select a user to chat</span>
        <button class="btn btn-light btn-sm d-md-none" onclick="toggleSidebar()">☰ Users</button>
    </div>

    <!-- Chat Messages -->
    <div id="chatLog" class="d-flex flex-column flex-grow-1 px-3 py-2"></div>

    <!-- Message Input -->
    <div class="d-flex p-3 border-top bg-white">
        <input type="text" id="message" class="form-control me-2" placeholder="Type a message..." onkeydown="if(event.key==='Enter') sendMessage(currentChatUser)">
        <button id="sendBtn" class="btn" onclick="sendMessage(currentChatUser)">Send</button>
    </div>
</div>

<script type="text/javascript" src="script.js"></script>
<script type="text/javascript" src="encryption.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("show");
}
</script>
</body>
</html>

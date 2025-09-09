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
/* Default tab style */
.nav-tabs .nav-link {
    border: none;
    color: rgba(255, 255, 255, 0.8); /* Light white for inactive */
    background: transparent;
    font-weight: 500;
    padding: 10px;
}

/* Active tab - highlighted */
.nav-tabs .nav-link.active {
    color: #fff !important; /* Solid white text */
    background-color: transparent !important;
    border-bottom: 3px solid #fff !important; /* White underline */
}

/* Hover effect for better UX */
.nav-tabs .nav-link:hover {
    color: #fff !important;
    background-color: rgba(255, 255, 255, 0.1); /* Slight white highlight */
    border-radius: 5px;
}


.tab-section {
    max-height: calc(100vh - 100px);
    overflow-y: auto;
}

.status-circle {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    transition: background-color 0.3s ease;
    background-color: blue;
}

.unread-badge {
    background: red !important;
    color: white !important;
    border-radius: 50% !important;
    padding: 2px 6px !important;
    margin-left: 8px !important;
    font-size: 12px !important;
    display: none; /* Start hidden */
}


</style>

<script>
window.username = "<%= username %>";
</script>
</head>

<body class="d-flex">
<!-- Sidebar -->
<div id="sidebar" class="border-end">

    <!-- Tab Navigation -->
    <div class="p-3 border-bottom" style="background-color:#075e54; color:white;">
        <ul class="nav nav-tabs nav-justified" id="sidebarTabs">
            <li class="nav-item">
                <button class="nav-link active" id="online-tab" >Online</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" id="friends-tab" >Friends</button>
            </li>
        </ul>
    </div>

    <!-- Tab Content Area -->
    <div class="mt-2 px-2">
        <!-- Online Users Section -->
        <div id="onlineUsersSection" class="tab-section">
            <div id="onlineUsersContent" class="list-group list-group-flush"></div>
        </div>

        <!-- Friends Section -->
        <div id="friendsSection" class="tab-section d-none">
            <div id="friendsContent" class="list-group list-group-flush"></div>
        </div>
    </div>
</div>

 <div id="sidebarOverlay" onclick="toggleSidebar()" 
        style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; 
        background:rgba(0,0,0,0.4); z-index:999;"></div>

<!-- Chat Area -->
<div class="flex-grow-1 d-flex flex-column">
    <!-- Chat Header -->
 <div id="chatHeader">
    <span id="chatTitle">Select a user to chat</span>
    <button id="toggleBtn" class="btn btn-light btn-sm d-md-none" onclick="toggleSidebar()">☰ Users</button>
</div>


    <!-- Chat Messages -->
    <div id="chatLog" class="d-flex flex-column flex-grow-1 px-3 py-2"></div>

    <!-- Message Input -->
    <div class="d-flex p-3 border-top bg-white">
        <input type="text" id="message" class="form-control me-2" placeholder="Type a message..." onkeydown="if(event.key==='Enter') sendMessage(currentChatUser)">
        <button id="sendBtn" class="btn" onclick="sendMessage(currentChatUser)">Send</button>
    </div>
</div>
<script src="script.js?v=<%= System.currentTimeMillis() %>"></script>
<script src="encryption.js?v=<%= System.currentTimeMillis() %>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
window.addEventListener("load", () => {
    // sidebar toggle
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        const overlay = document.getElementById("sidebarOverlay");
        sidebar.classList.toggle("show");
        overlay.style.display = sidebar.classList.contains("show") ? "block" : "none";
    }
    window.toggleSidebar = toggleSidebar;

    // Tab switching – safe now that script.js has defined showTab
    document.getElementById("online-tab").addEventListener("click", () => showTab('online'));
    document.getElementById("friends-tab").addEventListener("click", () => showTab('friends'));
});
</script>

</body>
</html>

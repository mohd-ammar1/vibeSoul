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
<script src="https://cdn.tailwindcss.com"></script>
<script type="text/javascript">
    // expose username for script.js
    window.username = "<%= username %>";
</script>
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript" src="encryption.js"></script>
</head>
<body class="h-screen flex">

<!-- Sidebar -->
<div class="w-1/4 bg-gray-100 flex flex-col">
  <!-- Navbar for tabs -->
  <div class="flex justify-around p-2 border-b border-gray-300">
    <button id="onlineTab" class="px-2 py-1 bg-indigo-200 rounded">Online</button>
    <button id="friendsTab" class="px-2 py-1 hover:bg-indigo-100 rounded">Friends</button>
  </div>
  <!-- Content for users -->
  <div id="sidebarContent" class="flex-1 overflow-y-auto p-2">
    <!-- Users will appear here -->
  </div>
</div>

<!-- Chat area -->
<div class="w-3/4 flex flex-col">
  <!-- Chat header -->
  <div id="chatHeader" class="p-4 border-b border-gray-300 font-bold text-lg">Select a user to chat</div>
  <!-- Chat messages -->
  <div id="chatLog" class="flex-1 p-4 overflow-y-auto space-y-2 bg-white"></div>
  <!-- Message input -->
  <div class="p-4 border-t border-gray-300 flex">
    <input id="message" type="text" placeholder="Type a message..." class="flex-1 p-2 border rounded-l">
    <button onclick="sendMessage(currentChatUser)" class="p-2 bg-indigo-500 text-white rounded-r">Send</button>
  </div>
</div>

</body>
</html>

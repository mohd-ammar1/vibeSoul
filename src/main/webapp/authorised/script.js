let username = window.username || prompt("Enter your username");
let ws;
let currentChatUser = null;
let chats = {};

// ===================
// Fecthing current user id
// ===================

fetch(`${window.location.origin}/vibeSoul/Fetchelper`,{
	method : "POST",
	headers :{
		"Content-Type" : "application/json"
	},
	body : JSON.stringify({cusername : username})
})
.then(response => response.json())
.then(data =>{
	window.currentUserId  = data.userid;
});

// ===================
// Fetching Friend List
// ===================
function loadFriendList() {
    return fetch(`${window.location.origin}/vibeSoul/userlist`, { method: "POST", headers: { "Content-Type": "application/json" }})
    .then(response => {
        if (!response.ok) throw new Error("Failed to fetch friends");
        return response.json();
    })
    .then(friends => {
        console.log("Friend list fetched:", friends);
        renderFriendList(friends);
        return friends;
    })
    .catch(err => console.error("Error loading friends:", err));
}

// =================
// Render friend list in sidebar
// =================

function safeId(name) {
    return name.replace(/\s+/g, "_").replace(/[^\w-]/g, "");
}

function renderFriendList(friends) {
    const sidebar = document.getElementById("friendsContent");

    if (!sidebar) {
        console.error("Error: friendsContent element not found in DOM!");
        return;
    }

    sidebar.innerHTML = ""; // Clear previous list

    if (!friends || friends.length === 0) {
        sidebar.innerHTML = `<p class="text-muted text-center">No friends found</p>`;
        return;
    }

    friends.forEach(friend => {
        // Create button for each friend
        const btn = document.createElement("button");
        btn.className = "w-100 text-start p-2 list-group-item d-flex align-items-center";
		btn.id = `friend-${safeId(friend)}`;
        // Create the status indicator circle
        const statusCircle = document.createElement("span");
        statusCircle.className = "status-circle status-unknown me-2";
        statusCircle.id = `status-${safeId(friend)}`;

        // Create the friend name text
        const friendName = document.createElement("span");
        friendName.textContent = friend;

        // Append circle and name to button
        btn.appendChild(statusCircle);
        btn.appendChild(friendName);

        // Handle friend selection
        btn.onclick = () => {
            document.querySelectorAll("#friendsContent button").forEach(b => {
                b.classList.remove("border-2", "border-primary");
            });
            btn.classList.add("border-2", "border-primary");
            openChat(friend);
        };

        sidebar.appendChild(btn);

        // Immediately check and update friend's online status
        checkOnlineStatus(friend);
    });
}


setInterval(() => {
    document.querySelectorAll("#friendsContent button").forEach(btn => {
        const friendName = btn.querySelector("span:not(.status-circle)").textContent;
        checkOnlineStatus(friendName);
    });
}, 5000);




// Load friends automatically when page loads
window.addEventListener("load", loadFriendList);


// ===================
// Friend Status
// ===================

function checkOnlineStatus(friendName) {
    fetch(`${window.location.origin}/vibeSoul/statushandler`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'username=' + encodeURIComponent(friendName)
    })
    .then(res => res.json())
    .then(data => {
        const circle = document.getElementById(`status-${safeId(friendName)}`);
        if (!circle) return;

        if (data.success) {
            if (data.status === 'online') {
                circle.classList.remove("status-unknown", "status-offline");
                circle.classList.add("status-online"); // Online = green
            } else {
                circle.classList.remove("status-unknown", "status-online");
                circle.classList.add("status-offline"); // Offline = red
            }
        } else {
            circle.classList.remove("status-online", "status-offline");
            circle.classList.add("status-unknown"); // Unknown status
        }
    })
    .catch(err => {
        console.error("Status check failed:", err);

        const circle = document.getElementById(`status-${safeId(friendName)}`);
        if (circle) {
            circle.classList.remove("status-online", "status-offline");
            circle.classList.add("status-unknown"); // Show unknown on error
        }
    });
}





// ===================
// WebSocket connect
// ===================
function connect() {
    ws = new WebSocket("ws://" + window.location.host + "/vibeSoul/serverside?user=" + encodeURIComponent(username));

    ws.onopen = function() {
        console.log("Connected as:", username);
    };
	ws.onmessage = function(event) {
	    let data = JSON.parse(event.data);
	    console.log("WebSocket message received:", data); // For debugging
	    
	    if (data.type === "message") {
	        fetch(`${window.location.origin}/vibeSoul/encryptioncontroll`, {
	            method: "POST",
	            headers: { "Content-Type": "application/x-www-form-urlencoded" },
	            body: `action=decrypt&sender=${data.from}&receiver=${username}&message=${encodeURIComponent(data.text)}`
	        })
	        .then(res => res.json())
	        .then(result => {
	            let decryptedText = result.result;
	            unreadmsg();
	            // Make sure chat array exists
	            if (!chats[data.from]) chats[data.from] = [];
	            chats[data.from].push({ sender: data.from, text: decryptedText, time: new Date().toISOString() });
	          
	            // Render only if the chat is open
	            if (currentChatUser === data.from) renderChat(data.from);
	        });
	    } 
	    else if (data.type === "onlinelist") {
	        // Handle online users list from server
			const otherUsers = data.onlineUsers.filter(user => user !== username);
	        console.log("Online users received:", otherUsers);
	        renderUserList(otherUsers); // This will populate the online tab
	    }
	    else {
	        console.log("Other WebSocket message type:", data.type);
	    }
	};

    ws.onerror = function(error) {
        console.error("WebSocket error:", error);
    };

    ws.onclose = function() {
        console.log("WebSocket closed. Reconnecting in 3s...");
        setTimeout(connect, 3000);
    };
}
connect();

// ===================
// Chat functions
// ===================

// send a message
function sendMessage(toUser) {
    const messageBox = document.getElementById("message");
    let message = messageBox.value.trim();
    if (!message) return alert("Message can't be empty");
    if (!toUser) return alert("Select a user first!");

    fetch(`${window.location.origin}/vibeSoul/encryptioncontroll`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `action=encrypt&sender=${username}&receiver=${toUser}&message=${encodeURIComponent(message)}`
    })
    .then(response => response.json())
    .then(data => {
        let encryptedMessage = data.result;
        if (ws.readyState === WebSocket.OPEN) {
            ws.send(JSON.stringify({
                type: "message",
                from: username,
                to: toUser,
                text: encryptedMessage
            }));

            if (!chats[toUser]) chats[toUser] = [];
            chats[toUser].push({ sender: "You", text: message,time:new Date().toISOString() });
            renderChat(toUser);

            messageBox.value = "";
        } else {
            alert("WebSocket not connected!");
        }
    })
    .catch(err => console.error("Encrypt error:", err));
}

// show list of users
function renderUserList(users) {
    const sidebar = document.getElementById("onlineUsersContent");
    sidebar.innerHTML = "";
	

    if (!users || users.length === 0) {
        sidebar.innerHTML = `<p class="text-muted text-center">No online users</p>`;
        return;
    }

    users.forEach(user => {
        const btn = document.createElement("button");
        btn.textContent = user;
        btn.className = "w-100 text-start p-2 list-group-item";
        btn.onclick = () => {
            document.querySelectorAll("#onlineUsersContent button").forEach(b => {
                b.classList.remove("border-2", "border-primary");
            });
            btn.classList.add("border-2", "border-primary");
            openChat(user);
        };
        sidebar.appendChild(btn);
    });
}
// ==============
// open chat with user
// ==============

function openChat(user) {
    currentChatUser = user;
    checkOnlineStatus(user);
    document.getElementById("chatTitle").textContent = "Chat with " + user;

     chats[user] = [];

    // Fetch old messages from backend
    fetch(`${window.location.origin}/vibeSoul/Msghandler`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            sender: username,
            receiver: user
        })
    })
    .then(response => response.json())
    .then(data => {
       
		 chats[user] = data.map(msg => ({
            sender: msg.sender_id === window.currentUserId ? "You" : user,
            text: msg.msgText,
            time: msg.sent_at
        }));

        // Sort by time
        chats[user].sort((a, b) => new Date(a.time) - new Date(b.time));

        renderChat(user);
        readmessage();
    })
    .catch(err => console.error("Error fetching chat:", err));

    // Mobile experience
    if (window.innerWidth <= 768) {
        document.getElementById("sidebar").classList.remove("show");
        const overlay = document.getElementById("sidebarOverlay");
        if (overlay) overlay.style.display = "none";
    }
}



//  render messages for current user
function renderChat(user) {
    const chatLog = document.getElementById("chatLog");
    chatLog.innerHTML = "";

    chats[user].forEach(msg => {
        const div = document.createElement("div");
        div.className = "d-flex mb-2";

        // Format timestamp
        let timeStr = "";
        if (msg.time) {
            const msgDate = new Date(msg.time);
            const now = new Date();

            const hours = msgDate.getHours();
            const minutes = msgDate.getMinutes().toString().padStart(2, '0');
            const ampm = hours >= 12 ? 'PM' : 'AM';
            const formattedHours = hours % 12 || 12;
            const timePart = `${formattedHours}:${minutes} ${ampm}`;

            const isToday = msgDate.toDateString() === now.toDateString();
            const yesterday = new Date();
            yesterday.setDate(now.getDate() - 1);
            const isYesterday = msgDate.toDateString() === yesterday.toDateString();

            if (isToday) {
                timeStr = timePart;
            } else if (isYesterday) {
                timeStr = `Yesterday ${timePart}`;
            } else {
                const day = msgDate.getDate().toString().padStart(2, '0');
                const month = (msgDate.getMonth() + 1).toString().padStart(2, '0');
                const year = msgDate.getFullYear();
                timeStr = `${day}/${month}/${year} ${timePart}`;
            }
        }

        // Create message bubble
        const bubble = document.createElement("div");
        bubble.classList.add("px-3", "py-2", "rounded-3");
        bubble.style.maxWidth = "75%";
        bubble.style.wordWrap = "break-word";
        bubble.style.animation = "fadeSlide 0.3s";

        const timeSpan = document.createElement("span");
        timeSpan.className = "text-muted small";
        timeSpan.style.display = "block";
        timeSpan.style.marginTop = "2px";
        timeSpan.textContent = timeStr;

        bubble.innerHTML = `<p class="mb-0">${msg.text}</p>`;
        bubble.appendChild(timeSpan);

        // Sent vs Received
        if (msg.sender === "You") {
            div.classList.add("justify-content-end");
            bubble.classList.add("bg-success", "text-white");
            bubble.style.borderBottomRightRadius = "5px";
        } else {
            div.classList.add("justify-content-start");
            bubble.classList.add("bg-light", "text-dark");
            bubble.style.borderBottomLeftRadius = "5px";
        }

        div.appendChild(bubble);
        chatLog.appendChild(div);
    });

    // Scroll to latest message
    chatLog.scrollTop = chatLog.scrollHeight;
}

// Add fadeSlide animation
const style = document.createElement('style');
style.innerHTML = `
@keyframes fadeSlide {
    0% { opacity: 0; transform: translateY(10px); }
    100% { opacity: 1; transform: translateY(0); }
}
.status-circle {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    display: inline-block;
}
.status-online {
    background-color: #28a745;
}
.status-offline {
    background-color: #dc3545;
}
.status-unknown {
    background-color: #6c757d;
}
`;
document.head.appendChild(style);

window.showTab = function (tab) {
    const onlineTab = document.getElementById("online-tab");
    const friendsTab = document.getElementById("friends-tab");

    const onlineSection = document.getElementById("onlineUsersSection");
    const friendsSection = document.getElementById("friendsSection");

    if (tab === 'online') {
        onlineTab.classList.add("active");
        friendsTab.classList.remove("active");

        onlineSection.classList.remove("d-none");
        friendsSection.classList.add("d-none");
    } else {
        friendsTab.classList.add("active");
        onlineTab.classList.remove("active");

        friendsSection.classList.remove("d-none");
        onlineSection.classList.add("d-none");
    }
}
function switchToBackButton() {
    const toggleBtn = document.getElementById("toggleBtn");
    toggleBtn.textContent = "← Back";
    toggleBtn.onclick = () => {
        document.getElementById("sidebar").classList.add("show");
        const overlay = document.getElementById("sidebarOverlay");
        if (overlay) overlay.style.display = "block";

        // Reset back to "☰ Users"
        resetToUsersButton();
    };
}

function resetToUsersButton() {
    const toggleBtn = document.getElementById("toggleBtn");
    toggleBtn.textContent = "☰ Users";
    toggleBtn.onclick = () => toggleSidebar();
}
if (window.innerWidth < 769) {
    switchToBackButton();
}
function unreadmsg() {
    fetch(`${window.location.origin}/vibeSoul/readHandler`)
    .then(response => response.json())
    .then(data => {
        //  hide ALL badges temporarily
        document.querySelectorAll('.unread-badge').forEach(badge => {
            badge.style.display = 'none';
        });
        
        // Update badges from server data
        data.unread_messages.forEach(item => {
            const friendElement = document.getElementById(`friend-${safeId(item.sender_name)}`);
            if (friendElement) {
                let badge = friendElement.querySelector('.unread-badge');
                
                if (!badge) {
                    // Create new badge if it doesn't exist
                    badge = document.createElement('span');
                    badge.className = 'unread-badge';
                    badge.style.background = 'red';
                    badge.style.color = 'white';
                    badge.style.borderRadius = '50%';
                    badge.style.padding = '2px 6px';
                    badge.style.marginLeft = '8px';
                    badge.style.fontSize = '12px';
                    badge.style.display = 'none';
                    friendElement.appendChild(badge);
                }
                
                // Update badge content and show if count > 0
                if (item.unread_count > 0) {
                    badge.textContent = item.unread_count;
                    badge.style.display = 'inline-block';
                } else {
                    badge.style.display = 'none';
                }
            }
        });
    })
    .catch(error => console.error('Error fetching unread counts:', error));
}


window.addEventListener("load", () => {
    loadFriendList().then(() => {
        unreadmsg(); 
        setInterval(unreadmsg, 3000); // refresh every 3 seconds
    });
});

function readmessage(){
    fetch(`${window.location.origin}/vibeSoul/afterRead`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `sender=${encodeURIComponent(currentChatUser)}&receiver=${encodeURIComponent(username)}`
    })
    .then(res => res.json())
    .then(data => {
        if(data.success){
            // Hide the badge for this user
            const badge = document.querySelector(`#friend-${safeId(currentChatUser)} .unread-badge`);
            if(badge) badge.style.display = 'none';
            
            unreadmsg();
        }
    })
    .catch(err => console.error("Mark read error:", err));
}
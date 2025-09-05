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
// WebSocket connect
// ===================
function connect() {
    ws = new WebSocket("ws://" + window.location.host + "/vibeSoul/serverside?user=" + encodeURIComponent(username));

    ws.onopen = function() {
        console.log("Connected as:", username);
    };

    ws.onmessage = function(event) {
        let data;
        try {
            data = JSON.parse(event.data);
        } catch (e) {
            console.error("Invalid message format:", event.data);
            return;
        }

        if (data.type === "onlinelist") {
            renderUserList(data.onlineUsers.filter(u => u !== username)); // exclude yourself
        } else if (data.type === "message") {
            // decrypt incoming
            fetch(`${window.location.origin}/vibeSoul/encryptioncontroll`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `action=decrypt&sender=${username}&receiver=${data.from}&message=${encodeURIComponent(data.text)}`
            })
            .then(response => response.json())
            .then(result => {
                let decryptedText = result.result;
                if (!chats[data.from]) chats[data.from] = [];
                chats[data.from].push({ sender: data.from, text: decryptedText, time: new Date().toISOString() });
                if (currentChatUser === data.from) renderChat(data.from);
            })
            .catch(err => console.error("Decrypt error:", err));
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
// show list of users
function renderUserList(users) {
    const sidebar = document.getElementById("sidebarContent");
    sidebar.innerHTML = "";
    users.forEach(user => {
        const btn = document.createElement("button");
        btn.textContent = user;
        btn.className = "w-full text-left p-2 hover:bg-indigo-100 rounded-lg";
        btn.onclick = () => {
            document.querySelectorAll("#sidebarContent button").forEach(b => {
                b.classList.remove("border-2", "border-indigo-500");
            });
            btn.classList.add("border-2", "border-indigo-500");
            openChat(user);
        };
       sidebar.appendChild(btn);
    });
}

// open chat with user
function openChat(user) {
    currentChatUser = user;

    // Initialize the chat array if it doesn't exist
    if (!chats[user]) chats[user] = [];

    document.getElementById("chatHeader").textContent = "Chat with " + user;

    // Fetch old messages from backend
    fetch(`${window.location.origin}/vibeSoul/Msghandler`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            sender: username,   // logged-in user
            receiver: user      // the user you are chatting with
        })
    })
    .then(response => response.json())
    .then(data => {
        // Map backend messages to match local format
        const backendMessages = data.map(msg => ({
            sender: msg.sender_id === window.currentUserId ? "You" : user,
            text: msg.msgText,
            time: msg.sent_at
        }));

        // Merge local messages (already sent) with backend messages
        // Avoid duplicates by checking timestamp and text
        const combinedMessages = [...chats[user]]; // local messages
        backendMessages.forEach(bMsg => {
            const exists = combinedMessages.some(lMsg => lMsg.text === bMsg.text && lMsg.time === bMsg.time);
            if (!exists) combinedMessages.push(bMsg);
        });

        // Sort all messages by time (oldest first)
        combinedMessages.sort((a, b) => new Date(a.time) - new Date(b.time));

        // Update chats[user] with merged messages
        chats[user] = combinedMessages;

        // Render the chat
        renderChat(user);
    })
    .catch(err => console.error("Error fetching chat:", err));
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
        bubble.classList.add("px-3", "py-2", "rounded-3", "max-w-75", "position-relative");
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

// Add fadeSlide animation (can be placed in <style> or your CSS)
const style = document.createElement('style');
style.innerHTML = `
@keyframes fadeSlide {
    0% { opacity: 0; transform: translateY(10px); }
    100% { opacity: 1; transform: translateY(0); }
}
`;
document.head.appendChild(style);





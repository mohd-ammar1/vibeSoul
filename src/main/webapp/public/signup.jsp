    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Sign Up | vibeSoul</title>
        <!-- tailwind js-->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

        <style>
            body {
                margin: 0;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #3a8ef6, #6f42c1);
                height: 100vh;
                overflow: auto;
            }

            nav {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;
            }

            .main-container {
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding-top: 60px;
            }

            .signup-card {
                background: rgba(255, 255, 255, 0.15);
                border-radius: 20px;
                padding: 40px;
                width: 450px;
                backdrop-filter: blur(12px);
                box-shadow: 0 8px 30px rgba(0,0,0,0.2);
                animation: fadeInUp 1s ease-in-out;
            }

            .signup-card h2 {
                color: #fff;
                font-weight: 700;
                text-align: center;
                margin-bottom: 20px;
            }

            .form-control {
                border-radius: 50px;
                padding: 12px 20px;
                margin-bottom: 15px;
            }

            .btn-custom {
                border-radius: 50px;
                padding: 12px;
                width: 100%;
                font-weight: 600;
                background: linear-gradient(90deg, #3a8ef6, #6f42c1);
                border: none;
                color: #fff;
                transition: all 0.4s ease;
            }

            .btn-custom:hover {
                transform: scale(1.05);
                background: linear-gradient(90deg, #6f42c1, #3a8ef6);
            }
            
            /* Improved message styling */
            #umsg, #mailmsg, #passMsg, #cpassMsg, #otpmsg {
                font-size: 14px;
                margin-top: 5px;
                padding: 8px 12px;
                border-radius: 8px;
                display: none;
                transition: all 0.3s ease;
            }
            
            .success-msg {
                background-color: #d4edda;
                color: #155724;
                border-left: 4px solid #28a745;
            }
            
            .warning-msg {
                background-color: #fff3cd;
                color: #856404;
                border-left: 4px solid #ffc107;
            }
            
            .error-msg {
                background-color: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            .bubble {
                position: absolute;
                border-radius: 50%;
                background: rgba(255,255,255,0.15);
                animation: float 10s infinite;
            }
            .bubble:nth-child(1) { width: 80px; height: 80px; left: 10%; animation-duration: 8s; }
            .bubble:nth-child(2) { width: 120px; height: 120px; left: 70%; animation-duration: 12s; }
            .bubble:nth-child(3) { width: 60px; height: 60px; left: 50%; animation-duration: 10s; }

            @keyframes float {
                0% { bottom: -100px; transform: translateX(0); }
                50% { transform: translateX(40px); }
                100% { bottom: 110%; transform: translateX(-40px); }
            }

            /* --- Friendly Chat Toast --- */
            #toast {
                display: none;
                position: fixed;
                bottom: 20px;
                left: 20px;
                max-width: 280px;
                padding: 14px 18px;
                border-radius: 18px;
                font-size: 15px;
                font-weight: 500;
                color: white;
                box-shadow: 0 4px 15px rgba(0,0,0,0.25);
                animation: fadeInUp 0.5s ease;
            }
            #toast.success { background: #4CAF50; }   /* Green for success */
            #toast.error { background: #E53935; }     /* Red for error */
            #toast.greet { background: #2196F3; }     /* Blue for greetings */

            @keyframes fadeInUp {
                from { opacity: 0; transform: translateY(30px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            /* OTP Container Styles */
            .otp-container {
                display: flex;
                justify-content: space-between;
                margin: 15px 0;
            }
            
            .otp-input {
                width: 45px;
                height: 45px;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                border-radius: 10px;
                border: 2px solid #ddd;
                background: rgba(255, 255, 255, 0.9);
                transition: all 0.3s;
            }
            
            .otp-input:focus {
                border-color: #6f42c1;
                outline: none;
                box-shadow: 0 0 5px rgba(111, 66, 193, 0.5);
                transform: scale(1.05);
            }
            
            .otp-input.filled {
                border-color: #3a8ef6;
                background-color: #e8f0fe;
            }
            
            /* Send OTP Button Styles */
            #sendOtpBtn {
                border-radius: 50px;
                padding: 10px 20px;
                font-weight: 600;
                background: linear-gradient(90deg, #3a8ef6, #6f42c1);
                border: none;
                color: #fff;
                transition: all 0.4s ease;
                margin-top: 10px;
                width: 100%;
            }
            
            #sendOtpBtn:hover:not(:disabled) {
                transform: scale(1.05);
                background: linear-gradient(90deg, #6f42c1, #3a8ef6);
            }
            
            #sendOtpBtn:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
            }
            
            .timer-text {
                color: white;
                text-align: center;
                margin-top: 8px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>

        <%@ include file="navbar.jsp" %>

        <!-- Animated floating bubbles -->
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>

        <!-- Signup card centered -->
        <div class="main-container">
            <div class="signup-card animate__animated animate__fadeInDown">
                <h2> Account</h2>
                <form action="<%=request.getContextPath()%>/signupservlet" method="post"  id="signupform"  onsubmit="return validateForm(event)">
                    <input type="text" name="username" class="form-control" placeholder="Username" id="username" onblur="usernameavail()" required>
                    <p id="umsg"> </p>
                    <input type="email" name="email" id="email" class="form-control" placeholder="Email Address" onblur="emailAvail()" required>
                    <p id ="mailmsg"></p>
                    
                    <!-- OTP Section -->
                    <div class="otp-container" id="otpContainer" style="display:none;">
                        <input type="text" class="otp-input" id="otp1" maxlength="1" oninput="moveToNext(this, 2)">
                        <input type="text" class="otp-input" id="otp2" maxlength="1" oninput="moveToNext(this, 3)">
                        <input type="text" class="otp-input" id="otp3" maxlength="1" oninput="moveToNext(this, 4)">
                        <input type="text" class="otp-input" id="otp4" maxlength="1" oninput="moveToNext(this, 5)">
                        <input type="text" class="otp-input" id="otp5" maxlength="1" oninput="moveToNext(this, 6)">
                        <input type="text" class="otp-input" id="otp6"   maxlength="1" oninput="moveToNext(this, 6)">
                    </div>
                    <p id="otpmsg"></p>
                    
                    <button type="button" id="sendOtpBtn" onclick="otpfunc()">Send OTP</button>
                    <div class="timer-text" id="timerText"></div>
                    
                    <input type="password" name="password" class="form-control" placeholder="Password" id ="password" onblur="checkPass()" required>
                    <p id="passMsg"></p>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" id ="cpassword" onkeyup="cpasscheck()" required>
                    <p id="cpassMsg"></p>
                    <button type="submit" class="btn btn-custom" >Sign Up</button>
                </form>
                <p class="text-center mt-3 text-white">
                    Already have an account? <a href="login.jsp" class="text-light fw-bold">Login</a>
                </p>
            </div>
        </div>

        <!-- Friendly Toast -->
        <div id="toast"></div>
            <script>
            function showToast(msg, type) {
                const toast = document.getElementById("toast");
                toast.innerText = msg;
                toast.className = ""; // reset
                toast.classList.add(type);
                toast.style.display = "block";

                setTimeout(() => {
                    toast.style.display = "none";
                }, 3000);
            }
            
        </script>

        <!--- Otp Button Control-->
        <!--Email and username department-->
        <script>
        let isemailvalid = false;
        let isusernamevalid = false;
        let isotpvalid = false;
        const msg = document.getElementById("mailmsg");
            const msg1 = document.getElementById("umsg");
            function emailAvail() {
                const emailInput = document.getElementById("email");
                const email = emailInput.value.trim();
                const emailRegex = /^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$/;//email checker regex
                if(email == null || email == ""){
                    msg.className = "error-msg"; 
                    msg.style.display = "block";
                    msg.innerHTML = "Email can't be blank";
                    isemailvalid = false;
                    return false;
                }
                if (!emailRegex.test(email)) {
                    msg.className = "error-msg"; 
                    msg.style.display = "block";
                    msg.innerHTML = "Email Format is not supported";
                    isemailvalid = false;
                    return false;
                }

                const mail = document.getElementById("email").value;
                const xhr = new XMLHttpRequest();
                xhr.open("GET", "<%= request.getContextPath() %>/availcheck?mail=" +encodeURIComponent(mail), true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        const msg = document.getElementById("mailmsg");
                        msg.style.display = "block";
                        if(xhr.responseText == "Email Available"){
                            msg.className = "success-msg";
                            msg.innerHTML = xhr.responseText;
                            isemailvalid = true;
                            return true;
                        }else{
                            msg.className = "error-msg";
                            msg.innerHTML = xhr.responseText;
                            isemailvalid = false;
                            return false;
                        }
                    }else {
                        msg.style.display = "block";
                        msg.className = "error-msg";
                        msg.innerHTML = "⚠️ Error " + xhr.status + " while checking email.";
                        isemailvalid = false;
                        return false;
                    }
                };
                xhr.send();
            }

            function usernameavail(){
                const userInput = document.getElementById("username");
                const username = userInput.value.trim();
                const msg1 = document.getElementById("umsg");
                if(username == null || username == ""){
                    msg1.style.display = "block";
                    msg1.className = "error-msg";
                    msg1.innerHTML = "Username can't be blank";
                    isusernamevalid = false;
                    return false;
                }
                const xhr = new XMLHttpRequest();
                xhr.open("GET","<%= request.getContextPath() %>/availcheck?user="+encodeURIComponent(username),true);
                xhr.onreadystatechange = function (){
                    if(xhr.readyState == 4  && xhr.status == 200){
                        msg1.style.display = "block";
                        if(xhr.responseText == "Username available"){
                            msg1.className = "success-msg";
                            msg1.innerHTML = xhr.responseText;
                            isusernamevalid = true;
                            return true;
                        }else{
                            msg1.className = "error-msg";
                            msg1.innerHTML = xhr.responseText;
                            isusernamevalid = false;
                            return false;
                        }
                    }else {
                        msg1.style.display = "block";
                        msg1.className = "error-msg";
                        msg1.innerHTML = "⚠️ Error " + xhr.status + " while checking username.";
                        isusernamevalid = false;
                        return false;
                    }
                };
                xhr.send();
            }
            </script>

            <!---OTP Button Control -->        
           <script>
        let bstatus = "send";
        function otpfunc(){
        sBtn = document.getElementById("sendOtpBtn");
             if(bstatus == "send"){
                sendOTP();
                 if(isemailvalid){
                    sBtn.innerText ="verify Otp";
                  bstatus = "verify";
                 }
             }else if(bstatus == "verify"){
                 validateOTP();
            }
        }
        </script>
    
        <script>
            // OTP Functions
            function moveToNext(current, next) {
                if (current.value.length >= current.maxLength) {
                    if (next <= 6) {
                        document.getElementById('otp' + next).focus();
                    }
                }
                
                // Add filled class for styling
                if (current.value.length > 0) {
                    current.classList.add('filled');
                } else {
                    current.classList.remove('filled');
                }
            }
            
            let otpTimer;
            let timeLeft = 300; // 5 minutes in seconds
            
            function sendOTP() {
                
                if(!isemailvalid){
                    showToast("Your Mail is not valid","error")
                    return false;
                }

                const email = document.getElementById("email").value.trim();
                const emailRegex = /^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$/;
                
                // Validate email
                if (!email) {
                    showToast("Please enter your email first", "error");
                    return false;
                }
                
                if (!emailRegex.test(email)) {
                    showToast("Please enter a valid email address", "error");
                    return false;
                }
                // Disable button and start timer
                const sendOtpBtn = document.getElementById("sendOtpBtn");
                startTimer();
                showToast("OTP sent to your email", "success");
                
                
                document.getElementById("otpContainer").style.display = "flex";

                //AJAX call to your server here
                
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "<%= request.getContextPath() %>/otphandler", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        showToast("OTP sent to your email", "success");
                        return true;
                    } else if (xhr.readyState === 4) {
                        showToast("Failed to send OTP. Please try again.", "error");
                        clearInterval(otpTimer);
                        document.getElementById("timerText").innerText = "";
                        return false;
                    }
                };
                xhr.send("email=" + encodeURIComponent(email));
            }
            
            function startTimer() {
                const timerText = document.getElementById("timerText");
                const sendOtpBtn = document.getElementById("sendOtpBtn");
                
                // Update timer immediately
                updateTimer();
                
                // Set interval to update timer every second
                otpTimer = setInterval(function() {
                    timeLeft--;
                    updateTimer();
                    
                    if (timeLeft <= 0) {
                        clearInterval(otpTimer);
                        timerText.innerText = "";
                        bstatus = "send";
                        sendOtpBtn.innerText="Resend otp"
                        timeLeft = 30000; // Reset timer
                    }
                }, 1000);
            }
            
            function updateTimer() {
                const timerText = document.getElementById("timerText");
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                timerText.innerText = "You can resend OTP in "+minutes+":"+seconds;
            }
            
            function getOTP() {
                const otp1 = document.getElementById("otp1").value;
                const otp2 = document.getElementById("otp2").value;
                const otp3 = document.getElementById("otp3").value;
                const otp4 = document.getElementById("otp4").value;
                const otp5 = document.getElementById("otp5").value;
                const otp6 = document.getElementById("otp6").value;
                
                return otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
            }
            
            function validateOTP() {
                const otp = getOTP();
                const otpmsg = document.getElementById("otpmsg");
                
                if (otp.length !== 6) {
                    otpmsg.style.display = "block";
                    otpmsg.className = "error-msg";
                    otpmsg.innerHTML = "Please enter the complete 6-digit OTP";
                    return false;
                }
                
                if (!/^\d+$/.test(otp)) {
                    otpmsg.style.display = "block";
                    otpmsg.className = "error-msg";
                    otpmsg.innerHTML = "OTP should contain only numbers";
                    return false;
                }
                
                checkotp()
                return true;
            }

            
        
            function checkotp(){
                console.log("from checkotp");
                const otp = getOTP();
                const xhr = new XMLHttpRequest();
                xhr.open("GET", "<%= request.getContextPath()%>/otphandler?otp="+otp, true);
                xhr.onreadystatechange = function(){
                showToast(xhr.responseText);
                if(xhr.responseText == "OTP Verified Successfully"){
                    isotpvalid = true;
                    otpmsg.style.display = "block";
                     otpmsg.className = "success-msg";
                     otpmsg.innerHTML = xhr.responseText;
                     document.getElementById("otpContainer").style.display = "none";
                }else{
                otpmsg.style.display = "block";
                     otpmsg.className = "error-msg";
                     otpmsg.innerHTML = xhr.responseText;
                }
                }
                xhr.send();
            }
        </script>

        <script>
            
            function checkPass() {
                const passInput = document.getElementById("password");
                const pass = passInput.value.trim();
                const passMsg = document.getElementById("passMsg");
                const simRegex = /^(\d+|[a-zA-Z]+)$/;  // only numbers OR only letters (not allowed)
                const splRegex = /[!@#$%^&*(),.?:{}|<>]/; // must contain at least one special character
                passMsg.style.display = "none";
                passMsg.innerHTML = "";

                // Validation
                if(pass == null || pass == ""){
                    passMsg.style.display = "block";
                    passMsg.className = "warning-msg";
                    passMsg.innerHTML = " Password Field can't be blank";
                    return false;
                }else if (simRegex.test(pass)) {
                    passMsg.style.display = "block";
                    passMsg.className = "warning-msg";
                    passMsg.innerHTML = "🤖 Beep! Password can't be just numbers or letters. Mix it up like AI neural nets!";
                    return false;
                }

                if (!splRegex.test(pass)) {
                    passMsg.style.display = "block";
                    passMsg.className = "warning-msg";
                    passMsg.innerHTML = " Password needs at least one special character like @ or #..";
                    return false;
                }

                // If valid
                passMsg.style.display = "block";
                passMsg.className = "success-msg";
                passMsg.innerHTML = "✅ Looks secure! Password accepted by Skynet (just kidding).";
                return true;
            }

            function  cpasscheck(){
                const passInput = document.getElementById("password");
                const cpassInput = document.getElementById("cpassword");
                const pass = passInput.value.trim();
                const cpass = cpassInput.value.trim();
                const cpassMsg = document.getElementById("cpassMsg");
                cpassMsg.style.display = "block";
                if(cpass == null || cpass == ""){
                    cpassMsg.className = "warning-msg";
                    cpassMsg.innerHTML = "Confirm Password can't blank";
                    return false;
                }else if(pass !== cpass){
                    cpassMsg.className = "warning-msg";
                    cpassMsg.innerHTML = "Password And Confirm password Are Not Same";
                    return false;
                }else{
                    cpassMsg.className = "success-msg";
                    cpassMsg.innerHTML = "Password and Confirm Passwords are same";
                    return true;
                }
            }
            
            function validateForm(event){
                event.preventDefault();
                let umsg = document.getElementById("umsg").innerText.trim();
                let mmsg  = document.getElementById("mailmsg").innerText.trim();
                let valid = true;
                
                if(!isusernamevalid){
                    showToast("Your username is not valid", "error");    
                    valid = false;
                }else if(!isemailvalid){
                    showToast("Your Email is not valid", "error");    
                    valid = false;
                }else if(!checkPass()){
                    showToast("Your Password is not valid", "error");    
                    valid = false;
                }else if(!cpasscheck()){
                    showToast("Your Confirmed Password is not valid", "error");    
                    valid = false;   
                }else if(!validateOTP()){
                    showToast("Please enter a valid OTP", "error");
                    valid = false;
                }else if(!isotpvalid){
                        showToast("Please enter a valid OTP", "error");
                    valid = false;
                }
                
                if(valid){
                    showToast("Your Form is being submitted", "success");
                    document.getElementById("signupform").submit();
                }
            }
        </script>

        <%
            String insert = request.getParameter("insert");
            if(insert != null && !insert.equals("")){
                if(insert.equals("pass")){
                    out.println("<script> showToast('🎉 Welcome in vibeSoul Family!','success')</script>");
                }else if(insert.equals("fail")){
                    out.println("<script> showToast('❌ Sorry! There was an error while inserting your data.','error')</script>");
                }
            }
        %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>                                                         
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie"%>
<%String susername = "";

    Cookie[] cookies = request.getCookies();
    if(cookies != null){

    for(Cookie c: cookies){
        if(c.getName().equals("username")){
            susername = c.getValue();
        }
     }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | vibeSoul</title>

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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
        }

        /* Navbar always fixed */
        nav {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        /* Prevent card from hiding under navbar */
        .content {
            margin-top: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            flex: 1;
        }

        /* Glassmorphism card */
        .login-card {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 40px;
            width: 400px;
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
            animation: fadeInUp 1s ease-in-out;
        }

        .login-card h2 {
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

        /* Floating background bubbles */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            animation: float 10s infinite;
            z-index: 0;
        }
        .bubble:nth-child(1) { width: 70px; height: 70px; left: 15%; animation-duration: 9s; }
        .bubble:nth-child(2) { width: 110px; height: 110px; left: 60%; animation-duration: 13s; }
        .bubble:nth-child(3) { width: 50px; height: 50px; left: 80%; animation-duration: 11s; }

        @keyframes float {
            0% { bottom: -100px; transform: translateX(0); }
            50% { transform: translateX(40px); }
            100% { bottom: 110%; transform: translateX(-40px); }
        }

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
    </style>
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

</head>
<body>
<!-- Navbar -->

    <%@ include file="navbar.jsp"%>


<!-- Animated bubbles -->
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>

<!-- Login Section -->
<div class="content">
    <div class="login-card animate__animated animate__fadeInDown">
        <h2>Welcome Back</h2>
        <form action="<%= request.getContextPath() %>/loginhandler" method="post">
            <input type="text" name="username" class="form-control" placeholder="Username" value="<%= susername%>" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <input type="checkbox" value="remember" name="remme" id="remme"/><label for="remme"> Remember Me</label>
            <button type="submit" class="btn btn-custom">Login</button>
        </form>
        <p class="text-center mt-3 text-white">
            Don’t have an account? <a href="signup.jsp" class="text-light fw-bold">Sign Up</a>
        </p>
    </div>
</div>  
<div id="toast"></div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    String user = request.getParameter("user");
    if(user != null && !user.equals("")){
        if(user.equals("unverified")){
                    out.println("<script>showToast('The username or password you entered is incorrect. Please try again.','error')</script>");
        }else if(user.equals("unknown")){
                    out.println("<script>showToast('No account found associated with this email address. Please register first.','error')</script>");
        }
    }
%>
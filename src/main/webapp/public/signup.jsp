<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up | vibeSoul</title>

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
            overflow: hidden;
        }

        /* Navbar fix at top */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        /* Centering only the signup card */
        .main-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 60px; /* space for navbar */
        }

        /* Glassmorphism card */
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

        /* Floating animated background bubbles */
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
    </style>
</head>
<body>

<!-- Navbar fixed at top -->
<nav>
    <%@ include file="navbar.jsp" %>
</nav>

<!-- Animated floating bubbles -->
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>

<!-- Signup card centered -->
<div class="main-container">
    <div class="signup-card animate__animated animate__fadeInDown">
        <h2>Create Account</h2>
        <form action="signupServlet" method="post">
            <input type="text" name="username" class="form-control" placeholder="Username" required>
            <input type="email" name="email" class="form-control" placeholder="Email Address" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
            <button type="submit" class="btn btn-custom">Sign Up</button>
        </form>
        <p class="text-center mt-3 text-white">
            Already have an account? <a href="login.jsp" class="text-light fw-bold">Login</a>
        </p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

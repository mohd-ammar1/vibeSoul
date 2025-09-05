<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us | vibeSoul</title>

    <!-- Bootstrap -->
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
            color: white;
            overflow-x: hidden;
        }

        nav {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        .page-content {
            margin-top: 100px;
            padding: 40px;
            text-align: center;
        }

        /* Typing heading */
       .typing-text {
    font-size: 3rem;
    font-weight: 700;
    white-space: nowrap;
    overflow: hidden;
    border-right: 4px solid #fff;
    width: 0;
    margin: 0 auto;
    animation: typing 4s steps(30) forwards, blink 0.6s 1 forwards; /* blink runs only once */
}

@keyframes typing {
    from { width: 0; }
    to { width: 100%; }
}

@keyframes blink {
    0%, 50% { border-color: #fff; } /* visible while blinking */
    100% { border-color: transparent; } /* hide completely at the end */
}

        /* Card styling */
        .about-card {
            background: rgba(255,255,255,0.15);
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            transition: transform 0.4s, box-shadow 0.4s;
            height: 100%;
        }

        .about-card:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 12px 40px rgba(0,0,0,0.5);
        }

        .about-card h3 {
            font-weight: 600;
            margin-bottom: 15px;
        }

        .about-card p {
            font-size: 1rem;
            line-height: 1.6;
        }

        /* Floating animated bubbles */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            animation: float 12s infinite;
        }
        .bubble:nth-child(1) { width: 100px; height: 100px; left: 15%; animation-duration: 10s; }
        .bubble:nth-child(2) { width: 150px; height: 150px; left: 70%; animation-duration: 15s; }
        .bubble:nth-child(3) { width: 80px; height: 80px; left: 50%; animation-duration: 12s; }
        .bubble:nth-child(4) { width: 60px; height: 60px; left: 30%; animation-duration: 14s; }

        @keyframes float {
            0% { bottom: -150px; transform: translateX(0); }
            50% { transform: translateX(40px); }
            100% { bottom: 110%; transform: translateX(-40px); }
        }

        /* Timeline */
        .timeline {
            position: relative;
            margin: 50px auto;
            padding: 20px 0;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 50%;
            top: 0;
            bottom: 0;
            width: 4px;
            background: rgba(255,255,255,0.3);
        }
        .timeline-step {
            position: relative;
            width: 45%;
            padding: 20px;
            margin: 20px 0;
            border-radius: 12px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        .timeline-step.left { left: 0; }
        .timeline-step.right { left: 55%; }

        /* Footer CTA */
        .cta {
            margin-top: 80px;
            padding: 60px;
            background: rgba(255,255,255,0.15);
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }
        .cta h2 { font-size: 2.2rem; }
    </style>
</head>
<body>

<!-- Floating bubbles -->
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>

<!-- Navbar -->

    <%@ include file="navbar.jsp" %>


<!-- Hero section -->
<div class="page-content">
    <h1 class="typing-text">About vibeSoul 💬</h1>
    <p class="mt-3 animate__animated animate__fadeInUp">Where conversations become connections ✨</p>
</div>

<!-- Three main cards -->
<div class="container mt-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="about-card animate__animated animate__fadeInLeft">
                <h3>Who We Are</h3>
                <p>vibeSoul is a place where conversations become connections. We are passionate about creating a safe and fun chatting platform for everyone.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="about-card animate__animated animate__fadeInUp">
                <h3>Our Mission</h3>
                <p>To bring people closer by blending technology with human emotions. We aim to make chatting exciting, expressive, and full of good vibes.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="about-card animate__animated animate__fadeInRight">
                <h3>Our Team</h3>
                <p>A group of passionate developers, dreamers, and creators working together to build the next generation of chatting apps with love ❤️.</p>
            </div>
        </div>
    </div>
</div>

<!-- Timeline section -->
<div class="timeline container mt-5">
    <div class="timeline-step left animate__animated animate__fadeInLeft">
        <h4>2023 – The Idea 💡</h4>
        <p>vibeSoul started as a dream of making chatting more personal and expressive.</p>
    </div>
    <div class="timeline-step right animate__animated animate__fadeInRight">
        <h4>2024 – First Prototype 🚀</h4>
        <p>We built the first version with simple chatrooms and instant messaging.</p>
    </div>
    <div class="timeline-step left animate__animated animate__fadeInLeft">
        <h4>2025 – Growing Community 🌍</h4>
        <p>Now, vibeSoul is expanding to bring thousands of people together worldwide.</p>
    </div>
</div>

<!-- Our values -->
<div class="container mt-5">
    <h2 class="mb-4 animate__animated animate__fadeInDown">Our Values 💎</h2>
    <div class="row g-4">
        <div class="col-md-3">
            <div class="about-card animate__animated animate__zoomIn">
                <h3>Trust</h3>
                <p>We protect your privacy and make sure conversations stay safe.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="about-card animate__animated animate__zoomIn">
                <h3>Creativity</h3>
                <p>Fun features, stickers, and animations that keep chats exciting.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="about-card animate__animated animate__zoomIn">
                <h3>Community</h3>
                <p>vibeSoul is more than an app, it’s a family of chatters.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="about-card animate__animated animate__zoomIn">
                <h3>Innovation</h3>
                <p>We always bring fresh ideas and features to keep you engaged.</p>
            </div>
        </div>
    </div>
</div>

<!-- Call to Action -->
<div class="container mt-5">
    <div class="cta animate__animated animate__fadeInUp">
        <h2>Join vibeSoul today 🎉</h2>
        <p>Be a part of our growing community and start vibing with people around the globe.</p>
        <a href="signup.jsp" class="btn btn-light btn-lg mt-3">Get Started</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

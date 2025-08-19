<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String insert = request.getParameter("insert");
    if(insert != null && !insert.isEmpty()){
        if(insert.equals("true")){
            out.println("<script>alert('Thankyou for contacting with us')</script>");
        }else if(insert.equals("false")){
            out.println("<script>alert('Sorry can't insert your message inserted Successfully')</script>");
        }
    }

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us | vibeSoul</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #3a8ef6, #6f42c1);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Fixed Navbar */
        nav {
            position: sticky;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background: rgba(0,0,0,0.6); /* transparent glass look */
            backdrop-filter: blur(10px);
        }

        /* Glassmorphism Card */
        .contact-card {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 50px;
            max-width: 900px;
            margin: auto;
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 40px rgba(0,0,0,0.25);
            animation: fadeInUp 1.5s ease-in-out;
        }

  
        .form-control {
            border-radius: 50px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }

        .btn-custom {
            border-radius: 50px;
            padding: 14px;
            width: 100%;
            font-weight: 600;
            background: linear-gradient(90deg, #3a8ef6, #6f42c1);
            border: none;
            color: #fff;
            transition: all 0.4s ease;
        }

        .btn-custom:hover {
            transform: scale(1.08);
            background: linear-gradient(90deg, #6f42c1, #3a8ef6);
        }

        /* Floating animated bubbles */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            animation: float 12s infinite;
            z-index: 0;
        }
        .bubble:nth-child(1) { width: 100px; height: 100px; left: 15%; animation-duration: 9s; }
        .bubble:nth-child(2) { width: 150px; height: 150px; left: 70%; animation-duration: 13s; }
        .bubble:nth-child(3) { width: 80px; height: 80px; left: 40%; animation-duration: 11s; }
        .bubble:nth-child(4) { width: 200px; height: 200px; left: 85%; animation-duration: 15s; }
        .bubble:nth-child(5) { width: 120px; height: 120px; left: 5%; animation-duration: 14s; }

        @keyframes float {
            0% { bottom: -150px; transform: translateX(0); }
            50% { transform: translateX(50px); }
            100% { bottom: 110%; transform: translateX(-50px); }
        }

        .contact-info {
            color: #fff;
            margin-top: 20px;
        }

        .contact-info h5 {
            font-weight: 600;
        }

        .social-links a {
            margin: 0 10px;
            font-size: 24px;
            color: white;
            transition: transform 0.3s ease;
        }
        .social-links a:hover {
            transform: scale(1.2);
            color: #ffd700;
        }
              .contact-card h2 {
            color: #fff;
            font-weight: 600;
            text-align: center;
            margin-bottom: 25px;
        }

    </style>
</head>
<body>

<!-- Navbar -->
    <%@ include file="navbar.jsp" %>
<!-- Animated Floating Bubbles -->
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>
<div class="bubble"></div>

<!-- Contact Us Card -->
<div class="contact-card animate__animated animate__fadeInUp">
    <h2 style="font-weight: 600;">📩 Contact Us</h2>

    <div class="row">
            <!-- Contact Form -->
        <div class="col-md-6 animate__animated animate__fadeInLeft">
            <form action="contactServlet" method="post">
                <input type="text" name="name" class="form-control" placeholder="Your Name" required>
                <input type="email" name="email" class="form-control" placeholder="Your Email" required>
                <input type="text" name="subject" class="form-control" placeholder="Subject" required>
                <textarea name="message" class="form-control" placeholder="Your Message" rows="4" required></textarea>
                <button type="submit" class="btn btn-custom">Send Message</button>
            </form>
        </div>

        <!-- Contact Info -->
        <div class="col-md-6 contact-info animate__animated animate__fadeInRight">
            <h5>📍 Address</h5>
            <p>123 VibeSoul Street, Tech City, India</p>

            <h5>📞 Phone</h5>
            <p>+91 9876543210</p>

            <h5>📧 Email</h5>
            <p>support@vibesoul.com</p>

            <h5>🌍 Follow Us</h5>
            <div class="social-links">
                <a href="#"><i class="bi bi-facebook"></i></a>
                <a href="#"><i class="bi bi-instagram"></i></a>
                <a href="#"><i class="bi bi-twitter"></i></a>
                <a href="#"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Icons + JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
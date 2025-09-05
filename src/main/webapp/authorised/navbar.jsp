<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VibeSoul | Navbar</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        /* Logo animation */
        .logo {
            background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 4s ease-in-out infinite;
            cursor: pointer;
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        /* Nav link animation */
        .nav-link {
            position: relative;
            transition: all 0.3s ease;
        }

        .nav-link::after {
            content: "";
            position: absolute;
            bottom: -4px;
            left: 50%;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover {
            color: #667eea;
            transform: translateY(-3px);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Mobile menu */
        #mobile-menu {
            transform: translateX(100%);
            transition: transform 0.4s ease;
        }

        #mobile-menu.active {
            transform: translateX(0);
        }
    </style>
</head>
<body class="overflow-x-hidden">

<!-- Navbar -->
<nav class="sticky top-0 z-50 bg-white bg-opacity-90 shadow-lg backdrop-blur-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">

            <!-- Logo -->
            <div>
                <h1 class="text-2xl font-bold logo">VibeSoul</h1>
            </div>

            <!-- Desktop menu -->
            <div class="hidden md:flex space-x-8">
                <a href="<%= request.getContextPath() %>/home.jsp" class="nav-link text-gray-700">Home</a>
                <a href="<%= request.getContextPath() %>/chat.jsp" class="nav-link text-gray-700">Chat</a>
                <a href="<%= request.getContextPath() %>/profile.jsp" class="nav-link text-gray-700">Profile</a>
                <a href="<%= request.getContextPath() %>/settings.jsp" class="nav-link text-gray-700">Settings</a>
            </div>

            <!-- CTA -->
            <div class="hidden md:block">
                <a href="<%= request.getContextPath() %>/logout.jsp"
                   class="px-5 py-2 rounded-full text-white font-semibold 
                          bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 
                          hover:scale-105 transition-transform shadow-lg">
                    Logout
                </a>
            </div>

            <!-- Mobile hamburger -->
            <button id="menu-btn" class="md:hidden flex flex-col space-y-1">
                <span class="w-6 h-0.5 bg-gray-800"></span>
                <span class="w-6 h-0.5 bg-gray-800"></span>
                <span class="w-6 h-0.5 bg-gray-800"></span>
            </button>
        </div>
    </div>
</nav>

<!-- Mobile Slide Menu -->
<div id="mobile-menu" class="fixed top-0 right-0 h-full w-64 bg-white shadow-xl z-40 p-6">
    <div class="flex flex-col space-y-6 mt-10">
        <a href="<%= request.getContextPath() %>/home.jsp" class="nav-link text-lg">Home</a>
        <a href="<%= request.getContextPath() %>/chat.jsp" class="nav-link text-lg">Chat</a>
        <a href="<%= request.getContextPath() %>/profile.jsp" class="nav-link text-lg">Profile</a>
        <a href="<%= request.getContextPath() %>/settings.jsp" class="nav-link text-lg">Settings</a>
        <a href="<%= request.getContextPath() %>/logout.jsp"
           class="px-4 py-2 rounded-full text-center text-white font-semibold 
                  bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 
                  hover:scale-105 transition-transform">
            Logout
        </a>
    </div>
</div>

<!-- Overlay -->
<div id="overlay" class="fixed inset-0 bg-black bg-opacity-40 hidden z-30"></div>

<script>
    const menuBtn = document.getElementById("menu-btn");
    const menu = document.getElementById("mobile-menu");
    const overlay = document.getElementById("overlay");

    menuBtn.addEventListener("click", () => {
        menu.classList.toggle("active");
        overlay.classList.toggle("hidden");
    });

    overlay.addEventListener("click", () => {
        menu.classList.remove("active");
        overlay.classList.add("hidden");
    });
</script>

</body>
</html>

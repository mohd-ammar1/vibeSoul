<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authorized User Navigation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; }

        .auth-nav {
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideDown 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }
        .auth-nav::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(76, 175, 80, 0.1), transparent);
            animation: navShimmer 3s ease-in-out infinite;
        }
        @keyframes navShimmer { 0%, 100% { left: -100%; } 50% { left: 100%; } }
        @keyframes slideDown { from { transform: translateY(-100%); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        .user-profile { display: flex; align-items: center; gap: 12px; padding: 8px 16px; border-radius: 25px; background: linear-gradient(135deg, rgba(76, 175, 80, 0.1), rgba(33, 150, 243, 0.1)); transition: all 0.3s ease; cursor: pointer; }
        .user-profile:hover { background: linear-gradient(135deg, rgba(76, 175, 80, 0.2), rgba(33, 150, 243, 0.2)); transform: translateY(-2px); }
        .user-avatar { width: 32px; height: 32px; border-radius: 50%; background: linear-gradient(135deg, #4CAF50, #2196F3); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 14px; }
        .user-name { font-weight: 500; color: #2d3748; }

        .dropdown-menu { position: absolute; top: 100%; right: 0; width: 200px; background: rgba(255,255,255,0.98); backdrop-filter: blur(20px); border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.15); padding: 8px 0; opacity: 0; visibility: hidden; transform: translateY(-10px); transition: all 0.3s ease; z-index: 1000; }
        .dropdown-menu.show { opacity: 1; visibility: visible; transform: translateY(0); }
        .dropdown-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: #4a5568; text-decoration: none; transition: all 0.2s ease; }
        .dropdown-item:hover { background: rgba(76,175,80,0.1); color: #2d3748; }
        .dropdown-item i { width: 20px; text-align: center; }

        .auth-nav-link { position: relative; transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); overflow: hidden; }
        .auth-nav-link::after { content: ''; position: absolute; width: 0; height: 3px; bottom: -4px; left: 50%; background: linear-gradient(90deg, #4CAF50, #2196F3); transition: all 0.4s ease; transform: translateX(-50%); border-radius: 2px; }
        .auth-nav-link:hover::after { width: 100%; }
        .auth-nav-link:hover { color: #4CAF50; transform: translateY(-2px); }

        .logout-btn { background: linear-gradient(135deg, #ff4757, #ff6b81); color: white; border: none; padding: 8px 20px; border-radius: 25px; font-weight: 500; transition: all 0.3s ease; cursor: pointer; }
        .logout-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255,107,129,0.3); }

        .mobile-auth-menu { transform: translateX(100%); transition: transform 0.5s cubic-bezier(0.175,0.885,0.32,1.275); backdrop-filter: blur(20px); background: rgba(255,255,255,0.98); }
        .mobile-auth-menu.active { transform: translateX(0); }
    </style>
</head>
<body>
<%
    // Declare username ONLY ONCE at the top
    String username = (String) session.getAttribute("username");
    if (username == null) username = "User";
%>

<!-- Authorized User Navigation Bar -->
<nav class="auth-nav shadow-lg sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <!-- Logo -->
            <div class="flex-shrink-0">
                <h1 class="text-2xl font-bold" style="background: linear-gradient(135deg, #4CAF50 0%, #2196F3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                    vibeSoul
                </h1>
            </div>

            <!-- Desktop Menu -->
            <div class="hidden md:flex ml-10 space-x-8 items-center">
                <a href="<%= request.getContextPath() %>/public/home.jsp" class="auth-nav-link text-gray-700">Home</a>
                <a href="<%= request.getContextPath() %>/public/dashboard.jsp" class="auth-nav-link text-gray-700">Dashboard</a>
                <a href="<%= request.getContextPath() %>/public/profile.jsp" class="auth-nav-link text-gray-700">Profile</a>
                <a href="<%= request.getContextPath() %>/public/settings.jsp" class="auth-nav-link text-gray-700">Settings</a>

                <!-- User Profile with Dropdown -->
                <div class="relative">
                    <div class="user-profile" onclick="toggleDropdown()">
                        <div class="user-avatar"><%= username.charAt(0) %></div>
                        <span class="user-name"><%= username %></span>
                    </div>

                    <div class="dropdown-menu" id="userDropdown">
                        <a href="<%= request.getContextPath() %>/public/profile.jsp" class="dropdown-item"><i>👤</i> Profile</a>
                        <a href="<%= request.getContextPath() %>/public/settings.jsp" class="dropdown-item"><i>⚙️</i> Settings</a>
                        <a href="<%= request.getContextPath() %>/public/notifications.jsp" class="dropdown-item"><i>🔔</i> Notifications</a>
                        <div class="border-t my-2"></div>
                        <form action="<%= request.getContextPath() %>/logout" method="post" class="px-4 py-2">
                            <button type="submit" class="logout-btn w-full text-center"><i>🚪</i> Logout</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Mobile Hamburger -->
            <div class="md:hidden">
                <button id="mobile-auth-menu-button" class="flex flex-col space-y-1 focus:outline-none">
                    <span class="w-6 h-0.5 bg-gray-800"></span>
                    <span class="w-6 h-0.5 bg-gray-800"></span>
                    <span class="w-6 h-0.5 bg-gray-800"></span>
                </button>
            </div>
        </div>
    </div>
</nav>

<!-- Mobile Menu -->
<div id="mobile-auth-menu" class="mobile-auth-menu fixed top-0 right-0 h-full w-64 shadow-xl z-40 md:hidden">
    <div class="pt-20 pb-6 px-6 space-y-4">
        <div class="user-profile mb-6">
            <div class="user-avatar"><%= username.charAt(0) %></div>
            <span class="user-name"><%= username %></span>
        </div>

        <a href="<%= request.getContextPath() %>/public/home.jsp" class="block text-gray-700 hover:text-green-600 text-lg font-medium border-b pb-2">Home</a>
        <a href="<%= request.getContextPath() %>/public/dashboard.jsp" class="block text-gray-700 hover:text-green-600 text-lg font-medium border-b pb-2">Dashboard</a>
        <a href="<%= request.getContextPath() %>/public/profile.jsp" class="block text-gray-700 hover:text-green-600 text-lg font-medium border-b pb-2">Profile</a>
        <a href="<%= request.getContextPath() %>/public/settings.jsp" class="block text-gray-700 hover:text-green-600 text-lg font-medium border-b pb-2">Settings</a>
        <a href="<%= request.getContextPath() %>/public/notifications.jsp" class="block text-gray-700 hover:text-green-600 text-lg font-medium border-b pb-2">Notifications</a>

        <form action="<%= request.getContextPath() %>/logout" method="post" class="mt-6">
            <button type="submit" class="logout-btn w-full text-center">Logout</button>
        </form>
    </div>
</div>

<div id="mobile-auth-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-30 hidden"></div>

<script>
    function toggleDropdown() {
        document.getElementById('userDropdown').classList.toggle('show');
    }

    document.addEventListener('click', function(event) {
        const dropdown = document.getElementById('userDropdown');
        const profile = document.querySelector('.user-profile');
        if (!profile.contains(event.target) && !dropdown.contains(event.target)) dropdown.classList.remove('show');
    });

    const mobileMenuButton = document.getElementById('mobile-auth-menu-button');
    const mobileMenu = document.getElementById('mobile-auth-menu');
    const mobileOverlay = document.getElementById('mobile-auth-overlay');

    mobileMenuButton.addEventListener('click', () => {
        mobileMenu.classList.toggle('active');
        mobileOverlay.classList.toggle('hidden');
    });
    mobileOverlay.addEventListener('click', () => {
        mobileMenu.classList.remove('active');
        mobileOverlay.classList.add('hidden');
    });

    mobileMenu.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
            mobileMenu.classList.remove('active');
            mobileOverlay.classList.add('hidden');
        });
    });

    window.addEventListener('scroll', function() {
        const nav = document.querySelector('.auth-nav');
        const scrolled = window.scrollY;
        nav.style.backdropFilter = scrolled > 10 ? 'blur(25px)' : 'blur(20px)';
        nav.style.background = scrolled > 10 ? 'rgba(255,255,255,0.9)' : 'rgba(255,255,255,0.95)';
    });
</script>
</body>
</html>

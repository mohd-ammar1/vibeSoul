<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ultra Animated Navigation Bar</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Matrix rain effect */
        .matrix-rain {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
            overflow: hidden;
        }

        .matrix-char {
            position: absolute;
            color: rgba(102, 126, 234, 0.7);
            font-family: 'Courier New', monospace;
            font-size: 14px;
            animation: matrixFall 3s linear infinite;
        }

        @keyframes matrixFall {
            0% { transform: translateY(-100vh); opacity: 1; }
            100% { transform: translateY(100vh); opacity: 0; }
        }

        /* Floating particles */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Ultra animated navigation */
        nav {
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideDown 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        nav::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            animation: navShimmer 3s ease-in-out infinite;
        }

        @keyframes navShimmer {
            0%, 100% { left: -100%; }
            50% { left: 100%; }
        }

        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Animated logo */
        .logo {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%, #f093fb 200%);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientShift 3s ease-in-out infinite, logoFloat 4s ease-in-out infinite;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .logo::after {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #667eea);
            background-size: 400% 400%;
            border-radius: 10px;
            z-index: -1;
            opacity: 0;
            animation: rotateBorder 3s linear infinite;
            transition: opacity 0.3s ease;
        }

        .logo:hover::after {
            opacity: 0.3;
        }

        .logo:hover {
            transform: scale(1.1) rotate(5deg);
            filter: drop-shadow(0 0 20px rgba(102, 126, 234, 0.8));
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        @keyframes logoFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-3px); }
        }

        @keyframes rotateBorder {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Ultra animated nav links */
        .nav-link {
            position: relative;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
            animation: linkEntrance 0.6s ease-out both;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 3px;
            bottom: -4px;
            left: 50%;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
            background-size: 200% 200%;
            transition: all 0.4s ease;
            transform: translateX(-50%);
            border-radius: 2px;
            animation: gradientShift 2s ease-in-out infinite;
        }

        .nav-link:hover::after {
            width: 100%;
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.5);
        }

        .nav-link:hover {
            color: #667eea;
            transform: translateY(-3px) scale(1.05);
            text-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        @keyframes linkEntrance {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Ultra animated hamburger */
        .hamburger {
            cursor: pointer;
            transition: all 0.3s ease;
            padding: 10px;
            border-radius: 8px;
            position: relative;
            animation: hamburgerFloat 3s ease-in-out infinite;
        }

        .hamburger::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border-radius: 8px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .hamburger:hover::before {
            opacity: 1;
        }

        .hamburger:hover {
            transform: scale(1.1) rotate(5deg);
        }

        @keyframes hamburgerFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-2px); }
        }

        .hamburger span {
            display: block;
            width: 25px;
            height: 3px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            margin: 5px 0;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border-radius: 2px;
            position: relative;
        }

        .hamburger span::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.5), transparent);
            animation: spanShimmer 2s ease-in-out infinite;
        }

        @keyframes spanShimmer {
            0%, 100% { left: -100%; }
            50% { left: 100%; }
        }

        .hamburger.active span:nth-child(1) {
            transform: rotate(-45deg) translate(-5px, 6px);
            background: linear-gradient(90deg, #f093fb, #667eea);
        }

        .hamburger.active span:nth-child(2) {
            opacity: 0;
            transform: scale(0);
        }

        .hamburger.active span:nth-child(3) {
            transform: rotate(45deg) translate(-5px, -6px);
            background: linear-gradient(90deg, #f093fb, #667eea);
        }

        /* Ultra animated CTA button */
        .cta-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            background-size: 200% 200%;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            animation: gradientShift 4s ease-in-out infinite, buttonFloat 3s ease-in-out infinite;
        }

        .cta-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s;
        }

        .cta-button:hover::before {
            left: 100%;
        }

        .cta-button::after {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #667eea);
            background-size: 400% 400%;
            border-radius: inherit;
            z-index: -1;
            opacity: 0;
            animation: rotateBorder 3s linear infinite;
            transition: opacity 0.3s ease;
        }

        .cta-button:hover::after {
            opacity: 1;
        }

        .cta-button:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
            filter: brightness(1.1);
        }

        .cta-button:active {
            transform: translateY(-1px) scale(1.02);
            animation: shake 0.5s ease-in-out;
        }

        @keyframes buttonFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-2px); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-3px); }
            20%, 40%, 60%, 80% { transform: translateX(3px); }
        }

        /* Mobile menu animations */
        .mobile-menu {
            transform: translateX(100%);
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
        }

        .mobile-menu.active {
            transform: translateX(0);
        }

        .mobile-menu a {
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: mobileItemSlide 0.5s ease-out both;
        }

        .mobile-menu a::before {
            content: '';
            position: absolute;
            left: -100%;
            top: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.5s;
        }

        .mobile-menu a:hover::before {
            left: 100%;
        }

        .mobile-menu a:hover {
            transform: translateX(10px);
            color: #667eea;
        }

        @keyframes mobileItemSlide {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Content animations */
        .title-text {
            background: linear-gradient(135deg, #ffffff 0%, #f0f0f0 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: titleGlow 2s ease-in-out infinite alternate, glitch 3s infinite;
            position: relative;
        }

        .title-text::before,
        .title-text::after {
            content: attr(data-text);
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .title-text::before {
            animation: glitch-1 0.5s infinite;
            color: #ff0000;
            z-index: -1;
        }

        .title-text::after {
            animation: glitch-2 0.5s infinite;
            color: #00ff00;
            z-index: -2;
        }

        @keyframes titleGlow {
            from { filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.3)); }
            to { filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.6)); }
        }

        @keyframes glitch {
            0%, 100% { transform: translate(0); }
            20% { transform: translate(-2px, 2px); }
            40% { transform: translate(-2px, -2px); }
            60% { transform: translate(2px, 2px); }
            80% { transform: translate(2px, -2px); }
        }

        @keyframes glitch-1 {
            0%, 100% { transform: translate(0); }
            20% { transform: translate(2px, -2px); }
            40% { transform: translate(-2px, 2px); }
            60% { transform: translate(-2px, -2px); }
            80% { transform: translate(2px, 2px); }
        }

        @keyframes glitch-2 {
            0%, 100% { transform: translate(0); }
            20% { transform: translate(-2px, 2px); }
            40% { transform: translate(2px, -2px); }
            60% { transform: translate(2px, 2px); }
            80% { transform: translate(-2px, -2px); }
        }

        /* Typewriter effect */
        .typewriter {
            overflow: hidden;
            border-right: 3px solid rgba(255, 255, 255, 0.75);
            white-space: nowrap;
            animation: typing 3.5s steps(40, end), blink-caret 0.75s step-end infinite;
        }

        @keyframes typing {
            from { width: 0; }
            to { width: 100%; }
        }

        @keyframes blink-caret {
            from, to { border-color: transparent; }
            50% { border-color: rgba(255, 255, 255, 0.75); }
        }

        /* Content cards with ultra animations */
        .content-card {
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.4s ease;
            animation: fadeInUp 0.8s ease-out, cardFloat 6s ease-in-out infinite;
            position: relative;
            overflow: hidden;
        }

        .content-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #667eea);
            background-size: 400% 400%;
            border-radius: inherit;
            z-index: -1;
            animation: rotateBorder 3s linear infinite;
        }

        .content-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.15);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes cardFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        /* Morphing shapes */
        .morphing-shape {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            animation: morph 4s ease-in-out infinite;
            margin: 0 auto 20px;
        }

        @keyframes morph {
            0%, 100% { border-radius: 50%; transform: rotate(0deg) scale(1); }
            25% { border-radius: 0%; transform: rotate(90deg) scale(1.1); }
            50% { border-radius: 50% 10%; transform: rotate(180deg) scale(0.9); }
            75% { border-radius: 10% 50%; transform: rotate(270deg) scale(1.1); }
        }

        /* Bouncing dots */
        .bouncing-dots {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin: 20px 0;
        }

        .bouncing-dots div {
            width: 12px;
            height: 12px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            animation: bounce 1.4s ease-in-out infinite both;
        }

        .bouncing-dots div:nth-child(1) { animation-delay: -0.32s; }
        .bouncing-dots div:nth-child(2) { animation-delay: -0.16s; }
        .bouncing-dots div:nth-child(3) { animation-delay: 0s; }

        @keyframes bounce {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1); }
        }

        /* Ripple effect */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
        }

        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Matrix Rain Effect -->
    <div class="matrix-rain" id="matrix-rain"></div>

    <!-- Floating Particles -->
    <div class="particles" id="particles"></div>

    <!-- Ultra Animated Navigation Bar -->
    <nav class="shadow-lg sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Animated Logo -->
                <div class="flex-shrink-0">
                    <h1 class="text-2xl font-bold logo">UltraNav</h1>
                </div>

                <!-- Desktop Menu -->
                <div class="hidden md:block">
                    <div class="ml-10 flex items-baseline space-x-8">
                        <a href="#home" class="nav-link text-gray-700 hover:text-blue-600 px-3 py-2 text-sm font-medium" style="animation-delay: 0.1s">Home</a>
                        <a href="#about" class="nav-link text-gray-700 hover:text-blue-600 px-3 py-2 text-sm font-medium" style="animation-delay: 0.2s">About</a>
                        <a href="#contact" class="nav-link text-gray-700 hover:text-blue-600 px-3 py-2 text-sm font-medium" style="animation-delay: 0.4s">Contact</a>
                    <a href="#portfolio" class="nav-link text-gray-700 hover:text-blue-600 px-3 py-2 text-sm font-medium" style="animation-delay: 0.5s">Login</a>
                    </div>
                </div>

                <!-- Animated CTA Button -->
                <div class="hidden md:block">
                    <button class="cta-button text-white px-6 py-2 rounded-full text-sm font-medium">
                        Get Started
                    </button>
                </div>

                <!-- Animated Mobile menu button -->
                <div class="md:hidden">
                    <button class="hamburger" id="mobile-menu-button">
                        <span></span>
                        <span></span>
                        <span></span>
                    </button>
                </div>
            </div>
        </div>

        <!-- Mobile Menu -->
        <div class="mobile-menu md:hidden fixed top-0 right-0 h-full w-64 bg-white shadow-xl z-40" id="mobile-menu">
            <div class="pt-20 pb-6 px-6">
                <div class="space-y-6">
                    <a href="index.jsp?page=home" class="block text-gray-700 hover:text-blue-600 text-lg font-medium py-2 border-b border-gray-100" style="animation-delay: 0.1s">Home</a>
                    <a href="#about" class="block text-gray-700 hover:text-blue-600 text-lg font-medium py-2 border-b border-gray-100" style="animation-delay: 0.2s">About</a>
                    <a href="#services" class="block text-gray-700 hover:text-blue-600 text-lg font-medium py-2 border-b border-gray-100" style="animation-delay: 0.3s">Services</a>
                    <a href="#portfolio" class="block text-gray-700 hover:text-blue-600 text-lg font-medium py-2 border-b border-gray-100" style="animation-delay: 0.4s">Portfolio</a>
                    <a href="#contact" class="block text-gray-700 hover:text-blue-600 text-lg font-medium py-2 border-b border-gray-100" style="animation-delay: 0.5s">Contact</a>
                    <button class="cta-button text-white px-6 py-3 rounded-full text-sm font-medium w-full mt-4">
                        Get Started
                    </button>
                </div>
            </div>
        </div>

        <!-- Mobile Menu Overlay -->
        <div class="mobile-menu-overlay fixed inset-0 bg-black bg-opacity-50 z-30 hidden" id="mobile-overlay"></div>
    </nav>


    <script>
        // Create matrix rain effect
        function createMatrixRain() {
            const matrixContainer = document.getElementById('matrix-rain');
            const chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';

            function createMatrixChar() {
                const char = document.createElement('div');
                char.className = 'matrix-char';
                char.textContent = chars[Math.floor(Math.random() * chars.length)];
                char.style.left = Math.random() * 100 + '%';
                char.style.animationDuration = (Math.random() * 2 + 2) + 's';
                char.style.animationDelay = Math.random() * 2 + 's';

                matrixContainer.appendChild(char);

                setTimeout(() => {
                    if (char.parentNode) {
                        char.parentNode.removeChild(char);
                    }
                }, 4000);
            }

            setInterval(createMatrixChar, 200);
        }

        // Create floating particles
        function createParticles() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';

                const size = Math.random() * 6 + 2;
                particle.style.width = size + 'px';
                particle.style.height = size + 'px';

                particle.style.left = Math.random() * 100 + '%';
                particle.style.top = Math.random() * 100 + '%';

                particle.style.animationDuration = (Math.random() * 4 + 4) + 's';
                particle.style.animationDelay = Math.random() * 4 + 's';

                particlesContainer.appendChild(particle);
            }
        }

        // Mobile menu functionality
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const mobileMenu = document.getElementById('mobile-menu');
        const mobileOverlay = document.getElementById('mobile-overlay');
        const hamburger = document.querySelector('.hamburger');

        function toggleMobileMenu() {
            mobileMenu.classList.toggle('active');
            mobileOverlay.classList.toggle('hidden');
            hamburger.classList.toggle('active');
        }

        mobileMenuButton.addEventListener('click', toggleMobileMenu);
        mobileOverlay.addEventListener('click', toggleMobileMenu);

        // Close mobile menu when clicking on a link
        const mobileLinks = mobileMenu.querySelectorAll('a');
        mobileLinks.forEach(link => {
            link.addEventListener('click', toggleMobileMenu);
        });

        // Add ripple effect to buttons
        function addRippleEffect() {
            const buttons = document.querySelectorAll('.cta-button');

            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;

                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.classList.add('ripple');

                    this.appendChild(ripple);

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        }

        // Enhanced scroll effects
        window.addEventListener('scroll', function() {
            const nav = document.querySelector('nav');
            const scrolled = window.scrollY;

            if (scrolled > 10) {
                nav.style.backdropFilter = 'blur(25px)';
                nav.style.background = 'rgba(255, 255, 255, 0.9)';
            } else {
                nav.style.backdropFilter = 'blur(20px)';
                nav.style.background = 'rgba(255, 255, 255, 0.95)';
            }

            // Parallax effect for particles
            const particles = document.querySelectorAll('.particle');
            particles.forEach((particle, index) => {
                const speed = (index % 3 + 1) * 0.5;
                particle.style.transform = `translateY(${scrolled * speed}px)`;
            });
        });

        // Random surprise animations
        function addRandomAnimations() {
            const cards = document.querySelectorAll('.content-card');

            setInterval(() => {
                const randomCard = cards[Math.floor(Math.random() * cards.length)];
                randomCard.style.transform = 'scale(1.05) rotate(2deg)';
                randomCard.style.filter = 'brightness(1.2) saturate(1.3)';

                setTimeout(() => {
                    randomCard.style.transform = '';
                    randomCard.style.filter = '';
                }, 1000);
            }, 5000);
        }

        // Initialize everything
        document.addEventListener('DOMContentLoaded', function() {
            createMatrixRain();
            createParticles();
            addRippleEffect();
            addRandomAnimations();
        });
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'96f20763e53e338e',t:'MTc1NTE5MTA0MS4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>

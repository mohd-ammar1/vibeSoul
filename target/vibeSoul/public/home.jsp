<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat App - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Simple fade-in animations */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 1s ease-out, transform 1s ease-out;
        }
        .fade-in.show {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-50 text-gray-800">

<!--Navbar-->

<%@ include file="navbar.jsp"%>

    <!-- Hero Section -->
    <section class="h-screen flex flex-col justify-center items-center text-center px-6 bg-gradient-to-r from-blue-500 to-indigo-600 text-white">
        <h1 class="text-5xl md:text-6xl font-extrabold mb-4 fade-in">Chat with Vibe. Connect with Soul.</h1>
        <p class="text-lg md:text-xl mb-6 fade-in">chat with friends, share your vibe, and keep the soul alive.</p>
        <div class="flex space-x-4 fade-in">
            <a href="signup.jsp" class="bg-white text-blue-600 px-6 py-3 rounded-2xl font-semibold shadow-lg hover:bg-gray-100 transition">Get Started</a>
            <a href="login.jsp" class="border border-white px-6 py-3 rounded-2xl font-semibold hover:bg-white hover:text-blue-600 transition">Login</a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-16 px-8 bg-white">
        <h2 class="text-3xl font-bold text-center mb-12 fade-in">Why Choose Our Chat App?</h2>
        <div class="grid md:grid-cols-4 gap-8 text-center">
          <div class="p-6 bg-white rounded-2xl shadow-md text-center transition transform hover:-translate-y-2 hover:shadow-lg">
              <i class="fas fa-comments text-4xl text-blue-500 mb-3"></i>
              <h3 class="text-lg font-semibold">Real-Time Chat</h3>
              <p class="text-gray-600">Instant messaging without delays.</p>
          </div>

          <div class="p-6 bg-white rounded-2xl shadow-md text-center transition transform hover:-translate-y-2 hover:shadow-lg">
              <i class="fas fa-lock text-4xl text-green-500 mb-3"></i>
              <h3 class="text-lg font-semibold">Secure Messaging</h3>
              <p class="text-gray-600">Your privacy is always protected.</p>
          </div>

          <div class="p-6 bg-white rounded-2xl shadow-md text-center transition transform hover:-translate-y-2 hover:shadow-lg">
              <i class="fas fa-users text-4xl text-purple-500 mb-3"></i>
              <h3 class="text-lg font-semibold">Group Chats</h3>
              <p class="text-gray-600">Stay connected with your friends.</p>
          </div>

          <div class="p-6 bg-white rounded-2xl shadow-md text-center transition transform hover:-translate-y-2 hover:shadow-lg">
              <i class="fas fa-laptop text-4xl text-orange-500 mb-3"></i>
              <h3 class="text-lg font-semibold">Cross-Platform</h3>
              <p class="text-gray-600">Works on desktop and mobile.</p>
          </div>

        </div>
    </section>

    <!-- How It Works -->
    <section class="py-16 px-8 bg-gray-50">
        <h2 class="text-3xl font-bold text-center mb-12 fade-in">How It Works</h2>
        <div class="grid md:grid-cols-3 gap-8 text-center">
         <div class="flex flex-col items-center text-center">
             <i class="fas fa-user-plus text-4xl text-blue-500 mb-3"></i>
             <h3 class="text-lg font-semibold">Sign Up</h3>
             <p class="text-gray-600">Create your free account.</p>
         </div>

         <div class="flex flex-col items-center text-center">
             <i class="fas fa-user-friends text-4xl text-green-500 mb-3"></i>
             <h3 class="text-lg font-semibold">Add Friends</h3>
             <p class="text-gray-600">Connect with people easily.</p>
         </div>

         <div class="flex flex-col items-center text-center">
             <i class="fas fa-comment-dots text-4xl text-purple-500 mb-3"></i>
             <h3 class="text-lg font-semibold">Start Chatting</h3>
             <p class="text-gray-600">Enjoy fast & secure chat.</p>
         </div>

        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-20 px-6 bg-indigo-600 text-white text-center">
        <h2 class="text-4xl font-bold mb-6 fade-in">Ready to start chatting?</h2>
        <a href="signup.jsp" class="bg-white text-indigo-600 px-8 py-4 rounded-2xl font-semibold shadow-lg hover:bg-gray-100 transition fade-in">Join Now</a>
        <p class="mt-4 fade-in">Already a member? <a href="login.jsp" class="underline">Login here</a></p>
    </section>

    <!-- Animation Script -->
    <script>
        const elements = document.querySelectorAll('.fade-in');
        const observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('show');
                }
            });
        });
        elements.forEach(el => observer.observe(el));
    </script>

</body>
</html>

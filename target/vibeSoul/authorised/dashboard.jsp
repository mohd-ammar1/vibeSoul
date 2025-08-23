<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Check if user is logged in
    HttpSession sessionObj = request.getSession(false);
    String username = (String) sessionObj.getAttribute("username");
    
    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/public/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard | vibeSoul</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            --warning-gradient: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #434343 0%, #000000 100%);
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            padding-top: 80px;
            padding-bottom: 40px;
        }
        
        .welcome-card {
            background: var(--primary-gradient);
            color: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .welcome-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { transform: rotate(45deg) translateX(-100%); }
            100% { transform: rotate(45deg) translateX(200%); }
        }
        
        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
            border: none;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 20px;
            color: white;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #718096;
            font-weight: 500;
        }
        
        .quick-action-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            text-align: center;
            border: none;
        }
        
        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 20px;
            color: white;
            background: var(--primary-gradient);
        }
        
        .recent-activity {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        
        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            margin-right: 15px;
            color: white;
        }
        
        .glass-effect {
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
        }
        
        .floating {
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
    </style>
</head>
<body>
    <div class="container main-content">
        <!-- Welcome Section -->
        <div class="welcome-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-4 fw-bold mb-3">Welcome back, <%= username %>! 👋</h1>
                    <p class="lead mb-4">Here's what's happening with your vibeSoul account today. Stay inspired!</p>
                    <div class="d-flex gap-3">
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="fas fa-calendar me-2"></i>Today
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="fas fa-users me-2"></i>Active
                        </span>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="floating">
                        <i class="fas fa-rocket fa-5x text-white opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Statistics Row -->
        <div class="row mb-5">
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background: var(--success-gradient);">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="stat-number">1.2K</div>
                    <div class="stat-label">Total Connections</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background: var(--primary-gradient);">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="stat-number">356</div>
                    <div class="stat-label">Messages</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background: var(--warning-gradient);">
                        <i class="fas fa-bell"></i>
                    </div>
                    <div class="stat-number">42</div>
                    <div class="stat-label">Notifications</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background: var(--info-gradient);">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-number">98%</div>
                    <div class="stat-label">Engagement</div>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row mb-5">
            <div class="col-12 mb-4">
                <h3 class="fw-bold mb-4">Quick Actions</h3>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="quick-action-card pulse">
                    <div class="action-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h5>Update Profile</h5>
                    <p class="text-muted small">Edit your personal information</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="quick-action-card pulse">
                    <div class="action-icon" style="background: var(--success-gradient);">
                        <i class="fas fa-share-alt"></i>
                    </div>
                    <h5>Share Content</h5>
                    <p class="text-muted small">Post something new</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="quick-action-card pulse">
                    <div class="action-icon" style="background: var(--warning-gradient);">
                        <i class="fas fa-cog"></i>
                    </div>
                    <h5>Settings</h5>
                    <p class="text-muted small">Configure preferences</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="quick-action-card pulse">
                    <div class="action-icon" style="background: var(--info-gradient);">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h5>Get Help</h5>
                    <p class="text-muted small">Support center</p>
                </div>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="row">
            <div class="col-12">
                <div class="recent-activity">
                    <h4 class="fw-bold mb-4">Recent Activity</h4>
                    <div class="activity-item">
                        <div class="activity-icon" style="background: var(--success-gradient);">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">New connection request</h6>
                            <p class="text-muted mb-0 small">From Sarah Johnson</p>
                        </div>
                        <span class="ms-auto text-muted small">2 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon" style="background: var(--primary-gradient);">
                            <i class="fas fa-comment"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">New message received</h6>
                            <p class="text-muted mb-0 small">From Mike Chen</p>
                        </div>
                        <span class="ms-auto text-muted small">15 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon" style="background: var(--warning-gradient);">
                            <i class="fas fa-bell"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Profile updated</h6>
                            <p class="text-muted mb-0 small">You changed your profile picture</p>
                        </div>
                        <span class="ms-auto text-muted small">1 hour ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon" style="background: var(--info-gradient);">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Performance update</h6>
                            <p class="text-muted mb-0 small">Your engagement increased by 15%</p>
                        </div>
                        <span class="ms-auto text-muted small">3 hours ago</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to cards
            const cards = document.querySelectorAll('.stat-card, .quick-action-card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-8px)';
                });
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0)';
                });
            });
            
            // Animate numbers
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(number => {
                const target = parseInt(number.textContent);
                let current = 0;
                const increment = target / 50;
                
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        number.textContent = target;
                        clearInterval(timer);
                    } else {
                        number.textContent = Math.round(current);
                    }
                }, 50);
            });
        });
    </script>
</body>
</html>

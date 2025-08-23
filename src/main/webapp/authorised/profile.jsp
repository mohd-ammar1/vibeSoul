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
    <title>Profile | vibeSoul</title>
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
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            padding-top: 80px;
            padding-bottom: 40px;
        }
        
        .profile-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .profile-header::before {
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
        
        .profile-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
        }
        
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }
        
        .avatar-container {
            position: relative;
            width: 120px;
            height: 120px;
            margin: 0 auto 20px;
        }
        
        .avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: 700;
            border: 4px solid white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .avatar-edit {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: var(--success-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            border: 3px solid white;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .avatar-edit:hover {
            transform: scale(1.1);
        }
        
        .form-control {
            border-radius: 12px;
            padding: 12px 20px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .stat-badge {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 15px;
            text-align: center;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .stat-badge:hover {
            border-color: #667eea;
            transform: translateY(-3px);
        }
        
        .progress-bar {
            background: var(--primary-gradient);
            border-radius: 10px;
        }
        
        .skill-badge {
            background: var(--info-gradient);
            color: white;
            border-radius: 20px;
            padding: 8px 20px;
            margin: 5px;
            display: inline-block;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .skill-badge:hover {
            transform: scale(1.05);
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
    <!-- Include authorized navigation bar -->
    <%@ include file="auth-navbar.jsp" %>
    
    <div class="container main-content">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-4 fw-bold mb-3">Your Profile</h1>
                    <p class="lead mb-4">Manage your personal information and preferences</p>
                    <div class="d-flex gap-3">
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="fas fa-user me-2"></i>Member since 2024
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="fas fa-star me-2"></i>Premium User
                        </span>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="floating">
                        <i class="fas fa-user-circle fa-5x text-white opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- Left Column - Avatar and Stats -->
            <div class="col-md-4">
                <div class="profile-card text-center">
                    <div class="avatar-container">
                        <div class="avatar">
                            <%= username.charAt(0) %>
                        </div>
                        <div class="avatar-edit">
                            <i class="fas fa-camera"></i>
                        </div>
                    </div>
                    
                    <h3 class="fw-bold mb-2"><%= username %></h3>
                    <p class="text-muted mb-4">@<%= username.toLowerCase() %></p>
                    
                    <div class="row mb-4">
                        <div class="col-6">
                            <div class="stat-badge">
                                <div class="fw-bold text-primary">1.2K</div>
                                <small class="text-muted">Followers</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-badge">
                                <div class="fw-bold text-primary">456</div>
                                <small class="text-muted">Following</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="progress mb-3" style="height: 8px; border-radius: 10px;">
                        <div class="progress-bar" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <small class="text-muted">Profile completeness: 85%</small>
                </div>
                
                <div class="profile-card">
                    <h5 class="fw-bold mb-3">Skills & Interests</h5>
                    <div class="skill-badge">Web Development</div>
                    <div class="skill-badge" style="background: var(--success-gradient);">Design</div>
                    <div class="skill-badge" style="background: var(--warning-gradient);">Photography</div>
                    <div class="skill-badge" style="background: var(--info-gradient);">Music</div>
                    <div class="skill-badge">Travel</div>
                    <div class="skill-badge" style="background: var(--success-gradient);">Cooking</div>
                </div>
            </div>
            
            <!-- Right Column - Profile Form -->
            <div class="col-md-8">
                <div class="profile-card">
                    <h4 class="fw-bold mb-4">Personal Information</h4>
                    <form>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">First Name</label>
                                <input type="text" class="form-control" value="John" placeholder="First Name">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Last Name</label>
                                <input type="text" class="form-control" value="Doe" placeholder="Last Name">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email Address</label>
                            <input type="email" class="form-control" value="john.doe@example.com" placeholder="Email Address">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Username</label>
                            <input type="text" class="form-control" value="<%= username %>" placeholder="Username" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Bio</label>
                            <textarea class="form-control" rows="4" placeholder="Tell us about yourself...">Passionate about technology and design. Love creating beautiful user experiences that make people's lives better.</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Location</label>
                            <input type="text" class="form-control" value="New York, USA" placeholder="Location">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Website</label>
                            <input type="url" class="form-control" value="https://johndoe.com" placeholder="Website URL">
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-save me-2"></i>Save Changes
                        </button>
                    </form>
                </div>
                
                <div class="profile-card">
                    <h4 class="fw-bold mb-4">Security Settings</h4>
                    <div class="mb-4">
                        <label class="form-label fw-semibold">Change Password</label>
                        <input type="password" class="form-control mb-2" placeholder="Current Password">
                        <input type="password" class="form-control mb-2" placeholder="New Password">
                        <input type="password" class="form-control" placeholder="Confirm New Password">
                    </div>
                    
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" id="twoFactor" checked>
                        <label class="form-check-label fw-semibold" for="twoFactor">
                            Two-Factor Authentication
                        </label>
                    </div>
                    
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" id="emailNotifications" checked>
                        <label class="form-check-label fw-semibold" for="emailNotifications">
                            Email Notifications
                        </label>
                    </div>
                    
                    <div class="form-check form-switch mb-4">
                        <input class="form-check-input" type="checkbox" id="privacyMode">
                        <label class="form-check-label fw-semibold" for="privacyMode">
                            Privacy Mode
                        </label>
                    </div>
                    
                    <button type="button" class="btn btn-outline-danger w-100">
                        <i class="fas fa-trash-alt me-2"></i>Delete Account
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Avatar edit functionality
            const avatarEdit = document.querySelector('.avatar-edit');
            avatarEdit.addEventListener('click', function() {
                alert('Avatar edit feature coming soon!');
            });
            
            // Form validation
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    // Simulate save action
                    const saveBtn = this.querySelector('button[type="submit"]');
                    const originalText = saveBtn.innerHTML;
                    
                    saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';
                    saveBtn.disabled = true;
                    
                    setTimeout(() => {
                        saveBtn.innerHTML = originalText;
                        saveBtn.disabled = false;
                        
                        // Show success message
                        const toast = document.createElement('div');
                        toast.className = 'alert alert-success position-fixed top-0 start-50 translate-middle-x mt-3';
                        toast.style.zIndex = '9999';
                        toast.innerHTML = '<i class="fas fa-check-circle me-2"></i>Profile updated successfully!';
                        document.body.appendChild(toast);
                        
                        setTimeout(() => {
                            toast.remove();
                        }, 3000);
                    }, 2000);
                });
            });
        });
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNest — Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');
        *{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'Inter',sans-serif;background:linear-gradient(-45deg,#050510,#0f0a00,#1a0e00,#0a0520);background-size:400% 400%;animation:gradMove 10s ease infinite;min-height:100vh;display:flex;flex-direction:column;}
        @keyframes gradMove{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        @keyframes fadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
        @keyframes nestFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
        .bn-nav{padding:14px 32px;display:flex;align-items:center;justify-content:space-between;}
        .bn-logo{display:flex;align-items:center;gap:10px;text-decoration:none;}
        .bn-logo-icon{width:36px;height:36px;background:linear-gradient(135deg,#d97706,#f59e0b);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:18px;animation:nestFloat 4s ease-in-out infinite;}
        .bn-logo-text{font-size:20px;font-weight:600;background:linear-gradient(90deg,#fbbf24,#f97316);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
        .bn-wrap{flex:1;display:flex;align-items:center;justify-content:center;padding:20px;}
        .bn-card{background:rgba(255,255,255,0.05);backdrop-filter:blur(20px);border:1px solid rgba(251,191,36,0.15);border-radius:20px;padding:40px;width:100%;max-width:420px;animation:fadeUp 0.6s ease both;}
        .bn-card h2{font-size:24px;font-weight:600;color:#fff;margin-bottom:6px;text-align:center;}
        .bn-card p{color:rgba(255,255,255,0.45);font-size:14px;text-align:center;margin-bottom:28px;}
        .bn-field{margin-bottom:18px;}
        .bn-field label{display:block;font-size:13px;color:rgba(255,255,255,0.6);margin-bottom:7px;font-weight:500;}
        .bn-field input{width:100%;padding:12px 16px;border:1px solid rgba(255,255,255,0.1);border-radius:10px;background:rgba(255,255,255,0.07);color:#fff;font-size:14px;outline:none;font-family:'Inter',sans-serif;transition:border 0.2s;}
        .bn-field input:focus{border-color:#f59e0b;background:rgba(251,191,36,0.08);}
        .bn-field input::placeholder{color:rgba(255,255,255,0.25);}
        .bn-btn{width:100%;padding:13px;background:linear-gradient(135deg,#d97706,#f59e0b);color:#fff;border:none;border-radius:10px;font-size:15px;font-weight:600;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.2s;margin-top:6px;}
        .bn-btn:hover{transform:scale(1.02);box-shadow:0 8px 24px rgba(217,119,6,0.4);}
        .bn-error{background:rgba(239,68,68,0.15);border:1px solid rgba(239,68,68,0.3);color:#fca5a5;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;text-align:center;}
        .bn-success{background:rgba(16,185,129,0.15);border:1px solid rgba(16,185,129,0.3);color:#6ee7b7;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;text-align:center;}
        .bn-link{text-align:center;margin-top:20px;font-size:13px;color:rgba(255,255,255,0.45);}
        .bn-link a{color:#fbbf24;text-decoration:none;font-weight:500;}
        .bn-link a:hover{text-decoration:underline;}
        .bn-divider{display:flex;align-items:center;gap:12px;margin:20px 0;}
        .bn-divider span{color:rgba(255,255,255,0.2);font-size:12px;}
        .bn-divider::before,.bn-divider::after{content:'';flex:1;height:1px;background:rgba(255,255,255,0.08);}
    </style>
</head>
<body>

<nav class="bn-nav">
    <a href="<%= request.getContextPath() %>/books" class="bn-logo">
        <div class="bn-logo-icon">🪺</div>
        <div class="bn-logo-text">BookNest</div>
    </a>
</nav>

<div class="bn-wrap">
    <div class="bn-card">
        <h2>Welcome back! 👋</h2>
        <p>Login to your BookNest account</p>

        <% String error = (String) request.getAttribute("error");
           String success = (String) request.getAttribute("success");
           if (error != null) { %>
            <div class="bn-error">⚠️ <%= error %></div>
        <% } %>
        <% if (success != null) { %>
            <div class="bn-success">✅ <%= success %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="bn-field">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter your username" required>
            </div>
            <div class="bn-field">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="bn-btn">Login to BookNest 🪺</button>
        </form>

        <div class="bn-divider"><span>OR</span></div>
        <div class="bn-link">
            Don't have an account? <a href="<%= request.getContextPath() %>/register">Register here</a>
        </div>
    </div>
</div>

</body>
</html>
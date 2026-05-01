<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.booknest.model.Book"%>
<%@page import="com.booknest.model.User"%>

<%
List<Book> books = (List<Book>) request.getAttribute("books");
if(books==null) books = new ArrayList<>();

User loggedUser = (User) session.getAttribute("user");

Map<Integer,Integer> cart =
(Map<Integer,Integer>) session.getAttribute("cart");

int cartCount = 0;

if(cart != null){
    for(Integer qty : cart.values()){
        cartCount += qty;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>BookNest Premium</title>

<style>
@import url('https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&display=swap');

*{
margin:0;
padding:0;
box-sizing:border-box;
scroll-behavior:smooth;
}

body{
font-family:'Sora',sans-serif;
background:
radial-gradient(circle at 15% 20%, rgba(255,140,0,0.18), transparent 22%),
radial-gradient(circle at 85% 15%, rgba(255,70,0,0.12), transparent 18%),
radial-gradient(circle at 80% 80%, rgba(255,170,0,0.10), transparent 20%),
linear-gradient(135deg,#f6f6fb 0%, #ececf5 50%, #e5e6f2 100%);
color:#111;
overflow-x:hidden;
}

#loader{
position:fixed;
top:0;
left:0;
width:100%;
height:100%;
background:linear-gradient(135deg,#0f0c29,#1a0010,#2b0b00);
display:flex;
justify-content:center;
align-items:center;
z-index:99999;
transition:all .6s ease;
}

.loader-box{
text-align:center;
color:#fff;
}

.loader-ring{
width:70px;
height:70px;
border:4px solid rgba(255,255,255,.15);
border-top:4px solid #ff9800;
border-radius:50%;
margin:auto;
animation:spin .8s linear infinite;
box-shadow:0 0 20px rgba(255,152,0,.45);
}

.loader-box h1{
margin-top:18px;
font-size:42px;
color:#ff9800;
font-weight:700;
}

.loader-box p{
font-size:14px;
opacity:.8;
margin-top:6px;
}

@keyframes spin{
100%{transform:rotate(360deg);}
}

.loader-hide{
opacity:0;
visibility:hidden;
}

/* ================= NAVBAR ================= */

.navbar{
position:fixed;
top:0;
left:0;
width:100%;
height:92px;
padding:0 38px;
display:flex;
align-items:center;
justify-content:space-between;
background:rgba(10,10,20,.58);
backdrop-filter:blur(18px);
-webkit-backdrop-filter:blur(18px);
z-index:999;
border-bottom:1px solid rgba(255,255,255,.08);
transition:.4s;
}

.logo-wrap{
display:flex;
align-items:center;
gap:16px;
text-decoration:none;
}

.logo-wrap img{
width:110px;
height:110px;
object-fit:contain;
border-radius:50%;
transition:.35s;
filter:drop-shadow(0 10px 20px rgba(255,145,0,.22));
}

.logo-wrap img:hover{
transform:scale(1.18) translateY(-3px);
filter:drop-shadow(0 16px 24px rgba(0,0,0,.6));
}

/* Replace old .logo-text fully */

/* OLD .logo-text pura delete karke ye full code paste karo */

.logo-text{
font-size:52px;
font-weight:700;
letter-spacing:.5px;
display:flex;
align-items:center;
gap:0;
color:#ff9a00 !important;
background:none !important;
-webkit-text-fill-color:#ff9a00 !important;
text-shadow:0 0 10px rgba(255,140,0,.25);
animation:floatLogo 3s ease-in-out infinite;
}

/*.logo-text{
font-size:52px;
font-weight:600;
letter-spacing:.8px;
display:flex;
align-items:center;
gap:2px;
animation:floatLogo 3s ease-in-out infinite;
}*/
/* B and N */
.logo-text .bold{
font-size:66px;
font-weight:900;
color:#ffb000 !important;
background:none !important;
-webkit-text-fill-color:#ffb000 !important;
text-shadow:0 0 12px rgba(255,176,0,.35);
}


/* other letters */
.logo-text .normal{
font-size:52px;
font-weight:700;
color:#ff9a00 !important;
background:none !important;
-webkit-text-fill-color:#ff9a00 !important;
}


/* if spans not working */
.logo-text span{
background:none !important;
}

/* animation */
@keyframes floatLogo{
0%,100%{transform:translateY(0);}
50%{transform:translateY(-2px);}
}



.nav-links{
display:flex;
align-items:center;
gap:38px;
margin-left:-140px;
}

.nav-links a{
position:relative;
text-decoration:none;
font-size:18px;
font-weight:700;
color:#fff;
transition:.3s;
}

.nav-links a:hover{
color:#ffb300;
transform:translateY(-2px);
}

.nav-links a::after{
content:'';
position:absolute;
left:0;
bottom:-8px;
width:0%;
height:3px;
border-radius:20px;
background:linear-gradient(90deg,#ff9100,#ffd000);
transition:.35s;
}

.nav-links a:hover::after{
width:100%;
}

.cart-btn{
text-decoration:none;
padding:14px 28px;
border-radius:14px;
font-weight:800;
font-size:16px;
color:#fff;
background:linear-gradient(135deg,#ff9100,#ff6200);
box-shadow:0 12px 22px rgba(255,98,0,.22);
transition:.35s;
}

.cart-btn:hover{
transform:translateY(-3px) scale(1.03);
box-shadow:0 18px 26px rgba(255,98,0,.35);
}

/* ================= HERO ================= */

/* =========================
   FINAL PREMIUM HERO CSS
   Full Updated Version
========================= */

/* HERO SECTION */
.hero{
position:relative;
min-height:68vh;
display:flex;
align-items:center;
justify-content:center;
text-align:center;
padding:55px 20px 35px;
overflow:hidden;
background:
radial-gradient(circle at 20% 30%, rgba(255,136,0,.18), transparent 28%),
radial-gradient(circle at 80% 20%, rgba(255,208,0,.12), transparent 24%),
radial-gradient(circle at 70% 75%, rgba(255,90,0,.12), transparent 28%),
linear-gradient(135deg,#070012 0%,#13001d 35%,#1a0600 70%,#0a0718 100%);
}

/* animated glow */
.hero::before{
content:"";
position:absolute;
inset:-20%;
background:
conic-gradient(from 0deg,
rgba(255,170,0,.10),
rgba(255,90,0,.05),
rgba(255,210,0,.12),
rgba(255,170,0,.10));
filter:blur(70px);
animation:heroRotate 14s linear infinite;
}

/* floating particles */
.hero::after{
content:"";
position:absolute;
inset:0;
background-image:
radial-gradient(circle, rgba(255,190,80,.55) 1px, transparent 1px),
radial-gradient(circle, rgba(255,255,255,.35) 1px, transparent 1px);
background-size:120px 120px, 180px 180px;
background-position:0 0, 40px 60px;
opacity:.24;
animation:particlesMove 18s linear infinite;
}

.hero-content{
position:relative;
z-index:2;
max-width:1100px;
animation:heroFadeUp 1.1s ease;
}

/* welcome badge */
.hero-badge{
display:inline-block;
padding:10px 22px;
border-radius:999px;
border:1px solid rgba(255,180,0,.28);
background:rgba(255,255,255,.05);
backdrop-filter:blur(10px);
color:#ffc35a;
font-weight:700;
font-size:14px;
letter-spacing:.4px;
box-shadow:0 0 20px rgba(255,160,0,.12);
margin-bottom:24px;
}

/* MAIN TITLE */
.hero-title{
font-size:72px;
line-height:1.08;
font-weight:700;
color:#ffffff;
letter-spacing:-1px;
margin-bottom:18px;
text-shadow:0 10px 30px rgba(0,0,0,.35);
transition:.35s ease;
}

.hero-title:hover{
transform:translateY(-2px);
color:#ffffff;
}

/* COLOR CHANGING TEXT */
.hero-title span{
background:linear-gradient(90deg,
#ffd700,
#ff9a00,
#ff5100,
#ff00d0,
#8a5cff,
#00d4ff,
#00ff9d,
#ffd700);
background-size:400% 400%;
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
animation:heroColorShift 6s linear infinite;
font-weight:800;
}

/* MOVING SUBTITLE */
.hero-sub{
width:100%;
overflow:hidden;
white-space:nowrap;
margin-bottom:28px;
font-size:22px;
color:#ffe3b0;
font-weight:500;
}

.hero-sub span{
display:inline-block;
padding-left:100%;
animation:heroMarquee 18s linear infinite;
}

/* SEARCH BAR */
.hero-search{
width:min(760px,92%);
margin:0 auto 28px;
display:flex;
align-items:center;
border-radius:22px;
overflow:hidden;
background:rgba(255,255,255,.06);
border:1px solid rgba(255,255,255,.08);
backdrop-filter:blur(12px);
box-shadow:
0 10px 35px rgba(0,0,0,.30),
0 0 0 1px rgba(255,180,0,.08);
transition:.35s ease;
}

.hero-search:hover{
transform:translateY(-2px);
box-shadow:
0 18px 45px rgba(0,0,0,.36),
0 0 24px rgba(255,160,0,.14);
}

.hero-search input{
flex:1;
height:64px;
padding:0 26px;
border:none;
outline:none;
background:transparent;
color:#fff;
font-size:18px;
}

.hero-search input::placeholder{
color:rgba(255,255,255,.45);
}

.hero-search button{
width:82px;
height:64px;
border:none;
cursor:pointer;
font-size:24px;
font-weight:700;
color:#fff;
background:linear-gradient(135deg,#ffb300,#ff7a00);
transition:.3s ease;
}

.hero-search button:hover{
filter:brightness(1.08);
transform:scale(1.04);
}

/* STATS */
.hero-stats{
display:flex;
justify-content:center;
gap:70px;
flex-wrap:wrap;
margin-top:8px;
}

.hero-stat h3{
font-size:42px;
font-weight:900;
color:#fff;
margin-bottom:6px;
}

.hero-stat p{
font-size:15px;
color:rgba(255,255,255,.62);
}

/* ANIMATIONS */
@keyframes heroRotate{
from{transform:rotate(0deg);}
to{transform:rotate(360deg);}
}

@keyframes particlesMove{
0%{transform:translateY(0);}
100%{transform:translateY(80px);}
}

@keyframes heroFadeUp{
from{opacity:0;transform:translateY(35px);}
to{opacity:1;transform:translateY(0);}
}

@keyframes heroColorShift{
0%{background-position:0% 50%;}
100%{background-position:100% 50%;}
}

@keyframes heroMarquee{
0%{transform:translateX(0);}
100%{transform:translateX(-100%);}
}


/* ================= SECTION ================= */

/* =========================================
FEATURED BOOKS FULL PREMIUM FINAL CSS
Replace your current code with this
========================================= */

/* section */
.section{
padding:58px 26px;
background:transparent;
position:relative;
overflow:hidden;
}

/* premium background glow */
.section::before{
content:"";
position:absolute;
top:-120px;
left:-120px;
width:280px;
height:280px;
background:radial-gradient(circle,rgba(255,170,0,.12),transparent 70%);
filter:blur(35px);
}

.section::after{
content:"";
position:absolute;
right:-100px;
bottom:-100px;
width:260px;
height:260px;
background:radial-gradient(circle,rgba(123,97,255,.08),transparent 70%);
filter:blur(35px);
}

/* ================= FILTERS ================= */

.book-filters{
display:flex;
gap:12px;
flex-wrap:wrap;
margin-bottom:24px;
position:relative;
z-index:2;
}

.book-filter{
padding:11px 20px;
border-radius:999px;
background:#f7f7fb;
border:1px solid #dfe1ea;
font-size:14px;
font-weight:700;
color:#7a7a88;
cursor:pointer;
transition:.3s;
}

.book-filter.active,
.book-filter:hover{
background:linear-gradient(135deg,#ffb300,#ff8500);
border-color:transparent;
color:#fff;
box-shadow:0 8px 18px rgba(255,145,0,.18);
}

/* ================= TITLE ================= */

.section-head{
display:flex;
align-items:center;
gap:14px;
margin-bottom:22px;
flex-wrap:wrap;
position:relative;
z-index:2;
}

.section-title{
font-size:52px;
font-weight:900;
letter-spacing:-1px;
color:#111;
text-shadow:0 8px 18px rgba(0,0,0,.06);
}

.hot-badge{
padding:8px 16px;
border-radius:999px;
font-size:13px;
font-weight:800;
color:#fff;
background:linear-gradient(135deg,#ffb300,#ff6a00);
box-shadow:0 8px 18px rgba(255,136,0,.18);
display:inline-flex;
align-items:center;
gap:6px;
animation:hotPulse 2.2s infinite;
}

/* ================= BOOK GRID ================= */

.books-grid{
display:grid !important;
grid-template-columns:repeat(8, minmax(180px,1fr)) !important;
gap:26px !important;
align-items:start;
}

/* ================= CARD ================= */

.book-card{
width:100% !important;
max-width:100% !important;
margin:0 !important;
display:block !important;
}
/*.book-card{
position:relative;
background:rgba(255,255,255,.92);
border-radius:28px;
overflow:hidden;
box-shadow:
0 10px 35px rgba(0,0,0,.08),
0 0 0 1px rgba(255,255,255,.7);
transition:.45s ease;
backdrop-filter:blur(10px);
transform-style:preserve-3d;
}*/

.book-card{
position:relative;
background:rgba(255,255,255,.92);
border-radius:28px;
overflow:hidden;
box-shadow:0 10px 35px rgba(0,0,0,.08);
transition:.45s ease;
backdrop-filter:blur(10px);

display:flex;
flex-direction:column;
height:100%;
}

.book-card:hover{
transform:translateY(-10px);
box-shadow:
0 20px 45px rgba(255,140,0,.18),
0 10px 20px rgba(0,0,0,.10);
}

/* hover glow overlay */
.book-card::before{
content:"";
position:absolute;
top:0;
left:-120%;
width:70%;
height:100%;
background:linear-gradient(
90deg,
transparent,
rgba(255,255,255,.38),
transparent
);
transform:skewX(-25deg);
transition:.8s;
z-index:2;
}

.book-card::after{
content:"";
position:absolute;
inset:-2px;
border-radius:30px;
background:linear-gradient(135deg,#ffb300,#ff6a00,#ffce52);
z-index:-1;
opacity:0;
filter:blur(18px);
transition:.45s;
}

.book-card:hover{
transform:translateY(-12px) scale(1.02);
box-shadow:
0 30px 55px rgba(255,145,0,.16),
0 12px 25px rgba(0,0,0,.10);
}

.book-card:hover::before{
left:140%;
}

.book-card:hover::after{
opacity:.55;
}

/* image */
.book-card img{
width:100% !important;
height:220px !important;
object-fit:cover !important;
display:block;
}

.book-card img{
width:100%;
height:255px;
object-fit:cover;
transition:.55s ease;
}

.book-card:hover img{
transform:scale(1.08);
}

/* ================= INFO ================= */


.book-info{
padding:16px !important;
display:flex;
flex-direction:column;
flex:1;
}


.book-category{
display:inline-block;
padding:6px 12px;
border-radius:999px;
font-size:11px;
font-weight:800;
letter-spacing:.3px;
text-transform:uppercase;
color:#ff8a00;
background:#fff4df;
margin-bottom:10px;
}

.book-title{
/*font-size:28px;
font-weight:900;
line-height:1.18;
color:#111;
margin-bottom:8px;*/

font-size:28px;
font-weight:900;
line-height:1.18;
color:#111;
margin-bottom:8px;
min-height:72px;
display:flex;
align-items:flex-start;
}

.book-author{
font-size:14px;
color:#777;
margin-bottom:12px;
}

.book-rating{
font-size:14px;
font-weight:700;
color:#ff9800;
margin-bottom:10px;
}
.book-price{
font-size:22px;
font-weight:900;
color:#ff7a00;
margin-bottom:14px;
transition:.3s;
}

.book-card:hover .book-price{
transform:scale(1.08);
}
/* ================= BUTTON ================= */

.book-card form{
margin-top:auto;
}

.book-card form button{
width:100%;
height:48px;
border:none;
border-radius:16px;
cursor:pointer;
font-size:15px;
font-weight:800;
color:#fff;
background:linear-gradient(135deg,#ffb300,#ff7a00);
box-shadow:0 12px 24px rgba(255,145,0,.18);
transition:.35s;
}

.book-card form button:hover{
transform:translateY(-2px);
box-shadow:0 18px 28px rgba(255,145,0,.25);
filter:brightness(1.04);
}

/* top badge */
.book-badge{
position:absolute;
top:14px;
left:14px;
z-index:5;
padding:7px 12px;
border-radius:999px;
font-size:11px;
font-weight:800;
color:#fff;
background:linear-gradient(135deg,#ff3d00,#ff9800);
box-shadow:0 10px 22px rgba(255,100,0,.18);
}

/* stock badge */
.book-stock{
position:absolute;
top:14px;
right:14px;
z-index:5;
padding:7px 10px;
border-radius:999px;
font-size:11px;
font-weight:800;
color:#22a559;
background:#ecfff2;
}
/* animation */
@keyframes hotPulse{
0%,100%{transform:scale(1);}
50%{transform:scale(1.06);}
}

/* ================= FEATURES ================= */

.features{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:24px;
padding:40px 22px 55px;
background:
radial-gradient(circle at 20% 20%, rgba(255,153,0,.08), transparent 30%),
radial-gradient(circle at 80% 80%, rgba(255,80,0,.08), transparent 30%),
linear-gradient(135deg,#ececf5,#dfe1ef,#ececf5);
}

.feature-card{
background:rgba(255,255,255,.72);
backdrop-filter:blur(14px);
border:1px solid rgba(255,255,255,.55);
border-radius:26px;
padding:34px 24px;
text-align:center;
box-shadow:
0 12px 30px rgba(0,0,0,.08),
inset 0 1px 0 rgba(255,255,255,.7);
transition:all .35s ease;
position:relative;
overflow:hidden;
}

.feature-card::before{
content:"";
position:absolute;
top:0;
left:-120%;
width:60%;
height:100%;
background:linear-gradient(90deg,transparent,rgba(255,255,255,.55),transparent);
transition:.8s;
}

.feature-card:hover{
transform:translateY(-8px) scale(1.02);
box-shadow:0 18px 40px rgba(255,140,0,.18);
}

.feature-card:hover::before{
left:140%;
}

.feature-icon{
font-size:34px;
margin-bottom:14px;
display:block;
filter:drop-shadow(0 6px 10px rgba(255,153,0,.25));
}

.feature-card h3{
font-size:30px;
margin:0 0 8px;
font-weight:700;
background:linear-gradient(90deg,#ff9800,#ff5e00);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
}

.feature-card p{
font-size:15px;
color:#555;
line-height:1.6;
margin:0;
}

/*.feature-title{
font-size:20px;
font-weight:800;
margin-bottom:8px;
}

.feature-desc{
font-size:14px;
color:#666;
line-height:1.6;
}*/


/* ================= FOOTER ================= */

.footer{
padding:26px 15px;
text-align:center;
font-size:16px;
font-weight:500;
letter-spacing:.4px;
color:#fff;
background:
linear-gradient(90deg,#05051f,#140014,#2d1200,#05051f);
border-top:1px solid rgba(255,255,255,.08);
box-shadow:0 -10px 30px rgba(0,0,0,.18);
}

.footer span{
color:#ff9800;
font-weight:700;
}

.toast-success{
position:fixed;
top:105px;
right:30px;
background:linear-gradient(135deg,#14c96b,#0ea94f);
color:#fff;
padding:16px 24px;
border-radius:14px;
font-weight:700;
font-size:15px;
z-index:99999;
box-shadow:0 12px 30px rgba(0,0,0,.18);
animation:slideToast .5s ease;
}

@keyframes slideToast{
from{
opacity:0;
transform:translateX(100px);
}
to{
opacity:1;
transform:translateX(0);
}
}

@media (max-width:768px){

/* ================= NAVBAR ================= */
/* @media(max-width:768px) ke andar NAVBAR part replace karo */

.navbar{
height:auto;
padding:12px 14px;
display:flex;
flex-direction:column;
align-items:center;
gap:12px;
}

/* logo top */
.logo-wrap{
justify-content:center;
}

/* menu + cart same line */
.nav-links{
width:100%;
display:flex;
align-items:center;
justify-content:center;
gap:12px;
flex-wrap:nowrap;
}

.nav-links a{
font-size:14px;
white-space:nowrap;
}

/* cart same row me */
.cart-btn{
width:auto;
min-width:120px;
height:44px;
padding:0 18px;
font-size:15px;
margin-left:6px;
flex-shrink:0;
}

/* ================= HERO ================= */
.hero{
padding:18px 16px 24px;
gap:10px;
}

.hero-badge{
font-size:13px;
padding:8px 14px;
border-radius:30px;
}

.hero-title{
font-size:34px;
line-height:1.1;
margin:0;
}

.hero-title span{
display:block;
font-size:44px;
margin-top:4px;
}

.hero-sub{
font-size:14px;
white-space:nowrap !important;
overflow:hidden !important;
width:100%;
text-align:left;
line-height:1.4;
margin:0;
padding:0;
}

.hero-sub span{
display:inline-block !important;
padding-left:100%;
animation:marquee 12s linear infinite !important;
}

.hero-search{
margin-top:8px;
}

.hero-search input{
height:50px;
}

.hero-search button{
height:50px;
width:58px;
}

/* ================= STATS ================= */
.hero-stats{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:10px;
margin-top:10px;
width:100%;
}

.hero-stat{
padding:14px 10px;
background:rgba(255,255,255,.06);
border-radius:16px;
}

.hero-stat h3{
font-size:24px;
margin-bottom:4px;
}

.hero-stat p{
font-size:13px;
}

/* ================= FILTERS ================= */
.book-filters{
overflow-x:auto;
flex-wrap:nowrap;
gap:10px;
padding-bottom:8px;
}

.book-filter{
flex:0 0 auto;
}

/* ================= SECTION ================= */
.section{
padding:32px 14px;
}

.section-title{
font-size:32px;
line-height:1.15;
}

/* ================= BOOKS ================= */
.books-grid{
grid-template-columns:1fr;
gap:18px;
}

.book-card{
border-radius:22px;
overflow:hidden;
}

.book-card img{
height:260px !important;
object-fit:cover;
}

.book-title{
font-size:24px;
min-height:auto;
line-height:1.2;
}

/* ================= FEATURES ================= */
.features{
grid-template-columns:1fr;
padding:10px 14px 40px;
gap:16px;
}

/* ================= FOOTER ================= */
.footer{
font-size:14px;
padding:24px 14px;
text-align:center;
}

}
</style>
</head>

<body>

    <div id="loader">
    <div class="loader-box">
        <div class="loader-ring"></div>
        <h1>BookNest</h1>
        <p>Loading your premium library...</p>
    </div>
</div>
<!-- ================= NAVBAR ================= -->

<nav class="navbar">

<a href="<%=request.getContextPath()%>/books" class="logo-wrap">
<img src="<%=request.getContextPath()%>/assets/books/logo.png" alt="BookNest Logo">
<div class="logo-text">BookNest</div>
</a>

<div class="nav-links">

<a href="<%=request.getContextPath()%>/books">Home</a>

<% if(loggedUser == null){ %>
<a href="<%=request.getContextPath()%>/login.jsp">Login</a>
<a href="<%=request.getContextPath()%>/register.jsp">Register</a>
<% } else { %>
<a href="#">Hi, <%=loggedUser.getUsername()%></a>
<a href="<%=request.getContextPath()%>/logout">Logout</a>
<% } %>

</div>

<a href="<%=request.getContextPath()%>/cart" class="cart-btn">
🛒 Cart (<%=cartCount%>)
</a>

</nav>

<%
String successMsg = (String) session.getAttribute("successMsg");
if(successMsg != null){
%>

<div id="toastMsg" class="toast-success">
    <%=successMsg%>
</div>

<%
session.removeAttribute("successMsg");
}
%>
<!-- ================= HERO ================= -->

<!-- =========================================
FULL FINAL HERO SECTION
Paste inside body where old hero section is
========================================= -->

<section class="hero">
    <div class="hero-content">

        <div class="hero-badge">✨ Welcome to BookNest</div>

        <h1 class="hero-title">
            Where every book finds <br>
            <span>its perfect nest</span>
        </h1>

        <p class="hero-sub">
            <span>
                Thousands of books curated for passionate readers • Learn • Grow • Escape into stories • Best sellers • New arrivals • Premium collection
            </span>
        </p>

        <form action="books" method="get" class="hero-search">
            <input type="text" name="search" placeholder="Search by title, author, category...">
            <button type="submit">🔎</button>
        </form>

        <div class="hero-stats">

            <div class="hero-stat">
                <h3>500+</h3>
                <p>Books</p>
            </div>

            <div class="hero-stat">
                <h3>80+</h3>
                <p>Authors</p>
            </div>

            <div class="hero-stat">
                <h3>2K+</h3>
                <p>Happy Readers</p>
            </div>

        </div>

    </div>
</section>

<!-- ================= FEATURED BOOKS SECTION ================= -->

<section class="section">

<div class="book-filters">
<a href="books" class="book-filter active">All</a>

<a href="books?category=Tech" class="book-filter">Tech</a>

<a href="books?category=Fiction" class="book-filter">Fiction</a>

<a href="books?category=Self-Help" class="book-filter">Self-Help</a>
</div>

<div class="section-head">
<h2 class="section-title">Featured Books</h2>
<div class="hot-badge">🔥 Hot Picks</div>
</div>

<div class="books-grid">

<% for(Book book : books){ %>

<!-- =========================================
PART 2 - SMART PREMIUM BOOK CARD HTML
========================================= -->

<div class="book-card">

    <!-- Auto badges -->
    <div class="book-badge">
        <%= book.getPrice() > 450 ? "🔥 Bestseller" :
            book.getPrice() < 320 ? "🆕 New" :
            "⭐ Popular" %>
    </div>

    <div class="book-stock">
        <%= book.getPrice() > 500 ? "Only 3 Left" : "In Stock" %>
    </div>

    <!-- Book image -->
    <img src="<%=request.getContextPath()%>/assets/books/<%=book.getImage()%>"
         alt="<%=book.getTitle()%>">

    <!-- Info -->
    <div class="book-info">

        <div class="book-category">
            <%=book.getCategory()%>
        </div>

        <div class="book-title">
            <%=book.getTitle()%>
        </div>

        <div class="book-author">
            by <%=book.getAuthor()%>
        </div>

        <!-- Rating -->
        <div class="book-rating">
            ⭐ 4.<%= (int)(Math.random()*5)+4 %> / 5
        </div>

        <div class="book-price">
            ₹<%=book.getPrice()%>.0
        </div>

        <!-- Add To Cart -->
        <form action="addToCart" method="post">
            <input type="hidden" name="bookId" value="<%=book.getId()%>">
            <button type="submit">Add To Cart</button>
        </form>

    </div>

</div>

<% } %>

</div>
</section>

<!-- ================= FEATURES ================= -->

<section class="features">

<div class="feature-card">
    <div class="feature-icon">🚚</div>
    <h3>Fast Delivery</h3>
    <p>Quick and secure delivery to your doorstep.</p>
</div>

<div class="feature-card">
    <div class="feature-icon">🔒</div>
    <h3>Secure Payments</h3>
    <p>Trusted checkout with safe transactions.</p>
</div>

<div class="feature-card">
    <div class="feature-icon">📚</div>
    <h3>Best Collection</h3>
    <p>Handpicked premium books across genres.</p>
</div>

</section>

<!-- ================= FOOTER ================= -->

<footer class="footer">
© 2026 BookNest — Premium Online Book Store 📚
</footer>

<script>
setTimeout(function(){
let toast = document.getElementById("toastMsg");
if(toast){
toast.style.transition="0.5s";
toast.style.opacity="0";
toast.style.transform="translateX(100px)";
}
},2200);
</script>

<script>
window.addEventListener("load", function(){
setTimeout(function(){
document.getElementById("loader").classList.add("loader-hide");
},900);
});
</script>

</body>
</html>
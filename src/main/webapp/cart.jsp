<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.booknest.model.Book" %>
<%@ page import="com.booknest.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNest — My Cart</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&display=swap');
        *{box-sizing:border-box;margin:0;padding:0;}
        
/*margin:0;
padding:0;
font-family:'Poppins',sans-serif;
background:
radial-gradient(circle at top left, rgba(255,166,0,.12), transparent 25%),
radial-gradient(circle at top right, rgba(255,90,0,.10), transparent 20%),
linear-gradient(135deg,#f7f7fb,#f1f1f8,#ececf5);
min-height:100vh;
overflow-x:hidden;*/

body{
margin:0;
padding:0;
font-family:'Sora',sans-serif !important;
min-height:100vh;
overflow-x:hidden;

background:
radial-gradient(circle at 10% 20%, rgba(255,140,0,.55), transparent 24%),
radial-gradient(circle at 88% 15%, rgba(255,60,0,.38), transparent 22%),
radial-gradient(circle at 80% 85%, rgba(255,170,0,.30), transparent 20%),
radial-gradient(circle at 15% 80%, rgba(255,110,0,.24), transparent 18%),
linear-gradient(135deg,#ececf3 0%, #dddded 45%, #d5d5e8 100%);
}

        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes titleFlow{
0%{background-position:0% 50%;}
100%{background-position:100% 50%;}
}
        @keyframes nestFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
        .bn-nav{
height:72px;
display:flex;
align-items:center;
justify-content:space-between;
padding:0 28px;
position:sticky;
top:0;
z-index:999;
backdrop-filter:blur(14px);
background:
linear-gradient(90deg,
rgba(8,8,30,.95),
rgba(25,10,40,.92),
rgba(45,18,0,.92),
rgba(8,8,30,.95));
border-bottom:1px solid rgba(255,255,255,.08);
box-shadow:
0 10px 30px rgba(0,0,0,.25),
0 0 35px rgba(255,145,0,.08);
}
        .bn-logo{
display:flex;
align-items:center;
gap:12px;
text-decoration:none;
transition:.3s ease;
}

.bn-logo:hover{
transform:translateY(-2px) scale(1.02);
}
.bn-logo-icon{
display:flex;
align-items:center;
justify-content:center;
background:none;
width:auto;
height:auto;
padding:0;
border-radius:0;
box-shadow:none;
animation:none;
}

.bn-logo-text{
font-size:35px;
font-weight:900;
letter-spacing:-0.5px;
background:linear-gradient(90deg,#ffd54f,#ff9800,#ff6a00);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
text-shadow:0 0 12px rgba(255,145,0,.22);
}
        .bn-back{
color:#ffffff;
font-size:13px;
padding:10px 16px;
border-radius:12px;
text-decoration:none;
transition:all .3s ease;
background:rgba(255,255,255,.05);
border:1px solid rgba(255,255,255,.08);
backdrop-filter:blur(10px);
}

.bn-back:hover{
background:linear-gradient(135deg,#ff9800,#ff6a00);
color:#fff;
transform:translateY(-2px);
box-shadow:0 10px 24px rgba(255,145,0,.25);
}

.bn-wrap{
max-width:760px;
margin:55px auto;
padding:0 20px;
position:relative;
z-index:2;
}
        .bn-page-title{
font-size:42px;
font-weight:900;
margin-bottom:28px;
animation:fadeUp 0.5s ease both;
letter-spacing:-1px;
line-height:1.1;
background:linear-gradient(90deg,#111,#333,#ff8a00,#ffb300);
background-size:300% 300%;
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
animation:
fadeUp .5s ease both,
titleFlow 6s linear infinite;
text-shadow:0 8px 18px rgba(0,0,0,.06);
}
        .bn-empty{
width:100%;
max-width:720px;
margin:40px auto;
padding:55px 35px;
text-align:center;
border-radius:28px;

background:linear-gradient(
135deg,
rgba(255,255,255,.92),
rgba(255,255,255,.72)
);

backdrop-filter:blur(18px);
border:1px solid rgba(255,255,255,.55);

box-shadow:
0 18px 45px rgba(0,0,0,.08),
0 8px 18px rgba(255,140,0,.08);

animation:fadeUp .5s ease both;
}

.bn-empty-icon{
font-size:64px;
margin-bottom:18px;
animation:nestFloat 2.8s ease-in-out infinite;
}

.bn-empty h3{
font-size:28px;
font-weight:800;
color:#111;
margin-bottom:12px;
}

.bn-empty p{
font-size:16px;
color:#666;
margin-bottom:28px;
line-height:1.6;
}

.bn-empty a{
display:inline-block;
padding:14px 34px;
border-radius:16px;
text-decoration:none;
font-size:15px;
font-weight:700;
color:#fff;
background:linear-gradient(135deg,#ffb300,#ff7a00);
box-shadow:0 14px 28px rgba(255,145,0,.22);
transition:.3s ease;
}

.bn-empty a:hover{
transform:translateY(-3px);
box-shadow:0 18px 32px rgba(255,145,0,.30);
}
        .bn-item{
background:rgba(255,255,255,0.88);
border:1px solid rgba(255,255,255,0.65);
border-radius:24px;
padding:20px 22px;
display:flex;
align-items:center;
gap:18px;
margin-bottom:18px;
animation:fadeUp 0.5s ease both;
transition:all .35s ease;
backdrop-filter:blur(10px);
box-shadow:0 12px 28px rgba(0,0,0,.06);
}

.bn-item:hover{
transform:translateY(-6px);
box-shadow:0 18px 35px rgba(255,140,0,.14);
border-color:#ffd89a;
}
        .bn-item:hover{border-color:#f59e0b;}
        .bn-item-emoji{
width:74px;
height:74px;
background:linear-gradient(135deg,#fff7cf,#ffc85e,#ffb300);
border-radius:22px;
display:flex;
align-items:center;
justify-content:center;
font-size:34px;
flex-shrink:0;
box-shadow:0 12px 24px rgba(255,170,0,.18);
transition:all .35s ease;
}

.bn-item:hover .bn-item-emoji{
transform:rotate(-6deg) scale(1.08);
box-shadow:0 18px 30px rgba(255,145,0,.24);
}
        .bn-item-info{flex:1;}
        .bn-item-title{font-size:15px;font-weight:600;color:#1f2937;margin-bottom:3px;}
        .bn-item-author{font-size:13px;color:#9ca3af;margin-bottom:4px;}
        .bn-item-qty{font-size:12px;color:#6b7280;background:#f3f4f6;padding:3px 10px;border-radius:20px;display:inline-block;}
        .bn-item-price{font-size:16px;font-weight:600;background:linear-gradient(90deg,#d97706,#f97316);-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-right:12px;}
        .bn-remove{background:rgba(239,68,68,0.08);color:#ef4444;border:1px solid rgba(239,68,68,0.2);padding:6px 14px;border-radius:8px;font-size:12px;cursor:pointer;text-decoration:none;transition:all 0.2s;font-family:'Inter',sans-serif;}
        .bn-remove:hover{background:rgba(239,68,68,0.15);}
        .bn-total-card{
background:rgba(255,255,255,.92);
border:1px solid rgba(255,255,255,.72);
border-radius:28px;
padding:28px 30px;
margin-top:28px;
animation:fadeUp 0.6s ease both;
backdrop-filter:blur(12px);
box-shadow:
0 16px 38px rgba(0,0,0,.07),
0 0 0 1px rgba(255,255,255,.55);
position:relative;
overflow:hidden;
}

.bn-total-card::before{
content:"";
position:absolute;
top:-70px;
right:-70px;
width:180px;
height:180px;
background:radial-gradient(circle,rgba(255,179,0,.16),transparent 70%);
filter:blur(18px);
}
        .bn-total-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid #f3f4f6;font-size:14px;color:#6b7280;}
        .bn-total-final{display:flex;justify-content:space-between;align-items:center;padding-top:14px;font-size:18px;font-weight:600;color:#1f2937;}
        .bn-total-amt{background:linear-gradient(90deg,#d97706,#f97316);-webkit-background-clip:text;-webkit-text-fill-color:transparent;font-size:20px;}
        .bn-checkout{
width:100%;
height:58px;
background:linear-gradient(135deg,#ffb300,#ff7a00);
color:#fff;
border:none;
border-radius:18px;
font-size:17px;
font-weight:800;
cursor:pointer;
font-family:'Inter',sans-serif;
margin-top:20px;
transition:all .35s ease;
box-shadow:0 14px 28px rgba(255,145,0,.22);
letter-spacing:.3px;
position:relative;
overflow:hidden;
}

.bn-checkout::before{
content:"";
position:absolute;
top:0;
left:-120%;
width:60%;
height:100%;
background:linear-gradient(
90deg,
transparent,
rgba(255,255,255,.35),
transparent
);
transform:skewX(-25deg);
transition:.7s;
}

.bn-checkout:hover{
transform:translateY(-3px) scale(1.02);
box-shadow:0 22px 34px rgba(255,145,0,.30);
}

.bn-checkout:hover::before{
left:140%;
}

.bn-checkout:active{
transform:scale(.98);
}

.bn-book-img{
width:58px;
height:78px;
object-fit:cover;
border-radius:10px;
}

.bn-qty-box{
display:flex;
align-items:center;
gap:10px;
margin-top:8px;
}

.qty-btn{
width:28px;
height:28px;
border-radius:50%;
background:#ff9800;
color:#fff;
text-decoration:none;
display:flex;
align-items:center;
justify-content:center;
font-size:18px;
font-weight:700;
}

.qty-num{
font-size:18px;
font-weight:700;
min-width:20px;
text-align:center;
}

@media (max-width: 768px){

.bn-nav{
padding:12px 16px;
height:auto;
flex-wrap:wrap;
gap:12px;
}

.bn-logo-text{
font-size:28px;
}

.bn-wrap{
padding:0 14px;
margin:30px auto;
}

.bn-page-title{
font-size:34px;
text-align:center;
}

.bn-item{
flex-direction:column;
align-items:flex-start;
gap:14px;
padding:18px;
}

.bn-item-price{
margin:0;
font-size:22px;
}

.bn-remove{
width:100%;
text-align:center;
}

.bn-total-card{
padding:20px;
}

.bn-checkout{
height:52px;
font-size:16px;
}

}
    </style>
</head>
<body>

<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    Map<Book, Integer> cartItems = (Map<Book, Integer>) request.getAttribute("cartItems");
    Double total = (Double) request.getAttribute("total");
    if (total == null) total = 0.0;
%>

<nav class="bn-nav">
    <a href="<%= request.getContextPath() %>/books" class="bn-logo">
        <div class="bn-logo-icon">
<img src="<%=request.getContextPath()%>/assets/books/logo.png"
style="width:100px;height:100px;object-fit:contain;">
</div>
        <div class="bn-logo-text">BookNest</div>
    </a>
    <a href="<%= request.getContextPath() %>/books" class="bn-back">← Continue Shopping</a>
</nav>

<div class="bn-wrap">
    <div class="bn-page-title">🛒 Your Nest Cart</div>

    <% if (cartItems == null || cartItems.isEmpty()) { %>
        <div class="bn-empty">
            <div class="bn-empty-icon">🪺</div>
            <h3>Your nest is empty!</h3>
            <p>Add some books to get started on your reading journey.</p>
            <a href="<%= request.getContextPath() %>/books">Browse Books</a>
        </div>
    <% } else { %>
        <% int i = 0; for (Map.Entry<Book, Integer> entry : cartItems.entrySet()) {
            Book book = entry.getKey();
            int qty = entry.getValue(); %>
            <div class="bn-item" style="animation-delay:<%= i * 0.08 %>s">
                <div class="bn-item-emoji">
                     <img src="<%=request.getContextPath()%>/assets/books/<%=book.getImage()%>" class="bn-book-img">
                </div>
                <div class="bn-item-info">
                    <div class="bn-item-title"><%= book.getTitle() %></div>
                    <div class="bn-item-author"><%= book.getAuthor() %></div>
                    <div class="bn-qty-box">

<a href="<%=request.getContextPath()%>/updateQty?bookId=<%=book.getId()%>&action=minus" class="qty-btn">-</a>

<span class="qty-num"><%= qty %></span>

<a href="<%=request.getContextPath()%>/updateQty?bookId=<%=book.getId()%>&action=plus" class="qty-btn">+</a>

</div>
                </div>
                <span class="bn-item-price">₹<%= String.format("%.0f", book.getPrice() * qty) %></span>
                <a href="<%= request.getContextPath() %>/removeFromCart?bookId=<%= book.getId() %>" class="bn-remove">Remove</a>
            </div>
        <% i++; } %>

        <div class="bn-total-card">
            <div class="bn-total-row">
                <span>Subtotal</span>
                <span>₹<%= String.format("%.0f", total) %></span>
            </div>
            <div class="bn-total-row">
                <span>Delivery</span>
                <span style="color:#059669;">FREE</span>
            </div>
            <div class="bn-total-final">
                <span>Total</span>
                <span class="bn-total-amt">₹<%= String.format("%.0f", total) %></span>
            </div>
            <button class="bn-checkout">Proceed to Checkout 🚀</button>
        </div>
    <% } %>
</div>

</body>
</html>
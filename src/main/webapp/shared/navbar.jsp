<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
</head>
<body>
<% 
    String fullname = (String) session.getAttribute("fullname"); 
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null) isAdmin = false;
%>

<nav class="navbar navbar-expand-lg bg-light shadow-sm p-3 mb-4">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center gap-4">
            <a class="navbar-brand text-dark fw-bold" href="home">🛒 IIT Store</a>
            <a class="nav-link text-dark fw-semibold" href="categories">Products</a>
            <a class="nav-link text-dark fw-semibold" href="cart">
                Cart
                <%
                    @SuppressWarnings("unchecked")
                    java.util.List<org.example.model.CartItem> cart =
                            (java.util.List<org.example.model.CartItem>) session.getAttribute("cart");
                    int cartCount = (cart != null) ? cart.size() : 0;
                    if (cartCount > 0) { %>
                <span class="badge bg-danger"><%= cartCount %></span>
                <% } %>
            </a>
            <% if (isAdmin) { %>
            <a class="nav-link text-dark fw-semibold" href="admin">
                <span class="badge bg-purple" style="background-color: #764ba2;">Admin Panel</span>
            </a>
            <% } %>
        </div>

        <div class="d-flex align-items-center gap-3">
            <% if (fullname != null) { %>
            <span class="navbar-text text-secondary fw-bold">👤 <%= fullname %> <%= isAdmin ? "(Admin)" : "" %></span>
            <a href="logout" class="btn btn-outline-danger btn-sm">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"/>
                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
                </svg>
                Logout
            </a>
            <% } %>
        </div>
    </div>
</nav>

<style>
    .nav-link:hover,
    .navbar-brand:hover {
        color: #0d6efd !important;
        text-decoration: none;
    }
    .navbar { border-radius: 8px; }
    .btn-outline-danger:hover {
        background-color: #dc3545;
        color: white;
    }
</style>
</body>
</html>

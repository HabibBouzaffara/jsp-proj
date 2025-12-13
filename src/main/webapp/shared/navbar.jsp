<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
</head>
<body>
<% String fullname = (String) session.getAttribute("fullname"); %>

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
            <a class="nav-link text-dark fw-semibold" href="discount">
                <span class="badge bg-purple" style="background-color: #764ba2;">Admin</span>
            </a>
        </div>

        <% if (fullname != null) { %>
        <span class="navbar-text text-secondary fw-bold">👤 <%= fullname %></span>
        <% } %>
    </div>
</nav>

<style>
    .nav-link:hover,
    .navbar-brand:hover {
        color: #0d6efd !important;
        text-decoration: none;
    }
    .navbar { border-radius: 8px; }
</style>
</body>
</html>

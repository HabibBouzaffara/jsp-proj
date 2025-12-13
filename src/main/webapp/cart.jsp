<%@ page import="java.util.List" %>
<%@ page import="org.example.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        .cart-item {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            transition: box-shadow 0.3s;
        }
        .cart-item:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #c3e6cb;
            margin: 20px 0;
            animation: fadeIn 0.5s;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .discount-badge {
            background: #ff4444;
            color: white;
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">
<%@ include file="shared/navbar.jsp" %>

<div class="container py-4">
    <h1 class="text-center mb-4">Shopping Cart</h1>

    <%
        Boolean success = (Boolean) session.getAttribute("purchaseSuccess");
        if (success != null && success) {
            session.removeAttribute("purchaseSuccess");
    %>
    <div class="success-message text-center">
        <h4>✓ Purchase Successful!</h4>
        <p>Thank you for your order. Your cart has been cleared.</p>
    </div>
    <% } %>

    <%
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        if (cartItems != null && !cartItems.isEmpty()) {
            double total = 0;
            for (CartItem item : cartItems) {
                total += item.getSubtotal();
    %>
    <div class="cart-item">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h5><%= item.getProduct().getName() %></h5>
                <p class="text-muted mb-1"><%= item.getProduct().getDescription() %></p>
                <% if (item.getProduct().getDiscount() > 0) { %>
                <span class="discount-badge"><%= String.format("%.0f%% OFF", item.getProduct().getDiscount()) %></span>
                <% } %>
            </div>
            <div class="col-md-3 text-center">
                <p class="mb-0">Quantity: <%= item.getQuantity() %></p>
                <% if (item.getProduct().getDiscount() > 0) { %>
                <p class="mb-0">
                    <del>$<%= String.format("%.2f", item.getProduct().getPrice()) %></del>
                    <strong class="text-success"> $<%= String.format("%.2f", item.getProduct().getFinalPrice()) %></strong>
                </p>
                <% } else { %>
                <p class="mb-0"><strong>$<%= String.format("%.2f", item.getProduct().getPrice()) %></strong></p>
                <% } %>
            </div>
            <div class="col-md-3 text-end">
                <p class="mb-2"><strong>Subtotal: $<%= String.format("%.2f", item.getSubtotal()) %></strong></p>
                <form method="post" action="cart" style="display:inline;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                </form>
            </div>
        </div>
    </div>
    <% } %>

    <div class="card mt-4">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center">
                <h3>Total: $<%= String.format("%.2f", total) %></h3>
                <form method="post" action="cart">
                    <input type="hidden" name="action" value="buy">
                    <button type="submit" class="btn btn-success btn-lg">Complete Purchase</button>
                </form>
            </div>
        </div>
    </div>

    <% } else { %>
    <div class="alert alert-info text-center">
        <h4>Your cart is empty</h4>
        <p>Start shopping to add items to your cart!</p>
        <a href="categories" class="btn btn-primary">Browse Products</a>
    </div>
    <% } %>
</div>
</body>
</html>

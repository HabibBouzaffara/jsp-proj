<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in as client
    if (session.getAttribute("user") == null || !"client".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar {
            background: #333;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container { max-width: 1000px; margin: 2rem auto; padding: 0 20px; }
        .cart-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .cart-total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
            color: #28a745;
        }
        .btn-checkout {
            background: #28a745;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            float: right;
            margin-top: 20px;
        }
        .btn-back {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🛒 Shopping Cart</h1>
        <span>Welcome, <%= username %>!</span>
    </nav>

    <div class="container">
        <a href="shop.jsp" class="btn-back">← Back to Shop</a>
        
        <div class="cart-container">
            <h2>Your Cart Items</h2>
            <div id="cartItems">
                <p style="text-align: center; padding: 40px; color: #999;">
                    Your cart is empty. Start shopping to add items!
                </p>
            </div>
            
            <div class="cart-total" id="cartTotal" style="display: none;">
                Total: $0.00
            </div>
            
            <button class="btn-checkout" onclick="checkout()" style="display: none;" id="checkoutBtn">
                Proceed to Checkout
            </button>
        </div>
    </div>

    <script>
        function checkout() {
            alert('Checkout functionality - In real app: Process payment and create order');
            // Redirect to order confirmation
        }
    </script>
</body>
</html>
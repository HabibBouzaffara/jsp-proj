<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Discounts</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        body { background: #f8f9fa; }
        .admin-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .discount-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<%@ include file="shared/navbar.jsp" %>

<div class="container py-4">
    <div class="admin-header text-center">
        <h1>🛠️ Admin Dashboard</h1>
        <p class="mb-0">Manage Discounts for Categories and Products</p>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">Discount applied successfully!</div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger">Error applying discount. Please try again.</div>
    <% } %>

    <div class="row">
        <!-- Category Discounts -->
        <div class="col-md-6">
            <div class="discount-card">
                <h3>Category Discounts</h3>
                <form method="post" action="discount">
                    <input type="hidden" name="type" value="category">

                    <div class="mb-3">
                        <label class="form-label">Select Category</label>
                        <select name="categoryId" class="form-control" required>
                            <%
                                @SuppressWarnings("unchecked")
                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                if (categories != null) {
                                    for (Category cat : categories) { %>
                            <option value="<%= cat.getId() %>">
                                <%= cat.getName() %>
                                <% if (cat.getDiscount() > 0) { %>
                                (Current: <%= String.format("%.0f%%", cat.getDiscount()) %>)
                                <% } %>
                            </option>
                            <% }
                            } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Discount (%)</label>
                        <input type="number" step="0.01" name="discount" class="form-control"
                               min="0" max="100" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Apply Category Discount</button>
                </form>
            </div>
        </div>

        <!-- Product Discounts -->
        <div class="col-md-6">
            <div class="discount-card">
                <h3>Product Discounts</h3>
                <form method="post" action="discount">
                    <input type="hidden" name="type" value="product">

                    <div class="mb-3">
                        <label class="form-label">Select Category</label>
                        <select id="categorySelect" name="categoryId" class="form-control" required onchange="updateProducts()">
                            <option value="">-- Choose Category --</option>
                            <% if (categories != null) {
                                for (Category cat : categories) { %>
                            <option value="<%= cat.getId() %>" data-products='<%= cat.getProducts() %>'>
                                <%= cat.getName() %>
                            </option>
                            <% }
                            } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Select Product</label>
                        <select id="productSelect" name="productId" class="form-control" required>
                            <option value="">-- Choose Product --</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Discount (%)</label>
                        <input type="number" step="0.01" name="discount" class="form-control"
                               min="0" max="100" required>
                    </div>

                    <button type="submit" class="btn btn-success w-100">Apply Product Discount</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Current Discounts Overview -->
    <div class="discount-card mt-4">
        <h3>Current Discounts Overview</h3>
        <% if (categories != null) {
            for (Category cat : categories) {
                if (cat.getDiscount() > 0 || cat.getProducts().stream().anyMatch(p -> p.getDiscount() > 0)) { %>
        <div class="mb-3">
            <h5><%= cat.getName() %>
                <% if (cat.getDiscount() > 0) { %>
                <span class="badge bg-danger"><%= String.format("%.0f%% OFF", cat.getDiscount()) %></span>
                <% } %>
            </h5>
            <ul>
                <% for (Product p : cat.getProducts()) {
                    if (p.getDiscount() > 0) { %>
                <li><%= p.getName() %> - <strong><%= String.format("%.0f%%", p.getDiscount()) %> OFF</strong></li>
                <% }
                } %>
            </ul>
        </div>
        <% }
        }
        } %>
    </div>
</div>

<script>
    function updateProducts() {
        const categorySelect = document.getElementById('categorySelect');
        const productSelect = document.getElementById('productSelect');
        const categoryId = categorySelect.value;

        productSelect.innerHTML = '<option value="">-- Choose Product --</option>';

        if (categoryId) {
            <% if (categories != null) {
                for (Category cat : categories) { %>
            if (<%= cat.getId() %> == categoryId) {
                <% for (Product p : cat.getProducts()) { %>
                const option = document.createElement('option');
                option.value = '<%= p.getId() %>';
                option.text = '<%= p.getName() %><% if (p.getDiscount() > 0) { %> (Current: <%= String.format("%.0f%%", p.getDiscount()) %>)<% } %>';
                productSelect.appendChild(option);
                <% } %>
            }
            <% }
        } %>
        }
    }
</script>
</body>
</html>

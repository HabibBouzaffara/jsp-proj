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

<%
    // Check admin access
    Boolean isAdminUser = (Boolean) session.getAttribute("isAdmin");
    if (isAdminUser == null || !isAdminUser) {
        response.sendRedirect("home");
        return;
    }
%>

<div class="container py-4">
    <div class="admin-header text-center">
        <h1>🛠️ Admin Dashboard</h1>
        <p class="mb-0">Manage Discounts for Categories and Products</p>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Discount applied successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Error applying discount. Please try again.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row">
        <!-- Category Discounts -->
        <div class="col-md-6">
            <div class="discount-card">
                <h3>📁 Category Discounts</h3>
                <p class="text-muted">Apply discount to all products in a category</p>
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
                               min="0" max="100" required placeholder="Enter discount percentage">
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Apply Category Discount</button>
                </form>
            </div>
        </div>

        <!-- Product Discounts -->
        <div class="col-md-6">
            <div class="discount-card">
                <h3>📦 Product Discounts</h3>
                <p class="text-muted">Apply discount to a specific product</p>
                <form method="post" action="discount">
                    <input type="hidden" name="type" value="product">

                    <div class="mb-3">
                        <label class="form-label">Select Category</label>
                        <select id="categorySelect" name="categoryId" class="form-control" required onchange="updateProducts()">
                            <option value="">-- Choose Category --</option>
                            <% if (categories != null) {
                                for (Category cat : categories) { %>
                            <option value="<%= cat.getId() %>">
                                <%= cat.getName() %> (<%= cat.getProducts().size() %> products)
                            </option>
                            <% }
                            } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Select Product</label>
                        <select id="productSelect" name="productId" class="form-control" required>
                            <option value="">-- First Choose a Category --</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Discount (%)</label>
                        <input type="number" step="0.01" name="discount" class="form-control"
                               min="0" max="100" required placeholder="Enter discount percentage">
                    </div>

                    <button type="submit" class="btn btn-success w-100">Apply Product Discount</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Current Discounts Overview -->
    <div class="discount-card mt-4">
        <h3>📊 Current Discounts Overview</h3>
        <% 
            boolean hasDiscounts = false;
            if (categories != null) {
                for (Category cat : categories) {
                    if (cat.getDiscount() > 0 || cat.getProducts().stream().anyMatch(p -> p.getDiscount() > 0)) {
                        hasDiscounts = true;
                        break;
                    }
                }
            }
            
            if (!hasDiscounts) {
        %>
        <p class="text-muted text-center py-4">No active discounts. Start by applying discounts above.</p>
        <% 
            } else {
                for (Category cat : categories) {
                    if (cat.getDiscount() > 0 || cat.getProducts().stream().anyMatch(p -> p.getDiscount() > 0)) { 
        %>
        <div class="mb-3 p-3 border rounded">
            <h5><%= cat.getName() %>
                <% if (cat.getDiscount() > 0) { %>
                <span class="badge bg-danger"><%= String.format("%.0f%% OFF", cat.getDiscount()) %></span>
                <% } %>
            </h5>
            <ul class="mb-0">
                <% for (Product p : cat.getProducts()) {
                    if (p.getDiscount() > 0) { %>
                <li><%= p.getName() %> - <strong class="text-success"><%= String.format("%.0f%%", p.getDiscount()) %> OFF</strong> 
                    <span class="text-muted">(Was $<%= String.format("%.2f", p.getPrice()) %> → Now $<%= String.format("%.2f", p.getFinalPrice()) %>)</span>
                </li>
                <% }
                } %>
            </ul>
        </div>
        <% 
                    }
                }
            }
        %>
    </div>
</div>

<script>
    // Store products data in JavaScript
    const productsData = {
        <% 
        if (categories != null) {
            for (int i = 0; i < categories.size(); i++) {
                Category cat = categories.get(i);
        %>
        <%= cat.getId() %>: [
            <% 
            List<Product> products = cat.getProducts();
            for (int j = 0; j < products.size(); j++) {
                Product p = products.get(j);
            %>
            {
                id: <%= p.getId() %>,
                name: '<%= p.getName().replace("'", "\\'") %>',
                discount: <%= p.getDiscount() %>
            }<%= j < products.size() - 1 ? "," : "" %>
            <% } %>
        ]<%= i < categories.size() - 1 ? "," : "" %>
        <% 
            }
        }
        %>
    };

    function updateProducts() {
        const categorySelect = document.getElementById('categorySelect');
        const productSelect = document.getElementById('productSelect');
        const categoryId = parseInt(categorySelect.value);

        // Clear current options
        productSelect.innerHTML = '<option value="">-- Choose Product --</option>';

        if (categoryId && productsData[categoryId]) {
            const products = productsData[categoryId];
            
            if (products.length === 0) {
                productSelect.innerHTML = '<option value="">-- No products in this category --</option>';
            } else {
                products.forEach(product => {
                    const option = document.createElement('option');
                    option.value = product.id;
                    let text = product.name;
                    if (product.discount > 0) {
                        text += ' (Current: ' + product.discount.toFixed(0) + '%)';
                    }
                    option.text = text;
                    productSelect.appendChild(option);
                });
            }
        }
    }
</script>

<script src="./libraries/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>

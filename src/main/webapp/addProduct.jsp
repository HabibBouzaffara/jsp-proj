<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 40px;
            margin: 50px auto;
            max-width: 600px;
        }
    </style>
</head>
<body>
<%@ include file="shared/navbar.jsp" %>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Add New Product</h2>
        <form method="post" action="addProduct">
            <input type="hidden" name="categoryName" value="<%= request.getAttribute("categoryName") %>">

            <div class="mb-3">
                <label class="form-label">Category</label>
                <input type="text" class="form-control" value="<%= request.getAttribute("categoryName") %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Product Name</label>
                <input type="text" name="productName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Price ($)</label>
                <input type="number" step="0.01" name="price" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Discount (%)</label>
                <input type="number" step="0.01" name="discount" class="form-control" min="0" max="100" value="0">
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary flex-grow-1">Add Product</button>
                <a href="categories" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="shared/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Category</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libraries/bootstrap/bootstrap.min.css">
    <style>
        .product-row { margin-bottom: 10px; }
    </style>
</head>
<body class="container py-4">

<h1 class="text-center mb-4">Add New Category</h1>

<form action="<%=request.getContextPath()%>/addCategory" method="post" enctype="multipart/form-data" class="mx-auto" style="max-width:600px;">

    <!-- CATEGORY NAME -->
    <div class="mb-3">
        <label for="name" class="form-label">Category Name</label>
        <input type="text" class="form-control" id="name" name="name" required>
    </div>

    <!-- CATEGORY DESCRIPTION -->
    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
    </div>

    <!-- CATEGORY IMAGE -->
    <div class="mb-3">
        <label for="image" class="form-label">Category Image</label>
        <input type="file" class="form-control" id="image" name="image" accept="image/*">
    </div>

    <!-- PRODUCTS -->
    <h4 class="mt-4">Products (optional)</h4>
    <div id="products-container">
        <!-- Product rows will be added here -->
    </div>
    <button type="button" class="btn btn-outline-success mb-3" onclick="addProduct()">+ Add Product</button>

    <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">Add Category</button>
        <a href="<%=request.getContextPath()%>/categories" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<script>
    let productIndex = 0;
    function createProductFields(index) {
        return `
        <h5>Product ${index + 1}</h5>

        <div class="mb-2">
            <label class="form-label">Name</label>
            <input type="text" name="products[${index}][name]" class="form-control" required>
        </div>

        <div class="mb-2">
            <label class="form-label">Price</label>
            <input type="number" step="0.01" name="products[${index}][price]" class="form-control" required>
        </div>

        <div class="mb-2">
            <label class="form-label">Description</label>
            <textarea name="products[${index}][description]" class="form-control" rows="2"></textarea>
        </div>

        <!-- NEW: Product Image Upload -->
        <div class="mb-2">
            <label class="form-label">Product Image</label>
            <input type="file" name="products[${index}][image]" class="form-control" accept="image/*">
        </div>

        <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove()">Remove Product</button>
    `;
    }

    function addProduct() {
        const container = document.getElementById('products-container');

        const row = document.createElement('div');
        row.classList.add('product-row', 'border', 'p-3', 'rounded');

        row.innerHTML = createProductFields(productIndex);

        container.appendChild(row);
        productIndex++;
    }

</script>

</body>
</html>

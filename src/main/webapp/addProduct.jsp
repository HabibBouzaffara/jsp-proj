<%@ page import="org.example.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
</head>
<body class="container py-4">

<%
    String categoryName = request.getParameter("category");
%>

<h2 class="mb-4">Add Product to <span class="text-primary"><%= categoryName %></span></h2>

<form action="<%=request.getContextPath()%>/addProduct"
      method="post"
      enctype="multipart/form-data"
      class="mx-auto" style="max-width:500px;">

    <input type="hidden" name="category" value="<%= categoryName %>">

    <!-- PRODUCT NAME -->
    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" name="name" class="form-control" required>
    </div>

    <!-- PRODUCT PRICE -->
    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="number" name="price" step="0.01" class="form-control" required>
    </div>

    <!-- PRODUCT DESCRIPTION -->
    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="description" class="form-control" rows="3"></textarea>
    </div>

    <!-- PRODUCT IMAGE -->
    <div class="mb-3">
        <label class="form-label">Product Image</label>
        <input type="file" name="image" class="form-control" accept="image/*">
    </div>

    <div class="d-flex gap-2">
        <button class="btn btn-success" type="submit">Add Product</button>
        <a href="<%=request.getContextPath()%>/categories" class="btn btn-secondary">Cancel</a>
    </div>
</form>

</body>
</html>

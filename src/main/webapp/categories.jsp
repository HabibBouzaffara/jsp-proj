<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
  <title>IIT/GR3 - Categories</title>
  <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">

  <style>
    /* Category card */
    /* Category card – FIXED SIZE */
    .category-card {
      cursor: pointer;
      transition: transform 0.2s ease, box-shadow 0.2s ease;

      width: 250px;
      height: 260px;

      display: flex;
      flex-direction: column;
      overflow: hidden;
      border-radius: 8px;
    }
    .category-card:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    /* Category image – FIXED HEIGHT */
    .category-img {
      width: 100%;
      height: 140px;          /* fixed image height */
      object-fit: cover;
      flex-shrink: 0;

      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }

    /* Ensure text stays inside the card */
    .category-card .card-body {
      flex: 1;                /* text takes remaining space */
      overflow: hidden;
      padding: 10px;
      text-align: center;
    }

    .category-card .card-title,
    .category-card .card-text {
      margin: 0;
      overflow: hidden;
      text-overflow: ellipsis; /* … if too long */
      white-space: nowrap;
      font-size: 0.9rem;
    }

    /* Add Category button styling */
    .add-card {
      width: 180px;
      height: 260px;
      border: 2px dashed #888;
      border-radius: 8px;
      cursor: pointer;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      transition: background 0.25s ease, transform 0.2s ease;
    }
    .add-card:hover {
      background: #f0f0f0;
      transform: scale(1.05);
    }

    /* Hide horizontal scrollbar entirely */
    .scroll-hidden::-webkit-scrollbar {
      display: none;
    }
    .scroll-hidden {
      -ms-overflow-style: none;  /* IE, Edge */
      scrollbar-width: none;     /* Firefox */
    }

    .product-list {
      margin-top: 40px;
    }

    /* Sticky + Add Category card */
    .sticky-card {
      width: 180px;
      height: 270px;
      border: 2px dashed #888;
      border-radius: 8px;
      cursor: pointer;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;

      position: sticky;
      left: 0;
      background: white;
      z-index: 5;

      transition: transform 0.2s, background 0.2s;
    }
    .sticky-card:hover {
      background: #f0f0f0;
      transform: scale(1.05);
    }

    /* Categories scroll */
    .d-flex.flex-row {
      overflow-x: auto;
      white-space: nowrap;
    }

    /* Hide scrollbar again */
    .d-flex.flex-row::-webkit-scrollbar {
      display: none;
    }
    .d-flex.flex-row {
      -ms-overflow-style: none;
      scrollbar-width: none;
    }


  </style>
</head>
<body class="container py-4">

<%@ include file="shared/navbar.jsp" %>

<h1 class="text-center mb-4">Categories</h1>

<%
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  if (categories != null && !categories.isEmpty()) {
%>

<!-- HORIZONTAL LIST (NO SCROLLBAR VISIBLE) -->

<div class="d-flex flex-row gap-3 pb-3 position-relative" style="overflow-x: auto; white-space: nowrap;">

  <!-- FIXED + ADD CATEGORY -->
  <div class="add-card sticky-card px-4" onclick="window.location.href='addCategory'">
    <h1 style="font-size: 60px; margin: 0">+</h1>
    <p class="mt-2 mb-0">Add Category</p>
  </div>

  <% for (Category category : categories) { %>
  <div style="display: inline-block;">
    <div class="card category-card" onclick="showProducts('<%= category.getName() %>')">
      <img src="<%= category.getImagePath() != null ? category.getImagePath() : "assets/img/default.jpg" %>"
           class="category-img"
           alt="<%= category.getName() %>">



      <div class="card-body text-center">
        <h5 class="card-title"><%= category.getName() %></h5>
        <p class="card-text text-muted"><%= category.getDescription() %></p>
      </div>
    </div>

    <!-- Hidden Products -->
    <div id="products-<%= category.getName() %>" class="d-none">
      <div class="d-flex flex-wrap justify-content-center gap-3 mt-3">

        <!-- Add Product button -->
        <div class="add-card" style="width:150px; height:200px;"
             onclick="window.location.href='addProduct?category=<%= category.getName() %>'">
          <h1 style="font-size:40px; margin:0;">+</h1>
          <p class="mb-0">Add Product</p>
        </div>

        <% if (category.getProducts() != null && !category.getProducts().isEmpty()) {
          for (Product p : category.getProducts()) {
            request.setAttribute("product", p);
        %>
        <jsp:include page="shared/produitCarte.jsp" />
        <%   }
        } else { %>
        <p class="text-muted">No products available </p>

        <% } %>

      </div>
    </div>

  </div>
  <% } %>
</div>


<!-- Selected product display -->
<div id="selected-products" class="product-list text-center"></div>

<% } else {  %>
<p>No categories found.</p>
<% } %>

<script>
  function showProducts(categoryName) {
    const container = document.getElementById('selected-products');
    const selectedDiv = document.getElementById('products-' + categoryName);

    container.innerHTML = '';

    const clone = selectedDiv.cloneNode(true);
    clone.classList.remove('d-none');

    const title = document.createElement('h3');
    title.textContent = categoryName + " Products";
    title.classList.add('mb-3');

    container.appendChild(title);
    container.appendChild(clone);
  }
</script>

</body>
</html>

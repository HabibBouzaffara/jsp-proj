<%@ page import="org.example.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
%>
<p class="text-danger">No product data provided.</p>
<%
} else {
%>

<div class="card product-card shadow-sm" style="width: 18rem;">
    <img src="assets/img/Electronics.jpg" class="card-img-top" alt="<%= product.getName() %>" style="height: 180px; object-fit: cover;">
    <div class="card-body text-center">
        <h5 class="card-title"><%= product.getName() %></h5>
        <p class="card-text text-muted"><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>
        <button class="btn btn-primary" onclick="buyProduct('<%= product.getName() %>')">Buy</button>
    </div>
</div>

<%
    }
%>

<%@ page import="org.example.model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
    if (product != null) {
%>
<div class="card" style="width: 200px; height: 300px;">
    <img src="<%= product.getImagePath() %>" class="card-img-top" style="height: 120px; object-fit: cover;" alt="<%= product.getName() %>">
    <div class="card-body d-flex flex-column">
        <h6 class="card-title"><%= product.getName() %></h6>
        <p class="card-text text-muted" style="font-size: 0.85rem; flex-grow: 1;">
            <%= product.getDescription() %>
        </p>

        <% if (product.getDiscount() > 0) { %>
        <div class="mb-2">
            <span class="badge bg-danger"><%= String.format("%.0f%% OFF", product.getDiscount()) %></span>
            <div>
                <del class="text-muted">$<%= String.format("%.2f", product.getPrice()) %></del>
                <strong class="text-success"> $<%= String.format("%.2f", product.getFinalPrice()) %></strong>
            </div>
        </div>
        <% } else { %>
        <p class="fw-bold mb-2">$<%= String.format("%.2f", product.getPrice()) %></p>
        <% } %>

        <div class="d-flex gap-1">
            <form method="post" action="cart" class="flex-grow-1">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <input type="hidden" name="categoryId" value="<%= product.getCategoryId() %>">
                <button type="submit" class="btn btn-primary btn-sm w-100">Add to Cart</button>
            </form>
            <form method="post" action="removeProduct">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <input type="hidden" name="categoryId" value="<%= product.getCategoryId() %>">
                <button type="submit" class="btn btn-danger btn-sm">x</button>
            </form>
        </div>
    </div>
</div>
<% } %>

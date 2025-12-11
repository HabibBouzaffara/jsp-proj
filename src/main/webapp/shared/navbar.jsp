
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
</head>
<body>
    <% String fullname = (String) session.getAttribute("fullname"); %>

    <nav class="navbar navbar-expand-lg bg-light shadow-sm p-3">
        <div class="container-fluid d-flex justify-content-between align-items-center">

            <!-- Left side: brand + links -->
            <div class="d-flex align-items-center gap-4">
                <a class="navbar-brand text-dark fw-bold" href="home">IIT Store</a>
                <a class="nav-link text-dark fw-semibold" href="categories">Produits</a>
            </div>

            <!-- Right side: user name -->

            <% if (fullname != null) { %>
            <span class="navbar-text text-secondary fw-bold"><%= fullname %></span>
            <% } %>

        </div>
    </nav>

    <!-- Optional: Custom hover style -->
    <style>
        .nav-link:hover,
        .navbar-brand:hover {
            color: #0d6efd !important; /* subtle hover blue, not background blue */
            text-decoration: none;
        }

        .navbar {
            border-radius: 8px;
        }
    </style>


</body>
<body>

</body>
</html>

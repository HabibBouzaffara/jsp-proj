<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in as admin
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Products - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar {
            background: #2c3e50;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .sidebar {
            position: fixed;
            left: 0;
            top: 60px;
            width: 250px;
            height: calc(100vh - 60px);
            background: #34495e;
            padding: 20px 0;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 15px 25px;
            text-decoration: none;
        }
        .sidebar a:hover, .sidebar a.active { background: #2c3e50; }
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .btn-add {
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: right;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        table th { background: #f8f9fa; font-weight: bold; }
        .btn-action {
            padding: 6px 12px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-edit { background: #3498db; color: white; }
        .btn-delete { background: #e74c3c; color: white; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>⚙️ Admin - Product Management</h1>
        <a href="../LogoutServlet" style="color: white; text-decoration: none;">Logout</a>
    </nav>

    <div class="sidebar">
        <a href="dashboard.jsp">📊 Dashboard</a>
        <a href="products.jsp" class="active">📦 Products</a>
        <a href="categories.jsp">🏷️ Categories</a>
        <a href="orders.jsp">🛍️ Orders</a>
        <a href="users.jsp">👥 Users</a>
    </div>

    <div class="main-content">
        <div class="section">
            <h2>Product Management</h2>
            <button class="btn-add" onclick="window.location.href='addProduct.jsp'">+ Add New Product</button>
            <div style="clear: both;"></div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Laptop</td>
                        <td>Electronics</td>
                        <td>$999.99</td>
                        <td>45</td>
                        <td>Active</td>
                        <td>
                            <button class="btn-action btn-edit">Edit</button>
                            <button class="btn-action btn-delete">Delete</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>T-Shirt</td>
                        <td>Clothing</td>
                        <td>$19.99</td>
                        <td>120</td>
                        <td>Active</td>
                        <td>
                            <button class="btn-action btn-edit">Edit</button>
                            <button class="btn-action btn-delete">Delete</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Coffee Beans</td>
                        <td>Food</td>
                        <td>$12.99</td>
                        <td>78</td>
                        <td>Active</td>
                        <td>
                            <button class="btn-action btn-edit">Edit</button>
                            <button class="btn-action btn-delete">Delete</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
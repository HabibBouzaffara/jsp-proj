<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in as admin
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
        .navbar h1 { font-size: 24px; }
        .btn-logout {
            background: #e74c3c;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
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
            transition: 0.3s;
        }
        .sidebar a:hover, .sidebar a.active {
            background: #2c3e50;
        }
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .stat-card h3 { color: #666; font-size: 14px; margin-bottom: 10px; }
        .stat-card .value { font-size: 32px; font-weight: bold; color: #2c3e50; }
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .section h2 { color: #2c3e50; margin-bottom: 20px; }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        table th {
            background: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
        }
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
        .btn-add {
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: right;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>⚙️ Admin Dashboard</h1>
        <div>
            <span style="margin-right: 20px;">Welcome, <%= username %>!</span>
            <form action="../LogoutServlet" method="post" style="display: inline;">
                <button type="submit" class="btn-logout">Logout</button>
            </form>
        </div>
    </nav>

    <div class="sidebar">
        <a href="dashboard.jsp" class="active">📊 Dashboard</a>
        <a href="products.jsp">📦 Products</a>
        <a href="categories.jsp">🏷️ Categories</a>
        <a href="orders.jsp">🛍️ Orders</a>
        <a href="users.jsp">👥 Users</a>
        <a href="discounts.jsp">💰 Discounts</a>
        <a href="reports.jsp">📈 Reports</a>
    </div>

    <div class="main-content">
        <h1>Dashboard Overview</h1>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>TOTAL PRODUCTS</h3>
                <div class="value">156</div>
            </div>
            <div class="stat-card">
                <h3>TOTAL ORDERS</h3>
                <div class="value">1,234</div>
            </div>
            <div class="stat-card">
                <h3>TOTAL USERS</h3>
                <div class="value">567</div>
            </div>
            <div class="stat-card">
                <h3>REVENUE (TODAY)</h3>
                <div class="value">$12,456</div>
            </div>
        </div>

        <div class="section">
            <h2>Recent Orders</h2>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Product</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#10234</td>
                        <td>John Doe</td>
                        <td>Laptop</td>
                        <td>$999.99</td>
                        <td>Pending</td>
                        <td>
                            <button class="btn-action btn-edit">View</button>
                            <button class="btn-action btn-delete">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>#10233</td>
                        <td>Jane Smith</td>
                        <td>T-Shirt</td>
                        <td>$19.99</td>
                        <td>Completed</td>
                        <td>
                            <button class="btn-action btn-edit">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>#10232</td>
                        <td>Bob Johnson</td>
                        <td>Coffee Beans</td>
                        <td>$12.99</td>
                        <td>Shipped</td>
                        <td>
                            <button class="btn-action btn-edit">View</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="section">
            <h2>Low Stock Alert</h2>
            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Current Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Laptop</td>
                        <td>Electronics</td>
                        <td style="color: #e74c3c; font-weight: bold;">3</td>
                        <td>
                            <button class="btn-action btn-edit">Restock</button>
                        </td>
                    </tr>
                    <tr>
                        <td>T-Shirt (Blue)</td>
                        <td>Clothing</td>
                        <td style="color: #e74c3c; font-weight: bold;">5</td>
                        <td>
                            <button class="btn-action btn-edit">Restock</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
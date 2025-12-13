# E-Shop JSP Project

## Overview
A simple e-commerce web application built with JSP, Servlets, and Java. Features separate interfaces for clients and administrators with role-based access control.

## Features

### Client Interface
- Browse products by category
- View product details
- Add products to shopping cart
- Filter products by category
- Simple and intuitive UI

### Admin Interface
- Dashboard with statistics
- Product management (CRUD operations)
- Category management
- Order tracking
- User management
- Inventory monitoring

## Architecture

```
src/
├── main/
│   ├── java/
│   │   └── com/eshop/
│   │       ├── servlet/         # Servlets for request handling
│   │       │   ├── LoginServlet.java
│   │       │   └── LogoutServlet.java
│   │       ├── model/           # Data models (POJOs)
│   │       │   ├── User.java
│   │       │   └── Product.java
│   │       └── filter/          # Security filters
│   │           └── AuthenticationFilter.java
│   └── webapp/
│       ├── login.jsp            # Login page
│       ├── client/             # Client area (customer interface)
│       │   ├── shop.jsp
│       │   └── cart.jsp
│       └── admin/              # Admin area (management interface)
│           ├── dashboard.jsp
│           └── products.jsp
```

## Technology Stack
- **Backend:** Java Servlets, JSP
- **Frontend:** HTML, CSS, JavaScript
- **Server:** Apache Tomcat
- **Build Tool:** Maven

## Setup Instructions

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9 or higher
- Maven 3.6+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/HabibBouzaffara/jsp-proj.git
cd jsp-proj
```

2. Build the project:
```bash
mvn clean package
```

3. Deploy to Tomcat:
- Copy the generated WAR file from `target/` to Tomcat's `webapps/` directory
- Or configure your IDE to deploy directly to Tomcat

4. Start Tomcat server

5. Access the application:
```
http://localhost:8080/jsp-proj/login.jsp
```

## Demo Credentials

### Admin Account
- **Username:** admin
- **Password:** admin123
- **Access:** Full admin dashboard with management capabilities

### Client Account
- **Username:** client
- **Password:** client123
- **Access:** Shopping interface with cart functionality

## Key Improvements

### From Original Version
1. **Separation of Concerns:** Clear distinction between client and admin interfaces
2. **Authentication System:** Secure login with session management
3. **Role-Based Access:** Different features for different user types
4. **Simplified Code:** Clean, readable, well-commented code
5. **Better Structure:** Organized packages and logical file hierarchy
6. **Security:** Authentication filter to protect routes
7. **User Experience:** Modern, responsive UI design

## Code Structure Explanation

### Servlets
- **LoginServlet:** Handles authentication, validates credentials, creates sessions
- **LogoutServlet:** Handles logout, cleans up sessions

### Models
- **User:** Represents user data (username, role, etc.)
- **Product:** Represents product data (name, price, stock, etc.)

### Filters
- **AuthenticationFilter:** Intercepts requests to protected pages, checks authentication

### JSP Pages
- **login.jsp:** Entry point for all users
- **client/shop.jsp:** Product browsing for customers
- **client/cart.jsp:** Shopping cart functionality
- **admin/dashboard.jsp:** Admin overview with statistics
- **admin/products.jsp:** Product management interface

## Future Enhancements

1. **Database Integration:** Replace hardcoded data with MySQL/PostgreSQL
2. **Payment Gateway:** Integrate payment processing
3. **Email Notifications:** Order confirmations and updates
4. **Image Upload:** Product images functionality
5. **Advanced Search:** Full-text search capabilities
6. **Reports:** Sales reports and analytics
7. **Password Hashing:** Secure password storage with BCrypt
8. **AJAX:** Dynamic updates without page reload

## Contributing
Feel free to fork this project and submit pull requests for improvements!

## License
MIT License

## Author
Habib Bouzaffara

## Contact
For questions or suggestions, please open an issue on GitHub.

package com.eshop.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * AuthenticationFilter - Protects pages that require authentication
 * Checks if user is logged in before allowing access
 */
@WebFilter({"/admin/*", "/client/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User is logged in, check role-based access
            String role = (String) session.getAttribute("role");
            
            // Admin trying to access client area or vice versa
            if (requestURI.contains("/admin/") && !"admin".equals(role)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }
            if (requestURI.contains("/client/") && !"client".equals(role)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }
            
            // Allow request to proceed
            chain.doFilter(request, response);
        } else {
            // User not logged in - redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
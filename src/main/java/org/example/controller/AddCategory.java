package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.model.Category;
import org.example.model.Product;
import org.example.repository.CategoryRepository;
import org.example.service.CategoryService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addCategory")
@MultipartConfig
public class AddCategory extends HttpServlet {

    private CategoryService categoryService;
    private CategoryRepository categoryRepository;

    @Override
    public void init() throws ServletException {
        super.init();
        categoryService = new CategoryService();
        categoryRepository = CategoryRepository.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/addCategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String discountStr = request.getParameter("discount");

        if (name == null || name.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/addCategory");
            return;
        }

        // Create new category
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);

        // Set discount if provided
        if (discountStr != null && !discountStr.isEmpty()) {
            try {
                double discount = Double.parseDouble(discountStr);
                category.setDiscount(discount);
            } catch (NumberFormatException e) {
                category.setDiscount(0.0);
            }
        }

        // Handle category image
        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/assets/img/");
            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdirs();

            imagePart.write(uploadPath + File.separator + fileName);
            category.setImagePath("assets/img/" + fileName);
        }

        // Add category first to get its ID
        categoryService.addCategory(category);

        // Handle products (optional)
        List<Product> products = new ArrayList<>();
        int index = 0;
        while (true) {
            String pname = request.getParameter("products[" + index + "][name]");
            String pprice = request.getParameter("products[" + index + "][price]");
            String pdesc = request.getParameter("products[" + index + "][description]");
            String pdiscount = request.getParameter("products[" + index + "][discount]");

            if (pname == null) break;

            double price = 0;
            try {
                price = Double.parseDouble(pprice);
            } catch (NumberFormatException ignored) {}

            // Create product with ID and category reference
            Product p = new Product(
                    categoryRepository.getNextProductId(),
                    pname,
                    price,
                    pdesc,
                    category.getId()
            );

            // Set product discount (inherit from category or use specific)
            if (pdiscount != null && !pdiscount.isEmpty()) {
                try {
                    p.setDiscount(Double.parseDouble(pdiscount));
                } catch (NumberFormatException e) {
                    p.setDiscount(category.getDiscount());
                }
            } else {
                p.setDiscount(category.getDiscount());
            }

            // Handle product image
            Part pimage = request.getPart("products[" + index + "][image]");
            if (pimage != null && pimage.getSize() > 0) {
                String pFileName = Paths.get(pimage.getSubmittedFileName()).getFileName().toString();
                String pUploadPath = getServletContext().getRealPath("/assets/img/products/");
                File pfolder = new File(pUploadPath);
                if (!pfolder.exists()) pfolder.mkdirs();

                pimage.write(pUploadPath + File.separator + pFileName);
                p.setImagePath("assets/img/products/" + pFileName);
            }

            products.add(p);
            index++;
        }

        // Set products to category
        category.setProducts(products);

        response.sendRedirect(request.getContextPath() + "/categories");
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booknest.servlet;

import com.booknest.dao.BookDAO;
import com.booknest.model.Book;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/addToCart", "/removeFromCart", "/updateQty"})
public class CartServlet extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/addToCart".equals(path)) {

            int bookId = Integer.parseInt(request.getParameter("bookId"));

            HttpSession session = request.getSession();

            Map<Integer, Integer> cart =
                    (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            cart.put(bookId, cart.getOrDefault(bookId, 0) + 1);

            session.setAttribute("cart", cart);

            session.setAttribute("successMsg", "✅ Book added to cart");
response.sendRedirect(request.getContextPath() + "/books");
} else if ("/updateQty".equals(path)) {

    int bookId = Integer.parseInt(request.getParameter("bookId"));
    String action = request.getParameter("action");

    HttpSession session = request.getSession();

    Map<Integer, Integer> cart =
            (Map<Integer, Integer>) session.getAttribute("cart");

    if (cart != null && cart.containsKey(bookId)) {

        int qty = cart.get(bookId);

        if ("plus".equals(action)) {
            cart.put(bookId, qty + 1);
        } else if ("minus".equals(action)) {

            if (qty > 1) {
                cart.put(bookId, qty - 1);
            } else {
                cart.remove(bookId);
            }
        }
    }

    session.setAttribute("cart", cart);

    response.sendRedirect(request.getContextPath() + "/cart");
    
        } else if ("/removeFromCart".equals(path)) {

            int bookId = Integer.parseInt(request.getParameter("bookId"));

            HttpSession session = request.getSession();

            Map<Integer, Integer> cart =
                    (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart != null) {
                cart.remove(bookId);
            }

            session.setAttribute("cart", cart);

            response.sendRedirect(request.getContextPath() + "/cart");

        } else {

            HttpSession session = request.getSession();

            Map<Integer, Integer> cart =
                    (Map<Integer, Integer>) session.getAttribute("cart");

            Map<Book, Integer> cartItems = new LinkedHashMap<>();

            double total = 0.0;

            if (cart != null) {

                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

                    Book book = bookDAO.getBookById(entry.getKey());

                    if (book != null) {
                        cartItems.put(book, entry.getValue());
                        total += book.getPrice() * entry.getValue();
                    }
                }
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);

            request.getRequestDispatcher("/cart.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
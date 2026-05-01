package com.booknest.servlet;

import com.booknest.dao.BookDAO;
import com.booknest.model.Book;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BookDAO dao = new BookDAO();
        String category = request.getParameter("category");
String search = request.getParameter("search");

List<Book> books;

if(search != null && !search.trim().isEmpty()){

    books = dao.searchBooks(search);

}
else if(category != null && !category.trim().isEmpty()){

    books = dao.getBooksByCategory(category);

}
else{

    books = dao.getAllBooks();

}

        request.setAttribute("books", books);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
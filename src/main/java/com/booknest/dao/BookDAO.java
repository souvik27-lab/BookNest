/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booknest.dao;

import com.booknest.model.Book;
import com.booknest.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    // =====================================
    // Convert ResultSet row -> Book Object
    // =====================================
    private Book mapBook(ResultSet rs) throws SQLException {

        Book b = new Book();

        b.setId(rs.getInt("id"));
        b.setTitle(rs.getString("title"));
        b.setAuthor(rs.getString("author"));
        b.setPrice(rs.getDouble("price"));
        b.setQuantity(rs.getInt("quantity"));
        b.setCategory(rs.getString("category"));
        b.setEmoji(rs.getString("emoji"));
        b.setImage(rs.getString("image"));   // NEW IMAGE FIELD

        return b;
    }

    // =====================================
    // Get All Books
    // =====================================
    public List<Book> getAllBooks() {

        List<Book> books = new ArrayList<>();

        String sql = "SELECT * FROM books";

        try {

            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                books.add(mapBook(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return books;
    }

    // =====================================
    // Search Books
    // =====================================
    public List<Book> searchBooks(String keyword) {

        List<Book> books = new ArrayList<>();

        String sql =
        "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                books.add(mapBook(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return books;
    }

    // =====================================
    // Get Books By Category
    // =====================================
    public List<Book> getBooksByCategory(String category) {

        List<Book> books = new ArrayList<>();

        String sql =
        "SELECT * FROM books WHERE category = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                books.add(mapBook(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return books;
    }

    // =====================================
    // Get Book By ID
    // =====================================
    public Book getBookById(int id) {

        String sql =
        "SELECT * FROM books WHERE id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapBook(rs);
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return null;
    }
}
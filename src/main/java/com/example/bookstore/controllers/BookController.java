//package controller;
//
//import model.Book;
//import service.IBookService;
//import serviceImpl.BookServiceImpl;
//
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/books")
//public class BookController extends HttpServlet {
//    private IBookService bookService;
//
//    @Override
//    public void init() {
//        bookService = new BookServiceImpl();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        List<Book> books = bookService.getAllBooks();
//        request.setAttribute("books", books);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/browse_books.jsp");
//        dispatcher.forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String title = request.getParameter("title");
//        String author = request.getParameter("author");
//        double price = Double.parseDouble(request.getParameter("price"));
//
//        Book newBook = new Book(title, author, price);
//        boolean isAdded = bookService.addBook(newBook);
//
//        if (isAdded) {
//            response.sendRedirect("books");
//        } else {
//            request.setAttribute("error", "Failed to add book.");
//            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/add_book.jsp");
//            dispatcher.forward(request, response);
//        }
//    }
//}

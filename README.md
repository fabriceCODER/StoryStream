# Online Bookstore

## Overview
The **Online Bookstore** is a web-based application that allows users to browse, search, and purchase books. Admins can manage the book inventory, and the system supports internationalization with multiple languages, including **Kinyarwanda, English, Spanish, French, and Kiswahili**. The project follows the **MVC architecture** and implements **Servlets, JSP, and PostgreSQL** for backend functionality.

## Features
- **User Management:** Login, registration, and authentication.
- **Book Browsing & Search:** Users can search and filter books by category.
- **Shopping Cart & Checkout:** Users can add books to the cart and place orders.
- **Admin Panel:** Manage book inventory and view orders.
- **Security:** Role-based access control to restrict admin pages.
- **Internationalization:** Multi-language support for login and registration pages.

## Technologies Used
- **Backend:** Java, Servlets, JSP
- **Frontend:** HTML, CSS, JSTL
- **Database:** PostgreSQL
- **Development Tools:** IntelliJ IDEA
- **Build & Deployment:** Apache Tomcat

## Folder Structure
```
OnlineBookstore/
│── src/
│   ├── main/
│   │   ├── java/com/example/bookstore/
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   ├── dao/
│   │   │   ├── daoImpl/
│   │   │   ├── services/
│   │   │   ├── servicesImpl/
│   ├── webapp/
│   │   ├── WEB-INF/
│   │   ├── pages/
│   │   │   ├── login.jsp
│   │   │   ├── register.jsp
│   │   │   ├── browse-books.jsp
│   │   │   ├── cart.jsp
│   │   │   ├── checkout.jsp
│   │   │   ├── admin/
│   │   ├── css/
│   │   ├── i18n/
│   │   ├── index.jsp
│── .gitignore
│── .env
│── README.md
```

## Setup & Installation
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/fabriceCODER/StoryStream.git
   ```
2. **Set up the Database:**
   - Install PostgreSQL and create a database:
     ```sql
     CREATE DATABASE online_bookstore;
     ```
   - Update `.env` with database credentials.
3. **Configure Apache Tomcat in IntelliJ IDEA.**
4. **Run the Project:**
   - Build and deploy the application.
   - Access the app at `http://localhost:8080/online-bookstore/`

## Security & Authentication
- Session-based authentication ensures secure access.
- Admin pages are restricted based on user roles.

## Future Enhancements
- Implement payment gateway integration.
- Add book reviews and ratings.
- Enhance search functionality with filters.

## License
This project is open-source and licensed under the **MIT License**.


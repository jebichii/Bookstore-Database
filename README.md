# Bookstore Database Management System

## Project Description
This project involves designing and implementing a relational database to manage the operations of a bookstore. The database efficiently stores information about books, authors, customers, orders, shipping methods, and more. By applying MySQL database design principles, the project offers a hands-on experience in creating, managing, and querying real-world databases.

The system ensures data consistency, security, and allows for effective data retrieval and analysis to support decision-making processes within the bookstore.

---

## Features
- **Book Management**: Store information about books, their authors, publishers, and languages.
- **Customer Management**: Keep track of customer details and their associated addresses.
- **Order Tracking**: Manage customer orders, order history, and statuses.
- **Shipping Methods**: Define and maintain shipping options for orders.
- **Database Security**: Implement user roles and permissions to ensure safe and controlled database access.
- **Data Analysis**: Run queries to retrieve meaningful insights, such as order details, total sales, and customer activities.

---

## Tools and Technologies
- **MySQL**: For building and managing the relational database.
- **Draw.io**: For visualizing the database schema and relationships.
- **SQL Queries**: For testing and analyzing data.

---

## Database Schema
The database includes the following tables:

1. **book**: Stores details of books available in the store.
2. **author**: Maintains a record of authors.
3. **book_author**: Represents the many-to-many relationship between books and authors.
4. **book_language**: Lists possible book languages.
5. **publisher**: Stores publisher information.
6. **customer**: Contains customer data.
7. **customer_address**: Maps customers to their addresses.
8. **address**: Stores address details.
9. **country**: Lists countries associated with addresses.
10. **address_status**: Indicates the status of an address (e.g., current, old).
11. **cust_order**: Stores customer orders.
12. **order_line**: Contains details about books within each order.
13. **shipping_method**: Lists available shipping options.
14. **order_history**: Tracks the status
    ##entity relational disgram
    ![image](https://github.com/user-attachments/assets/86ce2f12-4136-4ef0-9208-3311b117dafb)

package org.course.coursewebapplication;



import java.sql.*;

public class CourseFetcher {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/course_enrollment_system";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static void main(String[] args) {
        String query = "SELECT id, title, description, instructor, price, duration FROM courses";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            System.out.println("=== Course List ===");
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String instructor = rs.getString("instructor");
                double price = rs.getDouble("price");
                String duration = rs.getString("duration");

                System.out.println("ID: " + id);
                System.out.println("Title: " + title);
                System.out.println("Description: " + description);
                System.out.println("Instructor: " + instructor);
                System.out.println("Price: $" + price);
                System.out.println("Duration: " + duration);
                System.out.println("-----------------------------");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("SQL error occurred.");
            e.printStackTrace();
        }
    }
}

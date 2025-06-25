package org.course.coursewebapplication.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.course.coursewebapplication.dao.CourseDAO;
import org.course.coursewebapplication.model.Course;

import java.io.IOException;
import java.util.List;

@WebServlet("/course")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        // Initialize the DAO
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Validate input (simple example, can be extended)
        if (title == null || description == null || title.isEmpty() || description.isEmpty()) {
            request.setAttribute("error", "Title and description are required.");
            request.getRequestDispatcher("course-form.jsp").forward(request, response);
            return;
        }

        // Save the course to the database (placeholder logic)
        Course course = new Course();
        course.setTitle(title);
        course.setDescription(description);

        boolean success = courseDAO.addCourse(course); // Assuming the DAO method to save course

        if (success) {
            response.sendRedirect("course?success=Course saved successfully.");
        } else {
            request.setAttribute("error", "Error saving the course.");
            request.getRequestDispatcher("course-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch courses from the database
        List<Course> courses = courseDAO.getAllCourses();

        // Set the courses in the request scope
        request.setAttribute("courses", courses);

        // Forward the request to the courses JSP page
        request.getRequestDispatcher("courses.jsp").forward(request, response);
    }
}

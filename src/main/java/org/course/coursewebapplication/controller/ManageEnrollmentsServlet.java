package org.course.coursewebapplication.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.course.coursewebapplication.dao.EnrollmentDAO;
import org.course.coursewebapplication.model.Enrollment;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewallenrollment")
public class ManageEnrollmentsServlet extends HttpServlet {

    private EnrollmentDAO enrollmentDAO;

    @Override
    public void init() throws ServletException {
        enrollmentDAO = new EnrollmentDAO(); // Initialize DAO properly
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Enrollment> enrollments = enrollmentDAO.getAllEnrollments();

            if (enrollments == null || enrollments.isEmpty()) {
                request.setAttribute("message", "No enrollments found.");
            } else {
                request.setAttribute("enrollments", enrollments); // fixed key name for consistency
            }

            request.getRequestDispatcher("manage-enrollments.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading enrollments.");
            request.getRequestDispatcher("error.jsp").forward(request, response); // use forward instead of redirect
        }
    }
}

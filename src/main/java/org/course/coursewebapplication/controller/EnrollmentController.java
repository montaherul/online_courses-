package org.course.coursewebapplication.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.course.coursewebapplication.dao.EnrollmentDAO;
import org.course.coursewebapplication.dao.CourseDAO;
import org.course.coursewebapplication.dao.UserDAO;
import org.course.coursewebapplication.model.Enrollment;
import org.course.coursewebapplication.model.Course;
import org.course.coursewebapplication.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/manage-enrollments")
public class EnrollmentController extends HttpServlet {

    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String searchStudentId = request.getParameter("user_id");

        try {
            if (action != null) {
                switch (action) {
                    case "view":
                        viewEnrollment(request, response);
                        return;
                    case "cancel":
                        cancelEnrollment(request, response);
                        return;
                    default:
                        response.sendRedirect("manage-enrollments.jsp?error=InvalidAction");
                        return;
                }
            }

            // If searching by Student ID
            if (searchStudentId != null && !searchStudentId.trim().isEmpty()) {
                try {
                    int userId = Integer.parseInt(searchStudentId);
                    List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByStudentId(userId);
                    request.setAttribute("enrollments", enrollments);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid Student ID format.");
                }
            } else {
                // Default: List all enrollments
                request.setAttribute("enrollments", enrollmentDAO.getAllEnrollments());
            }

            request.getRequestDispatcher("manage-enrollments.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-enrollments.jsp?error=ServerError");
        }
    }

    private void viewEnrollment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int enrollmentId = Integer.parseInt(request.getParameter("id"));
            Enrollment enrollment = enrollmentDAO.getEnrollmentById(enrollmentId);

            if (enrollment != null) {
                Course course = courseDAO.getCourseById(enrollment.getCourses_id());
                User user = userDAO.getUserById(enrollment.getUser_id());

                request.setAttribute("enrollment", enrollment);
                request.setAttribute("course", course);
                request.setAttribute("user", user);

                request.getRequestDispatcher("view-enrollment.jsp").forward(request, response);
            } else {
                response.sendRedirect("manage-enrollments.jsp?error=EnrollmentNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("manage-enrollments.jsp?error=InvalidEnrollmentId");
        }
    }

    private void cancelEnrollment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int enrollmentId = Integer.parseInt(request.getParameter("id"));
            boolean isDeleted = enrollmentDAO.delete(enrollmentId);

            if (isDeleted) {
                response.sendRedirect("manage-enrollments.jsp?success=EnrollmentCancelled");
            } else {
                response.sendRedirect("manage-enrollments.jsp?error=UnableToCancel");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("manage-enrollments.jsp?error=InvalidEnrollmentId");
        }
    }
}

package org.course.coursewebapplication.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.course.coursewebapplication.dao.CourseMaterialDAO;
import org.course.coursewebapplication.model.CourseMaterial;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/add-course-material")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class AddCourseMaterialServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String materialType = request.getParameter("materialType");
        String content = request.getParameter("content");
        String date = request.getParameter("date");

        Part filePart = request.getPart("filePath");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);
        String filePath = UPLOAD_DIR + "/" + fileName;

        CourseMaterial material = new CourseMaterial();
        material.setCourseId(courseId);
        material.setMaterialType(materialType);
        material.setContent(content);
        material.setFilePath(filePath);
        material.setDate(date);

        CourseMaterialDAO dao = new CourseMaterialDAO();

        boolean success;
        if (dao.courseMaterialExists(courseId)) {
            success = dao.updateCourseMaterial(material);
        } else {
            success = dao.addCourseMaterial(material);
        }

        if (success) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            request.setAttribute("error", "Failed to save course material.");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}

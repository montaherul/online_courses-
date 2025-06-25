package org.course.coursewebapplication.dao;
import org.course.coursewebapplication.model.CourseMaterial;
import org.course.coursewebapplication.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseMaterialDAO {

    // Method to get all materials for a specific course
    public List<CourseMaterial> getCourseMaterials(int courseId) {
        List<CourseMaterial> materials = new ArrayList<>();
        String sql = "SELECT * FROM course_material WHERE courseId = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, courseId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                CourseMaterial material = new CourseMaterial();
                material.setId(resultSet.getInt("id"));
                material.setCourseId(resultSet.getInt("courseId"));
                material.setMaterialType(resultSet.getString("materialType"));
                material.setContent(resultSet.getString("content"));
                material.setFilePath(resultSet.getString("filePath"));
                material.setDate(resultSet.getString("date"));
                materials.add(material);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materials;
    }

    // Add a new course material
    public boolean addCourseMaterial(CourseMaterial material) {
        String query = "INSERT INTO course_material (courseId, materialType, content, filePath, date) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, material.getCourseId());
            statement.setString(2, material.getMaterialType());
            statement.setString(3, material.getContent());
            statement.setString(4, material.getFilePath());
            statement.setString(5, material.getDate());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateCourseMaterial(CourseMaterial material) {
        String query = "UPDATE course_material SET materialType = ?, content = ?, filePath = ?, date = ? WHERE courseId = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, material.getMaterialType());
            statement.setString(2, material.getContent());
            statement.setString(3, material.getFilePath());
            statement.setString(4, material.getDate());
            statement.setInt(5, material.getCourseId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean courseMaterialExists(int courseId) {
        String query = "SELECT id FROM course_material WHERE courseId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public CourseMaterial getCourseMaterialByCourseId(int courseId) {
        String query = "SELECT * FROM course_material WHERE courseId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                CourseMaterial material = new CourseMaterial();
                material.setId(rs.getInt("id"));
                material.setCourseId(rs.getInt("courseId"));
                material.setMaterialType(rs.getString("materialType"));
                material.setContent(rs.getString("content"));
                material.setFilePath(rs.getString("filePath"));
                material.setDate(rs.getString("date"));
                return material;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


}
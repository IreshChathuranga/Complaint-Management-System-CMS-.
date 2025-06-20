package org.example.model;

import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dto.ComplainDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComplainModel {
    private final BasicDataSource dataSource;

    public ComplainModel(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }
    public List<ComplainDto> getComplainsByName(String name) {
        List<ComplainDto> complains = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM complains WHERE name = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, name);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                ComplainDto dto = new ComplainDto();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setComplain(rs.getString("complain"));
                dto.setStatus(rs.getString("status"));
                complains.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return complains;
    }

    public boolean saveComplain(ComplainDto complain) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO complains (name,complain,status) VALUES (?, ?,?)";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, complain.getName());
            pstm.setString(2, complain.getComplain());
            pstm.setString(3, complain.getStatus());

            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteComplainById(String id) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "DELETE FROM complains WHERE id = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateComplain(ComplainDto dto) {
        String sql = "UPDATE complains SET name = ?, complain = ?, status = ? WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, dto.getName());
            pstm.setString(2, dto.getComplain());
            pstm.setString(3, dto.getStatus());
            pstm.setInt(4, dto.getId());

            return pstm.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<ComplainDto> getAllComplains() {
        List<ComplainDto> complains = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM Complains";
            PreparedStatement pstm = connection.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                ComplainDto dto = new ComplainDto();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setComplain(rs.getString("complain"));
                dto.setStatus(rs.getString("status"));
                complains.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return complains;
    }
}

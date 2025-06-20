package org.example.model;

import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dto.UserDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserModel {
    private final BasicDataSource dataSource;

    public UserModel(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }
    public boolean saveUser(UserDto user) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO user (role,name,address,phone, email,password) VALUES (?, ?, ?,?,?,?)";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, user.getRole());
            pstm.setString(2, user.getName());
            pstm.setString(3, user.getAddress());
            pstm.setString(4, String.valueOf(user.getPhone()));
            pstm.setString(5, user.getEmail());
            pstm.setString(6, user.getPassword());

            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean validateUser(String role, String email, String password) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM user WHERE role = ? AND email = ? AND password = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, role);
            pstm.setString(2, email);
            pstm.setString(3, password);

            return pstm.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public UserDto getUserByCredentials(String role, String email, String password) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM user WHERE role = ? AND email = ? AND password = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, role);
            pstm.setString(2, email);
            pstm.setString(3, password);
            ResultSet rs = pstm.executeQuery();

            if (rs.next()) {
                UserDto user = new UserDto();
                user.setName(rs.getString("name"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

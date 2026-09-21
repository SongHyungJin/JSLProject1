package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBmanager;

/**
 * 이메일(아이디) 찾기 DAO. 닉네임으로 가입 이메일 조회.
 */
public class FindEmailDAO {

    public String findEmail(String nickname) {
        String email = null;
        String sql = "SELECT email FROM users WHERE nickname = ?";

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, nickname);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }
}

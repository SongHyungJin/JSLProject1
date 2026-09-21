package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBmanager;

/**
 * 비밀번호 찾기(재설정) DAO. 이메일 존재 확인 + 비밀번호 변경.
 */
public class FindPasswordDAO {

    /** 이메일 가입 여부 확인 */
    public boolean checkEmail(String email) {
        boolean result = false;
        String sql = "SELECT id FROM users WHERE email = ?";

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                result = rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /** 비밀번호 변경 (newPassword 는 이미 해시된 값이 넘어온다) */
    public int updatePassword(String email, String newPassword) {
        int result = 0;
        String sql = "UPDATE users SET password = ? WHERE email = ?";

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newPassword);
            pstmt.setString(2, email);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}

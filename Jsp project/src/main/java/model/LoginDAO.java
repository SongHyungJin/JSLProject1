package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBManager;

/**
 * users 테이블 로그인 조회 담당 DAO
 */
public class LoginDAO {

    /**
     * email + password 가 일치하는 사용자 조회
     * @param dto email, password가 채워진 UserDTO
     * @return 일치하는 사용자 정보(UserDTO), 없으면 null
     */
    public UserDTO login(UserDTO dto) {

        UserDTO result = null;

        // ※ 지금은 비밀번호를 평문 비교합니다. 실제 서비스라면 해시(암호화) 저장/비교를 권장해요.
        String sql = "SELECT id, email, password, nickname, role, language "
                   + "FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getEmail());
            pstmt.setString(2, dto.getPassword());

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result = new UserDTO();
                    result.setId(rs.getLong("id"));
                    result.setEmail(rs.getString("email"));
                    result.setPassword(rs.getString("password"));
                    result.setNickname(rs.getString("nickname"));
                    result.setRole(rs.getString("role"));
                    result.setLanguage(rs.getString("language"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
}
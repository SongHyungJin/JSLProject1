package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DBManager;

/**
 * users 테이블 회원가입 담당 DAO
 */
public class SignupDAO {

    /**
     * 회원가입 (email, password, nickname 만 입력받음 - role/language/created_at/updated_at은 DB 기본값 사용)
     * @param dto email, password, nickname이 채워진 UserDTO
     * @return 성공 시 1(추가된 행 수), 실패 시 0
     */
    public int Signup(UserDTO dto) {

        int result = 0;

        // id는 users_seq 시퀀스로 채번. role/language/created_at/updated_at은 테이블 DEFAULT 값 사용
        String sql = "INSERT INTO users (id, email, password, nickname) "
                   + "VALUES (seq_users.NEXTVAL, ?, ?, ?)";

        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getEmail());
            pstmt.setString(2, dto.getPassword());
            pstmt.setString(3, dto.getNickname());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            // email 또는 nickname UNIQUE 제약 위반(중복)인 경우도 여기로 옴 -> 그냥 실패(0) 처리
            e.printStackTrace();
        }

        return result;
    }
}